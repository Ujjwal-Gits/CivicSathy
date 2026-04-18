package com.civicpulse.admin.dao;

import com.civicpulse.shared.exception.DatabaseException;

import java.util.LinkedHashMap;
import java.util.Map;

/**
 * Report DAO — aggregate queries for analytics.
 */
public class ReportDAO {

    public Map<String, Integer> countByCategory() throws DatabaseException {
        String sql = "SELECT c.name, COUNT(*) as cnt FROM complaints co JOIN categories c ON co.category_id = c.id GROUP BY c.name ORDER BY cnt DESC";
        // TODO: Implement
        return new LinkedHashMap<>();
    }

    public Map<String, Integer> countByWard() throws DatabaseException {
        String sql = "SELECT ward, COUNT(*) as cnt FROM complaints GROUP BY ward ORDER BY ward";
        // TODO: Implement
        return new LinkedHashMap<>();
    }

    public Map<String, Integer> countByMonth() throws DatabaseException {
        String sql = "SELECT DATE_FORMAT(created_at, '%Y-%m') as month, COUNT(*) as cnt FROM complaints GROUP BY month ORDER BY month";
        // TODO: Implement
        return new LinkedHashMap<>();
    }
}
