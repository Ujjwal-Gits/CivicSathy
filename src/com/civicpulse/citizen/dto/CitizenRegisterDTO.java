package com.civicpulse.citizen.dto;

/**
 * DTO for citizen registration form fields.
 */
public class CitizenRegisterDTO {
    private String fullName;
    private String email;
    private String phone;
    private String password;
    private String confirmPassword;
    private int ward;

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getPhone() { return phone; }
    public void setPhone(String phone) { this.phone = phone; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getConfirmPassword() { return confirmPassword; }
    public void setConfirmPassword(String confirmPassword) { this.confirmPassword = confirmPassword; }

    public int getWard() { return ward; }
    public void setWard(int ward) { this.ward = ward; }
}
