# CivicSathy - Municipality Management System

CivicSathy is a Java-based web application for managing municipality complaints and infrastructure tracking. It provides a bridge between citizens and the Itahari Sub-Metropolitan City office, allowing for real-time reporting and administrative resolution of local issues.

## Setup Instructions

### 1. Database Configuration
*   Ensure **XAMPP MySQL** (or any MySQL server) is running.
*   Create a database named `civicsathy`.
*   Execute the SQL script located at `database/schema.sql` to initialize all tables and structure. You can do this via phpMyAdmin or MySQL Workbench.

### 2. Environment Variables (.env)
This project uses environment variables for sensitive API keys.
*   In the root of the project, create a new file named `.env`.
*   Look at the `.env.example` file to see what variables are required.
*   Copy the contents of `.env.example` into your new `.env` file and replace `your_gemini_api_key_here` with your actual Gemini API key.

### 3. Dependencies
*   **Java:** OpenJDK 17+ recommended.
*   **Server:** Apache Tomcat 11.0+.
*   **Connector:** Add `mysql-connector-j-9.6.0.jar` (located in `src/main/webapp/WEB-INF/lib` or download it) to the project libraries.

### 4. IntelliJ IDEA Deployment
To run this project perfectly in IntelliJ IDEA, follow these steps:
1.  Open the project in IntelliJ IDEA.
2.  Add **Web Framework Support** (if not automatically detected).
3.  Go to **Project Structure (Ctrl+Alt+Shift+S)** -> **Artifacts**. Click `+` -> Web Application: Exploded -> From Modules. Name it `CivicSathy:war exploded`.
4.  Configure a **Tomcat Server (Local)** run configuration.
5.  In the Tomcat configuration's **Deployment** tab, click `+` -> Artifact and select the `CivicSathy:war exploded` artifact.
6.  Set the **Application context** at the bottom to `/` (or `/CivicSathy_Java` depending on your preference).
7.  Click Apply and Run the server!

## Project Features
*   **Citizen Portal:** Registration, secure login, and complaint submission.
*   **Admin Dashboard:** Real-time statistics, ticket tracking, AI-powered summaries using Gemini, and status management.
*   **Security:** SHA-256 password hashing, session-based authentication filters, and cookie management.
*   **Architecture:** Clean DAO pattern implementation with Jakarta EE Servlets.
