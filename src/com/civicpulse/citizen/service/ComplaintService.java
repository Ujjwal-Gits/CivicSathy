package com.civicpulse.citizen.service;

import com.civicpulse.citizen.dao.ComplaintDAO;
import com.civicpulse.citizen.dto.ComplaintCardDTO;
import com.civicpulse.citizen.dto.ComplaintDetailDTO;
import com.civicpulse.citizen.dto.ComplaintSubmitDTO;
import com.civicpulse.shared.exception.ServiceException;
import com.civicpulse.shared.exception.ValidationException;
import com.civicpulse.shared.model.Complaint;
import com.civicpulse.shared.util.ValidationUtil;

import java.util.List;

/**
 * Business logic for complaint operations (citizen side).
 * Validates input, calls DAO, transforms data.
 */
public class ComplaintService {

    private final ComplaintDAO complaintDAO = new ComplaintDAO();

    /**
     * Submit a new complaint.
     */
    public int submitComplaint(ComplaintSubmitDTO dto, int userId) throws ServiceException, ValidationException {
        // Validate input
        if (ValidationUtil.isNullOrEmpty(dto.getTitle())) {
            throw new ValidationException("title", "Title cannot be empty");
        }
        if (ValidationUtil.isNullOrEmpty(dto.getDescription())) {
            throw new ValidationException("description", "Description cannot be empty");
        }

        // TODO: Create Complaint model from DTO
        // TODO: Generate tracking ID
        // TODO: Call complaintDAO.insert(complaint)
        // TODO: Return the new complaint ID
        return 0;
    }

    /**
     * Get paginated list of complaints for the public feed.
     */
    public List<ComplaintCardDTO> getPublicFeed(int page, String category, String sortBy) {
        // TODO: Call complaintDAO with filters and pagination
        return null;
    }

    /**
     * Get complaints submitted by a specific user.
     */
    public List<ComplaintCardDTO> getUserComplaints(int userId, int page) {
        // TODO: Call complaintDAO.findByUserId(userId, offset, limit)
        return null;
    }

    /**
     * Get full detail of a single complaint.
     */
    public ComplaintDetailDTO getComplaintDetail(int complaintId) throws ServiceException {
        // TODO: Call complaintDAO.findById(complaintId)
        // TODO: Throw ServiceException if not found
        return null;
    }
}
