package com.civicsathy.service;

import io.github.cdimascio.dotenv.Dotenv;
import org.json.JSONArray;
import org.json.JSONObject;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;

/**
 * Service to connect to Google's Gemini AI to analyze incoming citizen complaints.
 * Determines severity, required team, equipment, and estimated time.
 */
/**
 * Service class containing business logic for GeminiService.
 * 
 * @author Ujjwal
 * @version 1.0
 */
public class GeminiService {

    private static final String API_URL = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=";
    private static final int MAX_RETRIES = 3;
    private static String apiKey;

    static {
        try {
            // Load from .env file in the project root directory
            Dotenv dotenv = Dotenv.configure().directory("b:/Advance java/CivicSathy/").ignoreIfMissing().load();
            apiKey = dotenv.get("GEMINI_API_KEY");
            if (apiKey == null || apiKey.isEmpty()) {
                System.err.println("WARNING: GEMINI_API_KEY not found in .env file.");
            } else {
                System.out.println("Gemini API Key loaded successfully (length: " + apiKey.length() + ")");
            }
        } catch (Exception e) {
            System.err.println("Could not load .env file: " + e.getMessage());
        }
    }

    /**
     * Calls Gemini API to analyze the complaint description, category, and image.
     * @return Map containing: severity, team_suggestion, equipment, estimated_hours, team_size
     */
    public static Map<String, Object> analyzeComplaint(String title, String description, String categoryName, String imagePath, String availableTeams, String availableVehicles) {
        Map<String, Object> result = new HashMap<>();

        // These will remain null if API fails — so we know AI didn't run
        result.put("severity", null);
        result.put("team_suggestion", null);
        result.put("equipment", null);
        result.put("team_size", null);
        result.put("vehicle_suggestion", null);
        result.put("vehicle_count", null);

        if (apiKey == null || apiKey.isEmpty()) {
            System.err.println("Skipping Gemini AI analysis: No API Key provided.");
            return result;
        }

        try {
            String prompt = buildPrompt(title, description, categoryName,
                    availableTeams != null ? availableTeams : "General Maintenance",
                    availableVehicles != null ? availableVehicles : "No vehicles available");

            // Build the JSON request body
            JSONObject requestBody = new JSONObject();
            JSONArray contents = new JSONArray();
            JSONObject partsObj = new JSONObject();
            JSONArray partsArr = new JSONArray();

            // Add text prompt
            JSONObject textObj = new JSONObject();
            textObj.put("text", prompt);
            partsArr.put(textObj);

            // Add image if exists
            if (imagePath != null && !imagePath.isEmpty()) {
                try {
                    Path path = Paths.get(imagePath);
                    if (Files.exists(path)) {
                        byte[] fileContent = Files.readAllBytes(path);
                        String base64Image = Base64.getEncoder().encodeToString(fileContent);

                        String mimeType = "image/jpeg";
                        if (imagePath.toLowerCase().endsWith(".png")) mimeType = "image/png";
                        else if (imagePath.toLowerCase().endsWith(".webp")) mimeType = "image/webp";
                        else if (imagePath.toLowerCase().endsWith(".gif")) mimeType = "image/gif";

                        JSONObject imageObj = new JSONObject();
                        JSONObject inlineData = new JSONObject();
                        inlineData.put("mime_type", mimeType);
                        inlineData.put("data", base64Image);
                        imageObj.put("inline_data", inlineData);
                        partsArr.put(imageObj);
                        System.out.println("Image attached to Gemini request: " + imagePath + " (" + mimeType + ", " + fileContent.length + " bytes)");
                    } else {
                        System.err.println("Image file not found at path: " + imagePath);
                    }
                } catch (Exception e) {
                    System.err.println("Failed to read image for Gemini analysis: " + e.getMessage());
                }
            }

            partsObj.put("parts", partsArr);
            partsObj.put("role", "user");
            contents.put(partsObj);
            requestBody.put("contents", contents);

            System.out.println("Sending Gemini API request for complaint: " + title);

            HttpClient client = HttpClient.newBuilder()
                    .connectTimeout(java.time.Duration.ofSeconds(30))
                    .build();

            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(API_URL + apiKey))
                    .header("Content-Type", "application/json")
                    .timeout(java.time.Duration.ofSeconds(120))
                    .POST(HttpRequest.BodyPublishers.ofString(requestBody.toString()))
                    .build();

            // Retry logic for rate limit errors
            HttpResponse<String> response = null;
            for (int attempt = 1; attempt <= MAX_RETRIES; attempt++) {
                response = client.send(request, HttpResponse.BodyHandlers.ofString());
                System.out.println("Gemini API Response Status: " + response.statusCode() + " (attempt " + attempt + ")");
                
                if (response.statusCode() == 429 && attempt < MAX_RETRIES) {
                    long waitMs = 2000L * attempt; // 2s, 4s delay
                    System.out.println("Rate limited. Retrying in " + waitMs + "ms...");
                    Thread.sleep(waitMs);
                } else {
                    break;
                }
            }

            if (response.statusCode() == 200) {
                JSONObject jsonRes = new JSONObject(response.body());
                JSONArray candidates = jsonRes.getJSONArray("candidates");
                if (candidates.length() > 0) {
                    JSONObject content = candidates.getJSONObject(0).getJSONObject("content");
                    JSONArray parts = content.getJSONArray("parts");
                    if (parts.length() > 0) {
                        String text = parts.getJSONObject(0).getString("text");
                        System.out.println("Gemini raw response: " + text);

                        // Clean up the response - remove markdown code fences if present
                        text = text.trim();
                        if (text.startsWith("```json")) {
                            text = text.substring(7);
                        } else if (text.startsWith("```")) {
                            text = text.substring(3);
                        }
                        if (text.endsWith("```")) {
                            text = text.substring(0, text.length() - 3);
                        }
                        text = text.trim();

                        // Parse the JSON string returned by Gemini
                        JSONObject aiData = new JSONObject(text);

                        if (aiData.has("ai_severity")) result.put("severity", aiData.getString("ai_severity"));
                        if (aiData.has("ai_team_suggestion")) result.put("team_suggestion", aiData.getString("ai_team_suggestion"));
                        if (aiData.has("ai_equipment")) result.put("equipment", aiData.getString("ai_equipment"));
                        if (aiData.has("ai_team_size")) result.put("team_size", aiData.getInt("ai_team_size"));
                        if (aiData.has("ai_vehicle_suggestion")) result.put("vehicle_suggestion", aiData.getString("ai_vehicle_suggestion"));
                        if (aiData.has("ai_vehicle_count")) result.put("vehicle_count", aiData.getInt("ai_vehicle_count"));

                        System.out.println("AI Analysis successful: severity=" + result.get("severity") + ", team=" + result.get("team_suggestion") + ", vehicle=" + result.get("vehicle_suggestion"));
                    }
                }
            } else {
                System.err.println("Gemini API Error: HTTP " + response.statusCode());
                System.err.println("Response body: " + response.body());
            }

        } catch (Exception e) {
            System.err.println("Error calling Gemini API: " + e.getMessage());
            e.printStackTrace();
        }

