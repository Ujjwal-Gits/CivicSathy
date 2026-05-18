package com.civicsathy.dao;

import com.civicsathy.model.Category;
import com.civicsathy.util.DBUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

// gets categories from the database for dropdowns
/**
 * Data Access Object for handling database operations related to CategoryDAO.
 * 
 * @author Riwaz
 * @version 1.0
 */
public class CategoryDAO {

    // get all categories for the submit form dropdown
    /**
     * Retrieves the AllCategories.
     *
     * @return The resulting List<Category>.
     */
    public List<Category> getAllCategories() {
        List<Category> list = new ArrayList<>();
        String sql = "SELECT * FROM categories ORDER BY name";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                Category cat = new Category();
                cat.setId(rs.getInt("id"));
                cat.setName(rs.getString("name"));
                cat.setDescription(rs.getString("description"));
                list.add(cat);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }
}
