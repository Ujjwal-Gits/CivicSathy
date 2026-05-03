package com.civicsathy.model;

public class User {
    private int id;
    private String fullName;
    private String email;
    private String contactNo;
    private String wardNo;
    private String location;
    private String password;
    private String role; // CITIZEN or ADMIN

    public User() {}

    public User(String fullName, String email, String contactNo, String wardNo, String location, String password, String role) {
        this.fullName = fullName;
        this.email = email;
        this.contactNo = contactNo;
        this.wardNo = wardNo;
        this.location = location;
        this.password = password;
        this.role = role;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    public String getContactNo() { return contactNo; }
    public void setContactNo(String contactNo) { this.contactNo = contactNo; }
    public String getWardNo() { return wardNo; }
    public void setWardNo(String wardNo) { this.wardNo = wardNo; }
    public String getLocation() { return location; }
    public void setLocation(String location) { this.location = location; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }
    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }
}

