# CivicSathy - Municipality Management System

CivicSathy is a Java-based web application for managing municipality complaints and infrastructure tracking. It provides a bridge between citizens and the Itahari Sub-Metropolitan City office, allowing for real-time reporting and administrative resolution of local issues.

## Setup Instructions

### 1. Database
*   Ensure **XAMPP MySQL** is running.
*   Create a database named `civicsathy`.
*   Execute the SQL script located at `database/schema.sql` to initialize tables and structure.

### 2. Environment & Dependencies
*   **Java:** OpenJDK 17+ recommended.
*   **Server:** Apache Tomcat 11.0+.
*   **Connector:** Add `mysql-connector-j-9.6.0.jar` (located in `web/WEB-INF/lib`) to the project libraries.

### 3. IntelliJ Deployment
*   Open the project and add **Web Framework Support**.
*   Configure a **Tomcat Server (Local)**.
*   In the **Deployment** tab, add the `CivicSathy_Java:war exploded` artifact.
*   Set the **Application context** to `/CivicSathy_Java`.

## Project Features
*   **Citizen Portal:** Registration, secure login, and complaint submission.
*   **Admin Dashboard:** Real-time statistics, ticket tracking, and status management.
*   **Security:** SHA-256 password hashing, session-based authentication filters, and cookie management.
*   **Architecture:** Clean DAO pattern implementation with Jakarta EE Servlets.

