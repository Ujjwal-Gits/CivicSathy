package com.civicpulse.citizen.dto;

/**
 * DTO for citizen login form fields.
 */
public class CitizenLoginDTO {
    private String email;
    private String password;

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
}
