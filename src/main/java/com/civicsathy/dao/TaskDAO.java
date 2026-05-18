package com.civicsathy.dao;

import com.civicsathy.model.Task;
import com.civicsathy.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for handling database operations related to TaskDAO.
 * 
 * @author Saurab
 * @version 1.0
 */
public class TaskDAO {

    /**
     * Inserts a new Task into the database.
     *
     * @param task The task object/value.
     * @return The resulting boolean.
     */
    public boolean insertTask(Task task) {
        String sql = "INSERT INTO tasks (complaint_id, assigned_date, assigned_time, equipment, severity) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection()) {
            conn.setAutoCommit(false);
            try (PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
                
                stmt.setInt(1, task.getComplaintId());
                stmt.setDate(2, task.getAssignedDate());
                stmt.setTime(3, task.getAssignedTime());
                stmt.setString(4, task.getEquipment());
                stmt.setString(5, task.getSeverity());
                
                int affectedRows = stmt.executeUpdate();
                if (affectedRows == 0) {
                    conn.rollback();
                    return false;
                }
                
                try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        int taskId = generatedKeys.getInt(1);
                        
                        // Insert teams
                        String teamSql = "INSERT INTO task_teams (task_id, team_id, personnel_count) VALUES (?, ?, ?)";
                        try (PreparedStatement teamStmt = conn.prepareStatement(teamSql)) {
                            for (int i = 0; i < task.getTeamIds().size(); i++) {
                                teamStmt.setInt(1, taskId);
                                teamStmt.setInt(2, task.getTeamIds().get(i));
                                teamStmt.setInt(3, task.getTeamCounts().get(i));
                                teamStmt.executeUpdate();
                            }
                        }
                        
                        // Insert vehicles
                        String vehSql = "INSERT INTO task_vehicles (task_id, vehicle_id, vehicle_count) VALUES (?, ?, ?)";
                        try (PreparedStatement vehStmt = conn.prepareStatement(vehSql)) {
                            for (int i = 0; i < task.getVehicleIds().size(); i++) {
                                vehStmt.setInt(1, taskId);
                                vehStmt.setInt(2, task.getVehicleIds().get(i));
                                vehStmt.setInt(3, task.getVehicleCounts().get(i));
                                vehStmt.executeUpdate();
                            }
                        }
                    } else {
                        conn.rollback();
                        return false;
                    }
                }
                conn.commit();
                return true;
            } catch (SQLException e) {
                conn.rollback();
                e.printStackTrace();
                return false;
            } finally {
                conn.setAutoCommit(true);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Retrieves the AllTasks.
     *
     * @return The resulting List<Task>.
     */
    public List<Task> getAllTasks() {
        List<Task> list = new ArrayList<>();
        String sql = "SELECT t.*, c.title, c.tracking_id, c.ward_no, cat.name as category_name, " +
                     "(SELECT GROUP_CONCAT(CONCAT(v.vehicle_name, ' (', tv.vehicle_count, ')') SEPARATOR ', ') FROM task_vehicles tv JOIN vehicles v ON tv.vehicle_id = v.id WHERE tv.task_id = t.id) as display_vehicles, " +
                     "(SELECT GROUP_CONCAT(CONCAT(tm.team_name, ' (', tt.personnel_count, ')') SEPARATOR ', ') FROM task_teams tt JOIN teams tm ON tt.team_id = tm.id WHERE tt.task_id = t.id) as display_teams " +
                     "FROM tasks t " +
                     "JOIN complaints c ON t.complaint_id = c.id " +
                     "JOIN categories cat ON c.category_id = cat.id " +
                     "ORDER BY t.assigned_date DESC, t.assigned_time DESC";
                     
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            
            while (rs.next()) {
                Task t = new Task();
                t.setId(rs.getInt("id"));
                t.setComplaintId(rs.getInt("complaint_id"));
                t.setAssignedDate(rs.getDate("assigned_date"));
                t.setAssignedTime(rs.getTime("assigned_time"));
                t.setDisplayVehicles(rs.getString("display_vehicles"));
                t.setDisplayTeams(rs.getString("display_teams"));
                t.setStatus(rs.getString("status"));
                t.setCreatedAt(rs.getTimestamp("created_at"));
                
                t.setComplaintTitle(rs.getString("title"));
                t.setTrackingId(rs.getString("tracking_id"));
                t.setWardNo(rs.getInt("ward_no"));
                t.setCategoryName(rs.getString("category_name"));
                
                list.add(t);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
    
    /**
     * Retrieves the TaskByComplaintId.
     *
     * @param complaintId The complaintId object/value.
     * @return The resulting Task.
     */
    public Task getTaskByComplaintId(int complaintId) {
        String sql = "SELECT t.*, c.title, c.tracking_id, c.ward_no, cat.name as category_name, " +
                     "(SELECT GROUP_CONCAT(CONCAT(v.vehicle_name, ' (', tv.vehicle_count, ')') SEPARATOR ', ') FROM task_vehicles tv JOIN vehicles v ON tv.vehicle_id = v.id WHERE tv.task_id = t.id) as display_vehicles, " +
                     "(SELECT GROUP_CONCAT(CONCAT(tm.team_name, ' (', tt.personnel_count, ')') SEPARATOR ', ') FROM task_teams tt JOIN teams tm ON tt.team_id = tm.id WHERE tt.task_id = t.id) as display_teams " +
                     "FROM tasks t " +
                     "JOIN complaints c ON t.complaint_id = c.id " +
                     "JOIN categories cat ON c.category_id = cat.id " +
                     "WHERE t.complaint_id = ?";
                     
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, complaintId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Task t = new Task();
                    t.setId(rs.getInt("id"));
                    t.setComplaintId(rs.getInt("complaint_id"));
                    t.setAssignedDate(rs.getDate("assigned_date"));
                    t.setAssignedTime(rs.getTime("assigned_time"));
                    t.setDisplayVehicles(rs.getString("display_vehicles"));
                    t.setDisplayTeams(rs.getString("display_teams"));
                    t.setStatus(rs.getString("status"));
                    t.setCreatedAt(rs.getTimestamp("created_at"));
                    
                    t.setComplaintTitle(rs.getString("title"));
                    t.setTrackingId(rs.getString("tracking_id"));
                    t.setWardNo(rs.getInt("ward_no"));
                    t.setCategoryName(rs.getString("category_name"));
                    return t;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    /**
     * Updates the TaskStatusByComplaintId records.
     *
     * @param complaintId The complaintId object/value.
     * @param newStatus The newStatus object/value.
     * @return The resulting boolean.
     */
    public boolean updateTaskStatusByComplaintId(int complaintId, String newStatus) {
        String sql = "UPDATE tasks SET status = ? WHERE complaint_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, newStatus);
            stmt.setInt(2, complaintId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Deletes the TaskByComplaintId from the system.
     *
     * @param complaintId The complaintId object/value.
     * @return The resulting boolean.
     */
    public boolean deleteTaskByComplaintId(int complaintId) {
        String sql = "DELETE FROM tasks WHERE complaint_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, complaintId);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
