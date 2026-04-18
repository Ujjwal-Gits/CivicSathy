package com.civicpulse.shared.exception;

/** Input validation errors with optional field name. */
public class ValidationException extends Exception {
    private String fieldName;
    public ValidationException(String message) { super(message); }
    public ValidationException(String fieldName, String message) { super(message); this.fieldName = fieldName; }
    public String getFieldName() { return fieldName; }
}
