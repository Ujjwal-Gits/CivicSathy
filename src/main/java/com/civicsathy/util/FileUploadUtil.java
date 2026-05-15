package com.civicsathy.util;

import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.util.UUID;

/**
 * Utility class providing helper methods for FileUploadUtil.
 *
 * @author Aastha
 * @version 1.0
 */
public class FileUploadUtil {
    /**
     * Saves an uploaded file part to the server.
     * @param part The Servlet Part object.
     * @param uploadPath The directory to save the file in.
     * @return The unique filename generated.
     * @throws IOException if saving fails.
     */
    public static String saveFile(Part part, String uploadPath) throws IOException {
        File uploadDir = new File(uploadPath);
        if (!uploadDir.exists()) {
            boolean created = uploadDir.mkdirs();
        }

        String fileName = UUID.randomUUID() + "_" + getFileName(part);
        part.write(uploadPath + File.separator + fileName);
        return fileName;
    }

    /**
     * Extracts original filename from HTTP multipart header.
     *
     * @param part uploaded file part
     * @return original filename if found, otherwise "unknown"
     */
    private static String getFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        for (String content : contentDisp.split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(content.indexOf("=") + 2, content.length() - 1);
            }
        }
        return "unknown";
    }
}