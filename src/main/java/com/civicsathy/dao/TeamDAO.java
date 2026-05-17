package com.civicsathy.dao;

import com.civicsathy.model.Team;
import com.civicsathy.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

// handles team management operations
/**
 * Data Access Object for handling database operations related to TeamDAO.
 * 
 * @author Saurab
 * @version 1.0
 */
public class TeamDAO {

    // get all active teams
    /**
     * Retrieves the AllTeams.
     *
     * @return The resulting List<Team>.
     */
    public List<Team> getAllTeams() {
        List<Team> list = new ArrayList<>();
        String sql = "SELECT * FROM teams WHERE is_active = TRUE ORDER BY team_name";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                list.add(mapTeam(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // get a single team by id
    /**
     * Retrieves the ById.
     *
     * @param id The id object/value.
     * @return The resulting Team.
     */
    public Team getById(int id) {
        String sql = "SELECT * FROM teams WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, id);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) return mapTeam(rs);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // add a new team
    /**
     * Executes the addTeam operation.
     *
     * @param team The team object/value.
     * @return The resulting boolean.
     */
    public boolean addTeam(Team team) {
        String sql = "INSERT INTO teams (team_name, team_type, member_count) VALUES (?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, team.getTeamName());
            stmt.setString(2, team.getTeamType());
            stmt.setInt(3, team.getMemberCount());
            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private Team mapTeam(ResultSet rs) throws SQLException {
        Team t = new Team();
        t.setId(rs.getInt("id"));
        t.setTeamName(rs.getString("team_name"));
        t.setTeamType(rs.getString("team_type"));
        t.setMemberCount(rs.getInt("member_count"));
        t.setIsActive(rs.getBoolean("is_active"));
        t.setCreatedAt(rs.getTimestamp("created_at"));
        return t;
    }
}
