package com.civicpulse.shared.util;

import java.io.File;
import java.util.UUID;
import javax.servlet.http.Part;

/** File upload utility for complaint images. */
public class FileUploadUtil {
    private static final String[] ALLOWED = {".jpg", ".jpeg", ".png", ".webp"};

    public static String saveImage(Part filePart, String uploadDir) throws Exception {
        if (filePart == null || filePart.getSize() == 0) return null;
        String name = getFileName(filePart);
        if (name == null || name.isEmpty()) return null;
        String ext = name.substring(name.lastIndexOf(".")).toLowerCase();
        if (!isAllowed(ext)) throw new Exception("Invalid file type. Allowed: JPG, PNG, WEBP");
        String unique = UUID.randomUUID().toString() + ext;
        File dir = new File(uploadDir);
        if (!dir.exists()) dir.mkdirs();
        filePart.write(uploadDir + File.separator + unique);
        return unique;
    }

    private static String getFileName(Part part) {
        for (String t : part.getHeader("content-disposition").split(";"))
            if (t.trim().startsWith("filename")) return t.substring(t.indexOf("=") + 2, t.length() - 1);
        return null;
    }

    private static boolean isAllowed(String ext) {
        for (String a : ALLOWED) if (a.equals(ext)) return true;
        return false;
    }
}
