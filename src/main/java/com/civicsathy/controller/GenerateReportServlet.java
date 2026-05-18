package com.civicsathy.controller;

import com.civicsathy.dao.ComplaintDAO;
import com.civicsathy.model.Complaint;
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
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

/**
 * Servlet controller handling HTTP requests and responses for GenerateReportServlet operations.
 * 
 * @author Ujjwal
 * @version 1.0
 */
@WebServlet("/admin/generate-report")
public class GenerateReportServlet extends HttpServlet {
    private ComplaintDAO complaintDAO;

    @Override
    /**
     * Executes the init operation.
     *
     */
    public void init() {
        complaintDAO = new ComplaintDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/pdf");
        response.setHeader("Content-Disposition", "attachment; filename=CivicSathy_Analytics_Report.pdf");

        try (Document document = new Document(PageSize.A4)) {
            PdfWriter.getInstance(document, response.getOutputStream());
            document.open();

            // Font Definitions
            Font titleFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 22, Color.BLACK);
            Font headerFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 14, Color.DARK_GRAY);
            Font normalFont = FontFactory.getFont(FontFactory.HELVETICA, 11, Color.BLACK);
            Font smallFont = FontFactory.getFont(FontFactory.HELVETICA, 9, Color.GRAY);

            // Title Section
            Paragraph title = new Paragraph("CivicSathy Analytics Report", titleFont);
            title.setAlignment(Element.ALIGN_CENTER);
            document.add(title);

            Paragraph subTitle = new Paragraph("Official Administrative Summary for Itahari City", FontFactory.getFont(FontFactory.HELVETICA, 10, Color.GRAY));
            subTitle.setAlignment(Element.ALIGN_CENTER);
            subTitle.setSpacingAfter(20);
            document.add(subTitle);

            // Date and Metadata
            DateTimeFormatter dtf = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
            Paragraph meta = new Paragraph("Report Generated: " + dtf.format(LocalDateTime.now()), smallFont);
            meta.setAlignment(Element.ALIGN_RIGHT);
            meta.setSpacingAfter(20);
            document.add(meta);

            // Summary Stats
            int total = complaintDAO.getTotalCount();
            int escalated = complaintDAO.getEscalatedCount();
            Map<String, Integer> stats = complaintDAO.getStats();
            int resolved = stats.getOrDefault("RESOLVED", 0);
            
            Paragraph summaryTitle = new Paragraph("Executive Summary", headerFont);
            summaryTitle.setSpacingAfter(10);
            document.add(summaryTitle);

            document.add(new Paragraph("Total Complaints Received: " + total, normalFont));
            document.add(new Paragraph("Resolved Cases: " + resolved, normalFont));
            document.add(new Paragraph("Escalated (Over 48h): " + escalated, normalFont));
            document.add(new Paragraph("Current Pending: " + stats.getOrDefault("PENDING", 0), normalFont));
            
            document.add(new Paragraph("\n"));

            // Ward Breakdown Table
            Paragraph wardTitle = new Paragraph("Complaints by Ward", headerFont);
            wardTitle.setSpacingAfter(10);
            document.add(wardTitle);

            PdfPTable wardTable = new PdfPTable(2);
            wardTable.setWidthPercentage(50);
            wardTable.setHorizontalAlignment(Element.ALIGN_LEFT);
            wardTable.addCell(new PdfPCell(new Phrase("Ward Number", FontFactory.getFont(FontFactory.HELVETICA_BOLD, 11, Color.BLACK))));
            wardTable.addCell(new PdfPCell(new Phrase("Complaint Count", FontFactory.getFont(FontFactory.HELVETICA_BOLD, 11, Color.BLACK))));

            Map<Integer, Integer> wardCounts = complaintDAO.getCountByWard();
            if (wardCounts != null) {
                for (Map.Entry<Integer, Integer> entry : wardCounts.entrySet()) {
                    wardTable.addCell(new PdfPCell(new Phrase("Ward " + entry.getKey(), normalFont)));
                    wardTable.addCell(new PdfPCell(new Phrase(String.valueOf(entry.getValue()), normalFont)));
                }
            }
            document.add(wardTable);
            document.add(new Paragraph("\n"));

            // Detailed Complaint List
            Paragraph listTitle = new Paragraph("Detailed Complaint Log", headerFont);
            listTitle.setSpacingAfter(10);
            document.add(listTitle);

            PdfPTable table = new PdfPTable(5);
            table.setWidthPercentage(100);
            table.setWidths(new float[]{2f, 3f, 2f, 1f, 2f});

            // Table Headers
            String[] headers = {"Tracking ID", "Title", "Category", "Ward", "Status"};
            for (String h : headers) {
                PdfPCell cell = new PdfPCell(new Phrase(h, FontFactory.getFont(FontFactory.HELVETICA_BOLD, 10, Color.WHITE)));
                cell.setBackgroundColor(new Color(0, 91, 150)); // CivicSathy Blue
                cell.setPadding(5);
                cell.setHorizontalAlignment(Element.ALIGN_CENTER);
                table.addCell(cell);
            }

            List<Complaint> complaints = complaintDAO.getAllComplaints();
            for (Complaint c : complaints) {
                table.addCell(new PdfPCell(new Phrase(c.getTrackingId(), smallFont)));
                table.addCell(new PdfPCell(new Phrase(c.getTitle(), smallFont)));
                table.addCell(new PdfPCell(new Phrase(c.getCategoryName(), smallFont)));
                table.addCell(new PdfPCell(new Phrase(String.valueOf(c.getWardNo()), smallFont)));
                
                PdfPCell statusCell = new PdfPCell(new Phrase(c.getStatus(), smallFont));
                if ("RESOLVED".equalsIgnoreCase(c.getStatus())) {
                    statusCell.setBackgroundColor(new Color(209, 250, 229));
                } else if ("PENDING".equalsIgnoreCase(c.getStatus())) {
                    statusCell.setBackgroundColor(new Color(254, 243, 199));
                } else if ("ESCALATED".equalsIgnoreCase(c.getStatus())) {
                    statusCell.setBackgroundColor(new Color(254, 226, 226));
                }
                table.addCell(statusCell);
            }

            document.add(table);

            // Footer
            Paragraph footer = new Paragraph("\n\nThis is an automatically generated system report. © CivicSathy 2026", FontFactory.getFont(FontFactory.HELVETICA, 8, Color.GRAY));
            footer.setAlignment(Element.ALIGN_CENTER);
            document.add(footer);

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
