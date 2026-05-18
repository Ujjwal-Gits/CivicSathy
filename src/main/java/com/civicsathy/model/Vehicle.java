package com.civicsathy.model;

/**
 * Entity model representing Vehicle data structure.
 * 
 * @author Riwaz
 * @version 1.0
 */
public class Vehicle {
    private int id;
    private String vehicleName;
    private int totalCount;
    private int availableCount;

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getVehicleName() { return vehicleName; }
    public void setVehicleName(String vehicleName) { this.vehicleName = vehicleName; }

    public int getTotalCount() { return totalCount; }
    public void setTotalCount(int totalCount) { this.totalCount = totalCount; }

    public int getAvailableCount() { return availableCount; }
    public void setAvailableCount(int availableCount) { this.availableCount = availableCount; }
}
