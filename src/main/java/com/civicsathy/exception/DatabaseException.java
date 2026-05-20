package com.civicsathy.exception;

/**
 * Utility class providing helper methods for DatabaseException.
 * 
 * @author Ujjwal
 * @version 1.0
 */
public class DatabaseException extends Exception {
    /**
     * Constructs a new DatabaseException with a message.
     * @param message The error message.
     */
    public DatabaseException(String message) {
        super(message);
    }
}
