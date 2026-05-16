package com.civicsathy.dao;

import com.civicsathy.model.Team;
import com.civicsathy.model.Vehicle;
import com.civicsathy.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object for handling database operations related to InventoryDAO.
 * 
 * @author Riwaz
 * @version 1.0
 */
public class InventoryDAO {

    /**
     * Retrieves the AvailableVehicles.
     *
     * @return The resulting List<Vehicle>.
     */
    public List<Vehicle> getAvailableVehicles() {
        List<Vehicle> list = new ArrayList<>();
        String sql = "SELECT v.id, v.vehicle_name, v.total_count, " +
                     "COALESCE(SUM(tv.vehicle_count), 0) AS deployed_count " +
                     "FROM vehicles v " +
                     "LEFT JOIN task_vehicles tv ON v.id = tv.vehicle_id " +
                     "LEFT JOIN tasks t ON tv.task_id = t.id AND t.status != 'RESOLVED' " +
                     "WHERE v.is_active = TRUE " +
                     "GROUP BY v.id";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Vehicle v = new Vehicle();
                v.setId(rs.getInt("id"));
                v.setVehicleName(rs.getString("vehicle_name"));
                v.setTotalCount(rs.getInt("total_count"));
                int deployed = rs.getInt("deployed_count");
                v.setAvailableCount(v.getTotalCount() - deployed);
                list.add(v);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Retrieves the AvailableTeams.
     *
     * @return The resulting List<Team>.
     */
    public List<Team> getAvailableTeams() {
        List<Team> list = new ArrayList<>();
        String sql = "SELECT tm.id, tm.team_name, tm.member_count, " +
                     "COALESCE(SUM(tt.personnel_count), 0) AS deployed_count " +
                     "FROM teams tm " +
                     "LEFT JOIN task_teams tt ON tm.id = tt.team_id " +
                     "LEFT JOIN tasks t ON tt.task_id = t.id AND t.status != 'RESOLVED' " +
                     "WHERE tm.is_active = TRUE " +
                     "GROUP BY tm.id";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Team tm = new Team();
                tm.setId(rs.getInt("id"));
                tm.setTeamName(rs.getString("team_name"));
                tm.setMemberCount(rs.getInt("member_count"));
                int deployed = rs.getInt("deployed_count");
                tm.setAvailableCount(tm.getMemberCount() - deployed);
                list.add(tm);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    /**
     * Executes the addVehicle operation.
     *
     * @param name The name object/value.
     * @param count The count object/value.
     * @return The resulting boolean.
     */
    public boolean addVehicle(String name, int count) {
        String sql = "INSERT INTO vehicles (vehicle_name, total_count) VALUES (?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, name);
            stmt.setInt(2, count);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Updates the Vehicle records.
     *
     * @param id The id object/value.
     * @param count The count object/value.
     * @return The resulting boolean.
     */
    public boolean updateVehicle(int id, int count) {
        String sql = "UPDATE vehicles SET total_count = ? WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, count);
            stmt.setInt(2, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Executes the addTeam operation.
     *
     * @param name The name object/value.
     * @param type The type object/value.
     * @param count The count object/value.
     * @return The resulting boolean.
     */
    public boolean addTeam(String name, String type, int count) {
        String sql = "INSERT INTO teams (team_name, team_type, member_count) VALUES (?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, name);
            stmt.setString(2, type);
            stmt.setInt(3, count);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Updates the Team records.
     *
     * @param id The id object/value.
     * @param count The count object/value.
     * @return The resulting boolean.
     */
    public boolean updateTeam(int id, int count) {
        String sql = "UPDATE teams SET member_count = ? WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, count);
            stmt.setInt(2, id);
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
