package com.civicsathy.controller;

import com.civicsathy.dao.ComplaintDAO;
import com.civicsathy.dao.ResolutionReportDAO;
import com.civicsathy.model.Complaint;
import com.civicsathy.model.ResolutionReport;
import com.lowagie.text.*;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.awt.Color;
import java.io.IOException;
import java.time.format.DateTimeFormatter;

/**
 * Servlet controller handling HTTP requests and responses for DownloadIssueReportServlet operations.
 * 
 * @author Ujjwal
 * @version 1.0
 */
@WebServlet("/download-issue-report")
public class DownloadIssueReportServlet extends HttpServlet {
    private ComplaintDAO complaintDAO;
    private ResolutionReportDAO resolutionReportDAO;

    @Override
    /**
     * Executes the init operation.
     *
     */
    public void init() {
        complaintDAO = new ComplaintDAO();
        resolutionReportDAO = new ResolutionReportDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        com.civicsathy.model.User user = (com.civicsathy.model.User) request.getSession().getAttribute("loggedInUser");
        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/citizen/login.jsp");
            return;
        }

        String idStr = request.getParameter("id");
        if (idStr == null) {
            response.sendError(400, "Missing ID");
            return;
        }

        try {
            int id = Integer.parseInt(idStr);
            Complaint c = complaintDAO.getById(id);
            ResolutionReport r = resolutionReportDAO.getByComplaintId(id);

            if (c == null) {
                response.sendError(404, "Complaint not found");
                return;
            }

            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition", "attachment; filename=Resolution_Report_" + c.getTrackingId() + ".pdf");

            try (Document document = new Document(PageSize.A4)) {
                PdfWriter.getInstance(document, response.getOutputStream());
                document.open();

                // Fonts
                Font titleFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 24, new Color(0, 91, 150));
                Font subTitleFont = FontFactory.getFont(FontFactory.HELVETICA, 12, Color.GRAY);
                Font headerFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 14, Color.BLACK);
                Font labelFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 11, Color.DARK_GRAY);
                Font valueFont = FontFactory.getFont(FontFactory.HELVETICA, 11, Color.BLACK);

                // Header
                Paragraph title = new Paragraph("Resolution Certificate", titleFont);
                title.setAlignment(Element.ALIGN_CENTER);
                document.add(title);

                Paragraph sub = new Paragraph("CivicSathy - Itahari Sub-Metropolitan City", subTitleFont);
                sub.setAlignment(Element.ALIGN_CENTER);
                sub.setSpacingAfter(30);
                document.add(sub);

                // Ticket Info Box
                PdfPTable infoTable = new PdfPTable(2);
                infoTable.setWidthPercentage(100);
                infoTable.setSpacingAfter(20);

                addInfoRow(infoTable, "Tracking ID:", "#" + c.getTrackingId(), labelFont, valueFont);
                addInfoRow(infoTable, "Issue Title:", c.getTitle(), labelFont, valueFont);
                addInfoRow(infoTable, "Category:", c.getCategoryName(), labelFont, valueFont);
                addInfoRow(infoTable, "Ward No:", "Ward " + c.getWardNo(), labelFont, valueFont);
                addInfoRow(infoTable, "Status:", c.getStatus(), labelFont, valueFont);
                
                document.add(infoTable);

                // Resolution Section
                if (r != null) {
                    Paragraph resTitle = new Paragraph("Resolution Details", headerFont);
                    resTitle.setSpacingBefore(10);
                    resTitle.setSpacingAfter(10);
                    document.add(resTitle);

                    PdfPTable resTable = new PdfPTable(2);
                    resTable.setWidthPercentage(100);
                    
                    addInfoRow(resTable, "Work Done:", r.getWorkDone(), labelFont, valueFont);
                    addInfoRow(resTable, "Time Spent:", r.getHoursTaken() + " Hours", labelFont, valueFont);
                    addInfoRow(resTable, "Estimated Cost:", "NPR " + r.getCostEstimate(), labelFont, valueFont);
                    addInfoRow(resTable, "Team Deployed:", r.getTeamDeployed(), labelFont, valueFont);
                    addInfoRow(resTable, "Resolved At:", r.getCreatedAt().toString(), labelFont, valueFont);

                    document.add(resTable);
                } else {
                    document.add(new Paragraph("No detailed resolution report submitted for this ticket yet.", valueFont));
                }

                // Footer
                Paragraph footer = new Paragraph("\n\nThis is an official document issued by CivicSathy Itahari. \nVerification Code: " + c.getTrackingId().hashCode(), FontFactory.getFont(FontFactory.HELVETICA, 9, Color.GRAY));
                footer.setAlignment(Element.ALIGN_CENTER);
                footer.setSpacingBefore(100);
                document.add(footer);

                document.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void addInfoRow(PdfPTable table, String label, String value, Font labelFont, Font valueFont) {
        PdfPCell cellLabel = new PdfPCell(new Phrase(label, labelFont));
        cellLabel.setBorder(Rectangle.NO_BORDER);
        cellLabel.setPadding(8);
        table.addCell(cellLabel);

        PdfPCell cellValue = new PdfPCell(new Phrase(value != null ? value : "N/A", valueFont));
        cellValue.setBorder(Rectangle.NO_BORDER);
        cellValue.setPadding(8);
        table.addCell(cellValue);
    }
}
