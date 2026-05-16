package com.civicsathy.model;

// simple category model for complaint types like Roads, Water etc
/**
 * Entity model representing Category data structure.
 * 
 * @author Riwaz
 * @version 1.0
 */
public class Category {
    private int id;
    private String name;
    private String description;

    /**
     * Executes the Category operation.
     *
     */
    public Category() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
}
