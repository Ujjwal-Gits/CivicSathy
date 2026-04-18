package com.civicpulse.admin.dto;

/**
 * DTO for chart/report data.
 * Generic structure: parallel arrays of labels and values.
 */
public class ReportDTO {
    private String[] labels;
    private int[] values;
    private String chartTitle;

    public String[] getLabels() { return labels; }
    public void setLabels(String[] labels) { this.labels = labels; }

    public int[] getValues() { return values; }
    public void setValues(int[] values) { this.values = values; }

    public String getChartTitle() { return chartTitle; }
    public void setChartTitle(String chartTitle) { this.chartTitle = chartTitle; }
}
