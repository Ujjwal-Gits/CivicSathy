package com.civicsathy.exception;

/**
 * Utility class providing helper methods for ValidationException.
 * 
 * @author Ujjwal
 * @version 1.0
 */
public class ValidationException extends Exception {
    /**
     * Constructs a new ValidationException with a message.
     * @param message The error message.
     */
    public ValidationException(String message) {
        super(message);
    }
}
