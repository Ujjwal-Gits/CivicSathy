package com.civicsathy.model;

import java.sql.Date;
import java.sql.Time;
import java.sql.Timestamp;

import java.util.ArrayList;
import java.util.List;

/**
 * Entity model representing Task data structure.
 * 
 * @author Saurab
 * @version 1.0
 */
public class Task {
    private int id;
    private int complaintId;
    private Date assignedDate;
    private Time assignedTime;
    private String status;
    private Timestamp createdAt;
    
    // Lists for multiple resources
    private List<Integer> vehicleIds = new ArrayList<>();
    private List<Integer> vehicleCounts = new ArrayList<>();
    private List<Integer> teamIds = new ArrayList<>();
    private List<Integer> teamCounts = new ArrayList<>();

    // For joined queries
    private String complaintTitle;
    private String categoryName;
    private int wardNo;
    private String trackingId;
    
    // Display strings for frontend
    private String displayVehicles;
    private String displayTeams;
    
    // Equipment and severity for task assignment
    private String equipment;
    private String severity;
