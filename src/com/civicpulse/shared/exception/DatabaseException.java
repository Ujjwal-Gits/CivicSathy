package com.civicpulse.shared.exception;

/** Wraps SQLExceptions with user-friendly messages. */
public class DatabaseException extends RuntimeException {
    public DatabaseException(String message) { super(message); }
    public DatabaseException(String message, Throwable cause) { super(message, cause); }
}
