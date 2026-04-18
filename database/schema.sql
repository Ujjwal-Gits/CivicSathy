-- ============================================================
-- CivicPulse Database Schema
-- MySQL 8.x (XAMPP)
-- Run this in phpMyAdmin or MySQL CLI to create the database
-- ============================================================

CREATE DATABASE IF NOT EXISTS civicpulse
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE civicpulse;

-- ============================================================
-- USERS TABLE
-- ============================================================
CREATE TABLE users (
    id              INT PRIMARY KEY AUTO_INCREMENT,
    full_name       VARCHAR(100) NOT NULL,
    email           VARCHAR(150) UNIQUE NOT NULL,
    phone           VARCHAR(20),
    password_hash   VARCHAR(255) NOT NULL,
    ward            INT,
    role            ENUM('CITIZEN', 'ADMIN') DEFAULT 'CITIZEN',
    avatar_url      VARCHAR(500),
    is_active       BOOLEAN DEFAULT TRUE,
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    INDEX idx_users_email (email),
    INDEX idx_users_role (role)
) ENGINE=InnoDB;

-- ============================================================
-- CATEGORIES TABLE
-- ============================================================
CREATE TABLE categories (
    id              INT PRIMARY KEY AUTO_INCREMENT,
    name            VARCHAR(50) NOT NULL,
    icon            VARCHAR(50),
    color_code      VARCHAR(7)
) ENGINE=InnoDB;

-- ============================================================
-- COMPLAINTS TABLE
-- ============================================================
CREATE TABLE complaints (
    id              INT PRIMARY KEY AUTO_INCREMENT,
    tracking_id     VARCHAR(20) UNIQUE NOT NULL,
    title           VARCHAR(200) NOT NULL,
    description     TEXT NOT NULL,
    category_id     INT NOT NULL,
    status          ENUM('PENDING', 'IN_PROGRESS', 'RESOLVED', 'REJECTED') DEFAULT 'PENDING',
    ward            INT,
    location_text   VARCHAR(200),
    latitude        DECIMAL(10, 8),
    longitude       DECIMAL(11, 8),
    image_url       VARCHAR(500),
    user_id         INT NOT NULL,
    assigned_to     INT,
    upvote_count    INT DEFAULT 0,
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (category_id) REFERENCES categories(id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (assigned_to) REFERENCES users(id),

    INDEX idx_complaints_status (status),
    INDEX idx_complaints_category (category_id),
    INDEX idx_complaints_user (user_id),
    INDEX idx_complaints_ward (ward),
    INDEX idx_complaints_created (created_at DESC)
) ENGINE=InnoDB;

-- ============================================================
-- UPVOTES TABLE
-- ============================================================
CREATE TABLE upvotes (
    id              INT PRIMARY KEY AUTO_INCREMENT,
    complaint_id    INT NOT NULL,
    user_id         INT NOT NULL,
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    UNIQUE KEY unique_upvote (complaint_id, user_id),
    FOREIGN KEY (complaint_id) REFERENCES complaints(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id)
) ENGINE=InnoDB;

-- ============================================================
-- STATUS HISTORY TABLE (Audit Trail)
-- ============================================================
CREATE TABLE status_history (
    id              INT PRIMARY KEY AUTO_INCREMENT,
    complaint_id    INT NOT NULL,
    old_status      VARCHAR(20),
    new_status      VARCHAR(20) NOT NULL,
    changed_by      INT NOT NULL,
    remarks         TEXT,
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (complaint_id) REFERENCES complaints(id) ON DELETE CASCADE,
    FOREIGN KEY (changed_by) REFERENCES users(id),

    INDEX idx_history_complaint (complaint_id)
) ENGINE=InnoDB;

-- ============================================================
-- NOTIFICATIONS TABLE
-- ============================================================
CREATE TABLE notifications (
    id                      INT PRIMARY KEY AUTO_INCREMENT,
    user_id                 INT NOT NULL,
    title                   VARCHAR(100),
    message                 VARCHAR(500) NOT NULL,
    type                    ENUM('STATUS_UPDATE', 'NEW_COMMENT', 'ANNOUNCEMENT', 'SYSTEM') DEFAULT 'SYSTEM',
    related_complaint_id    INT,
    is_read                 BOOLEAN DEFAULT FALSE,
    created_at              TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (related_complaint_id) REFERENCES complaints(id) ON DELETE SET NULL,

    INDEX idx_notifications_user (user_id),
    INDEX idx_notifications_unread (user_id, is_read)
) ENGINE=InnoDB;


-- ============================================================
-- SEED DATA
-- ============================================================

-- Default Categories
INSERT INTO categories (name, icon, color_code) VALUES
    ('Road Damage',     'road',         '#9E0A0F'),
    ('Garbage',         'trash',        '#10B981'),
    ('Water Supply',    'water',        '#3B82F6'),
    ('Electricity',     'electricity',  '#F59E0B'),
    ('Street Lights',   'light',        '#8B5CF6'),
    ('Drainage',        'drainage',     '#EC4899'),
    ('Public Safety',   'safety',       '#EF4444'),
    ('Other',           'other',        '#6B7280');

-- Default Admin User (password: admin123 — CHANGE IN PRODUCTION)
INSERT INTO users (full_name, email, password_hash, role, ward) VALUES
    ('Admin User', 'admin@civicpulse.local', 'admin123', 'ADMIN', 1);

-- Default Test Citizen (password: test123 — CHANGE IN PRODUCTION)
INSERT INTO users (full_name, email, phone, password_hash, role, ward) VALUES
    ('Ram Sharma', 'ram@example.com', '9841234567', 'test123', 'CITIZEN', 5);
