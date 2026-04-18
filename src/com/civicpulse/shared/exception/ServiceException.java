package com.civicpulse.shared.exception;

/** Business logic errors thrown by Service layer. */
public class ServiceException extends Exception {
    public ServiceException(String message) { super(message); }
    public ServiceException(String message, Throwable cause) { super(message, cause); }
}
