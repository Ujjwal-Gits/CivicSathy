-- CivicSathy Database Schema
-- This is the complete database for our civic issue management platform

CREATE DATABASE IF NOT EXISTS civicsathy;
USE civicsathy;

-- this is the users table for both citizens and admins
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    phone VARCHAR(30),
    ward INT NOT NULL,
    location VARCHAR(255),
    role VARCHAR(20) NOT NULL DEFAULT 'CITIZEN',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- categories for classifying complaints
CREATE TABLE IF NOT EXISTS categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT
);

-- municipal response teams that admin can assign
CREATE TABLE IF NOT EXISTS teams (
    id INT AUTO_INCREMENT PRIMARY KEY,
    team_name VARCHAR(100) NOT NULL,
    team_type VARCHAR(50) NOT NULL,
    member_count INT DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- this is the main complaints table where all citizen reports go
CREATE TABLE IF NOT EXISTS complaints (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tracking_id VARCHAR(50) NOT NULL UNIQUE,
    user_id INT NOT NULL,
    category_id INT NOT NULL,
    title VARCHAR(200) NOT NULL,
    description TEXT NOT NULL,
    ward_no INT NOT NULL,
    location_text VARCHAR(255),
    latitude DECIMAL(10,7),
    longitude DECIMAL(10,7),
    image_path VARCHAR(500),
    is_anonymous BOOLEAN DEFAULT FALSE,
    status VARCHAR(50) DEFAULT 'PENDING',
    severity VARCHAR(20) DEFAULT 'MEDIUM',
    affected_count INT DEFAULT 1,
    assigned_team_id INT,
    ai_severity VARCHAR(20),
    ai_team_suggestion VARCHAR(255),
    ai_equipment VARCHAR(255),
    ai_estimated_hours DECIMAL(5,1),
    ai_team_size INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (category_id) REFERENCES categories(id),
    FOREIGN KEY (assigned_team_id) REFERENCES teams(id)
);

-- tracks every status change so we can show a timeline
CREATE TABLE IF NOT EXISTS status_history (
    id INT AUTO_INCREMENT PRIMARY KEY,
    complaint_id INT NOT NULL,
    old_status VARCHAR(50),
    new_status VARCHAR(50) NOT NULL,
    changed_by INT,
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (complaint_id) REFERENCES complaints(id),
    FOREIGN KEY (changed_by) REFERENCES users(id)
);

-- notifications for citizens about their complaint updates
CREATE TABLE IF NOT EXISTS notifications (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    complaint_id INT,
    message VARCHAR(500) NOT NULL,
    is_read BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (complaint_id) REFERENCES complaints(id)
);

-- official announcements posted by admin on the public feed
CREATE TABLE IF NOT EXISTS announcements (
    id INT AUTO_INCREMENT PRIMARY KEY,
    admin_id INT NOT NULL,
    title VARCHAR(200) NOT NULL,
    message TEXT NOT NULL,
    icon VARCHAR(50) DEFAULT 'megaphone',
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (admin_id) REFERENCES users(id)
);

-- when admin closes a ticket they fill this report
CREATE TABLE IF NOT EXISTS resolution_reports (
    id INT AUTO_INCREMENT PRIMARY KEY,
    complaint_id INT NOT NULL UNIQUE,
    work_done TEXT NOT NULL,
    hours_taken DECIMAL(5,1),
    cost_estimate DECIMAL(10,2),
    team_deployed VARCHAR(100),
    closed_by INT,
    citizen_confirmed BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (complaint_id) REFERENCES complaints(id),
    FOREIGN KEY (closed_by) REFERENCES users(id)
);

-- tracks who clicked "I'm Affected" so one user cant vote twice
CREATE TABLE IF NOT EXISTS affected_votes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    complaint_id INT NOT NULL,
    user_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY unique_vote (complaint_id, user_id),
    FOREIGN KEY (complaint_id) REFERENCES complaints(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- stores citizen comments on public complaints
CREATE TABLE IF NOT EXISTS comments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    complaint_id INT NOT NULL,
    user_id INT NOT NULL,
    comment_text TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (complaint_id) REFERENCES complaints(id),
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- municipal response vehicles inventory
CREATE TABLE IF NOT EXISTS vehicles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    vehicle_name VARCHAR(100) NOT NULL,
    total_count INT DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- manual task assignments by admin to resolve complaints
CREATE TABLE IF NOT EXISTS tasks (
    id INT AUTO_INCREMENT PRIMARY KEY,
    complaint_id INT NOT NULL,
    assigned_date DATE NOT NULL,
    assigned_time TIME NOT NULL,
    equipment VARCHAR(500) DEFAULT NULL,
    severity VARCHAR(20) DEFAULT NULL,
    status VARCHAR(50) DEFAULT 'ASSIGNED',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (complaint_id) REFERENCES complaints(id) ON DELETE CASCADE
);

-- many-to-many relationship mapping task to multiple teams
CREATE TABLE IF NOT EXISTS task_teams (
    id INT AUTO_INCREMENT PRIMARY KEY,
    task_id INT NOT NULL,
    team_id INT NOT NULL,
    personnel_count INT NOT NULL,
    FOREIGN KEY (task_id) REFERENCES tasks(id) ON DELETE CASCADE,
    FOREIGN KEY (team_id) REFERENCES teams(id) ON DELETE CASCADE
);

-- many-to-many relationship mapping task to multiple vehicles
CREATE TABLE IF NOT EXISTS task_vehicles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    task_id INT NOT NULL,
    vehicle_id INT NOT NULL,
    vehicle_count INT NOT NULL,
    FOREIGN KEY (task_id) REFERENCES tasks(id) ON DELETE CASCADE,
    FOREIGN KEY (vehicle_id) REFERENCES vehicles(id) ON DELETE CASCADE
);

-- seed data for categories
INSERT INTO categories (name, description) VALUES 
('Roads', 'Potholes, cracks, street lights, blockages'),
('Sanitation', 'Waste collection, sewage, garbage piling'),
('Water', 'Pipe leaks, no water supply, contamination'),
('Electricity', 'Power outages, loose wires, street lights'),
('Flooding', 'Waterlogging, drain blockage, flood damage'),
('Safety', 'Theft, vandalism, unsafe structures'),
('Other', 'Any issue not covered by above categories')
ON DUPLICATE KEY UPDATE name = name;

-- default admin account (password is admin123 hashed with SHA-256)
INSERT INTO users (full_name, email, password_hash, phone, ward, role) 
VALUES ('Admin User', 'admin@civicsathy.com', '240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9', '9800000000', 1, 'ADMIN')
ON DUPLICATE KEY UPDATE email = email;

-- some sample teams
INSERT INTO teams (team_name, team_type, member_count) VALUES
('Road Maintenance A', 'Roads', 5),
('Sanitation Crew B', 'Sanitation', 4),
('Water Repair Unit', 'Water', 3),
('Electrical Response', 'Electricity', 3)
ON DUPLICATE KEY UPDATE team_name = team_name;

-- FIX: ensure status columns are VARCHAR(50)
ALTER TABLE complaints MODIFY COLUMN status VARCHAR(50) DEFAULT 'PENDING';
ALTER TABLE tasks MODIFY COLUMN status VARCHAR(50) DEFAULT 'ASSIGNED';
