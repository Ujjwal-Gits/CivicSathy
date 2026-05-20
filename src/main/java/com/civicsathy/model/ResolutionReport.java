package com.civicsathy.model;

import java.sql.Timestamp;

// when admin closes a ticket they fill out this report
/**
 * Entity model representing ResolutionReport data structure.
 * 
 * @author Prashant
 * @version 1.0
 */
public class ResolutionReport {
	private int id;
	private int complaintId;
	private String workDone;
	private double hoursTaken;
	private double costEstimate;
	private String teamDeployed;
	private int closedBy;
	private boolean citizenConfirmed;
	private Timestamp createdAt;

	/**
	 * Executes the ResolutionReport operation.
	 *
	 */
	public ResolutionReport() {}

	public int getId() { return id; }
	public void setId(int id) { this.id = id; }

	public int getComplaintId() { return complaintId; }
	public void setComplaintId(int complaintId) { this.complaintId = complaintId; }

	public String getWorkDone() { return workDone; }
	public void setWorkDone(String workDone) { this.workDone = workDone; }

	public double getHoursTaken() { return hoursTaken; }
	public void setHoursTaken(double hoursTaken) { this.hoursTaken = hoursTaken; }

	public double getCostEstimate() { return costEstimate; }
	public void setCostEstimate(double costEstimate) { this.costEstimate = costEstimate; }

	public String getTeamDeployed() { return teamDeployed; }
	public void setTeamDeployed(String teamDeployed) { this.teamDeployed = teamDeployed; }

	public int getClosedBy() { return closedBy; }
	public void setClosedBy(int closedBy) { this.closedBy = closedBy; }

	public boolean getCitizenConfirmed() { return citizenConfirmed; }
	public void setCitizenConfirmed(boolean citizenConfirmed) { this.citizenConfirmed = citizenConfirmed; }

	public Timestamp getCreatedAt() { return createdAt; }
	public void setCreatedAt(Timestamp createdAt) { this.createdAt = createdAt; }
}