        return result;
    }

    private static String buildPrompt(String title, String description, String categoryName, String availableTeams, String availableVehicles) {
        return "You are an expert civic management AI for Itahari Sub-Metropolitan City in Nepal.\n" +
               "Your PRIMARY task is to analyze the ATTACHED IMAGE to determine what the actual problem is.\n" +
               "IMPORTANT: The image is the most reliable source of truth. The citizen's title and description may be inaccurate or misleading.\n" +
               "For example, if the image shows a damaged road but the title says 'water leakage', you should identify it as road damage.\n\n" +
               "Citizen's Title: " + title + "\n" +
               "Citizen's Description: " + description + "\n" +
               "Category: " + categoryName + "\n\n" +
               "AVAILABLE TEAMS (you MUST choose ONLY from this list):\n" + availableTeams + "\n\n" +
               "AVAILABLE VEHICLES (you MUST choose ONLY from this list):\n" + availableVehicles + "\n\n" +
               "Respond with ONLY a JSON object in this exact format. No markdown, no code fences, no explanation:\n" +
               "{\"ai_severity\": \"(Choose one: LOW, MEDIUM, HIGH, CRITICAL)\", " +
               "\"ai_team_suggestion\": \"(Choose the BEST matching team name from the AVAILABLE TEAMS list above)\", " +
               "\"ai_team_size\": 3, " +
               "\"ai_vehicle_suggestion\": \"(Choose the BEST matching vehicle name from the AVAILABLE VEHICLES list above, or 'None' if no vehicle needed)\", " +
               "\"ai_vehicle_count\": 1, " +
               "\"ai_equipment\": \"(List of tools/equipment needed for the job, comma separated)\"}";
    }
}
