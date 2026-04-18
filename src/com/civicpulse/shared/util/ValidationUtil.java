package com.civicpulse.shared.util;

/** Input validation and sanitization. */
public class ValidationUtil {
    public static boolean isNullOrEmpty(String v) { return v == null || v.trim().isEmpty(); }
    public static boolean isNotEmpty(String v) { return !isNullOrEmpty(v); }
    public static boolean isValidEmail(String e) { return isNotEmpty(e) && e.matches("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"); }
    public static boolean isValidPhone(String p) { return isNullOrEmpty(p) || p.matches("^[0-9]{10}$"); }
    public static boolean isWithinLength(String v, int max) { return v != null && v.length() <= max; }
    public static String sanitizeHtml(String input) { return input == null ? null : input.replaceAll("<[^>]*>", "").trim(); }
}
