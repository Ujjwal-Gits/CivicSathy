package com.civicpulse.shared.model;

/**
 * Category entity — maps to the `categories` table.
 */
public class Category {
    private int id;
    private String name;
    private String icon;
    private String colorCode;

    public Category() {}

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getIcon() { return icon; }
    public void setIcon(String icon) { this.icon = icon; }
    public String getColorCode() { return colorCode; }
    public void setColorCode(String colorCode) { this.colorCode = colorCode; }
}
