# CivicSathy: Detailed Project Planning & Feature Distribution

This document provides a comprehensive breakdown of the CivicSathy project, detailing the work completed during Milestone 1 and the strategic distribution of pending features for the final delivery. The project is managed with a leader-centric approach, ensuring that complex integrations and core analytical tasks are handled with high precision.

---

## 1. Project Workflow and Execution Strategy

The development of CivicSathy follows a structured, server-side driven workflow. Every civic issue reported by a citizen undergoes a multi-stage process handled by Java Servlets and processed through the Google Gemini AI engine.

**The Lifecycle of a Complaint:**
The workflow begins at the Citizen Portal where a user submits a localized issue. Once submitted, the system generates a unique tracking ID and triggers the backend logic. The data is then analyzed by the AI module to suggest severity and team requirements. On the Admin Dashboard, municipal staff review these suggestions, assign specialized teams, and update the status in real-time. The process concludes with a resolution report and a mandatory citizen confirmation, ensuring full transparency and accountability.

---

## 2. Milestone 1: Consolidated Work Done

During the first phase of the project, the core authentication, citizen interfaces, and admin dashboards were established. Based on a detailed scan of the project task files, the following work was successfully completed by the team members.

**Astha (Work Done):**
*   **Citizen UI Framework**: Designed and implemented the login, registration, and user profile JSP pages.
*   **Design System**: Created the `citizen.css` architecture for the user-facing portal.
*   **Security Layer**: Developed the core `AuthFilter` and `AdminAuthFilter` Java classes to handle session security and role-based access.

**Prashant (Work Done):**
*   **Submission Engine**: Developed the `SubmitComplaintServlet` to handle the backend processing of citizen reports.
*   **Data Handling**: Established the initial logic for mapping form data to the database complaint records.

**Riwaz (Work Done):**
*   **Admin Framework**: Built the primary Admin Dashboard JSP and the centralized admin navigation sidebar.
*   **Admin Controller**: Implemented the `AdminDashboardServlet` to handle the initial visualization of dashboard data.

**Ujjwal (Work Done & Consolidation):**
*   **Administrative Logistics**: Completed all tasks originally designated for Sourabh, including the `AdminTicketServlet`, the core Complaints table, and the Team Management interfaces.
*   **System Infrastructure**: Setup the Maven `pom.xml`, project structure, and the `DBUtil` connection pooling.
*   **Leftover Task Cleanup**: Unified the separate modules into a single running project and finalized the database schema.

---

## 3. Final Phase: Feature Distribution and Responsibilities

The remaining features have been divided to ensure that every member handles at least one core system-critical module. Ujjwal, as the project lead, handles the most complex backend integrations and AI-driven features.

### **1. Ujjwal (Project Leader & AI Lead)**
Ujjwal manages the core intelligence, system architecture, and complex AI integrations.
*   **Smart Complaint Submission (Citizen)**: Building the core submission engine that handles the multipart form data for new civic issues.
*   **AI Issue Analysis via Gemini (Admin)**: Real-time AI processing to recommend team types, sizes, equipment, and severity ratings for new tickets.
*   **AI Weekly Summary Report (Admin)**: The automated PDF generation system that compiles weekly municipal analytics.
*   **Duplicate Detection Engine (Admin)**: Logic to cross-reference new complaints with existing ones to prevent municipal redundancy.
*   **Global System Architecture**: Managing the database pooling, session security filters, and overall Java servlet routing.

### **2. Astha (Citizen Experience & Crisis Response)**
Astha focuses entirely on the citizen-facing feedback loops and emergency response modules.
*   **Resolve Confirmation Flow (Citizen)**: The "Accept/Reject" mechanism where citizens must validate the work done before a ticket is officially closed.
*   **Personalized User Dashboard (Citizen)**: The private portal for logged-in citizens to track and manage their submitted issues.
*   **Emergency Contact Module (Citizen)**: The dedicated SOS section with direct-dial functionality and quick-access modals.
*   **Multimedia Evidence Support (Citizen)**: Handling the secure upload, storage, and retrieval of image evidence for complaints.
*   **GPS Location Capture (Citizen)**: Integrating browser geolocation to accurately tag where an issue occurred.

### **3. Prashant (Public Transparency & Security)**
Prashant handles features related to public tracking, anonymity, and direct communication.
*   **Anonymous Reporting Protocol (Citizen)**: The data-masking feature that allows citizens to report sensitive issues without revealing their identity.
*   **Ticket Tracker - No Login (Citizen)**: The public lookup portal allowing users to check ticket status via a Unique ID.
*   **Complaint Status Tracking Timeline (Citizen)**: The dynamic vertical CSS timeline visualizing the complete history of an issue.
*   **Comment & Update Thread (Citizen/Admin)**: The interactive discussion module allowing admins to post updates and citizens to reply.
*   **Official Announcement Broadcast (Admin)**: The pinning system for administrators to post city-wide alerts on the public feed.

### **4. Riwaz (Spatial Analytics & Visualization)**
Riwaz transforms the raw database information into visual, actionable tools for both citizens and admins.
*   **Public Complaint Feed (Citizen)**: The centralized, public-facing feed with advanced sorting (by date, popularity) and filtering capabilities.
*   **Live Analytics Dashboard (Admin)**: The primary administrative interface featuring Chart.js graphs for category trends and resolution times.
*   **Live Density Heatmap (Admin)**: Visualizing complaint clusters across the metropolitan area using Leaflet.js to identify problem hotspots.
*   **Ward Filtering & Mapping (Admin)**: Automatically categorizing and filtering complaints based on their GPS coordinates and assigned city wards.

### **5. Sourabh (Municipal Logistics & Operations)**
Sourabh manages the internal municipal tools required to actually resolve the issues.
*   **Team & Resource Management (Admin)**: The administrative module to create, manage, and assign specific maintenance teams (e.g., "Ward 4 Plumbers").
*   **Escalation & Auto-Flagging Engine (Admin)**: Background logic that highlights and flags tickets pending for more than 48 hours for immediate supervisor attention.
*   **Resolution Report Generation (Admin)**: The final documentation form where assigned teams log hours, material costs, and work details.
*   **'I’m Affected' Voting Logic (Citizen)**: The community prioritization system allowing users to upvote issues that impact them, directly affecting the ticket's weight.

---

## 4. Strict Backend & Frontend Separation

In adherence to the project's academic guidelines, **CivicSathy operates on a 100% Java backend**. No backend JavaScript (e.g., Node.js) is utilized. The backend handles all database transactions, session authentication, Gemini AI processing, and core logic.

**Frontend JavaScript** is employed *strictly* on the client-side within the browser to enable specific interactive hardware and visual features:
1.  **Live GPS Capture (Prashant/Astha)**: Utilizing the browser's `navigator.geolocation` API to capture precise latitude/longitude coordinates when a citizen submits a complaint.
2.  **Live Status Map & Heatmaps (Riwaz)**: Utilizing a mapping library (e.g., Leaflet.js) to render dynamic maps and plot complaint coordinates visually.
3.  **Analytics Dashboard Charts (Riwaz)**: Using Chart.js to render pie charts and bar graphs based on the numerical data provided by the Java Servlets.
4.  **UI Enhancements (Astha)**: Optional minor scripts for image upload previews and dynamic modal popups for the Resolve Confirmation flow.
