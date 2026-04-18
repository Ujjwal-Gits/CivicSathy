package com.civicpulse.shared.util;

/** Password hashing utility. TODO: Implement with BCrypt when jbcrypt jar is added to WEB-INF/lib. */
public class PasswordUtil {
    public static String hashPassword(String plain) { return plain; /* TODO: BCrypt */ }
    public static boolean verifyPassword(String plain, String hashed) { return plain.equals(hashed); /* TODO: BCrypt */ }
}
