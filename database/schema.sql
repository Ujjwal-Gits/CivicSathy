CREATE DATABASE IF NOT EXISTS civicsathy;
USE civicsathy;

CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    phone VARCHAR(30),
    ward INT NOT NULL,
    role VARCHAR(20) NOT NULL DEFAULT 'CITIZEN',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT
);

CREATE TABLE IF NOT EXISTS complaints (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tracking_id VARCHAR(50) NOT NULL UNIQUE,
    user_id INT NOT NULL,
    category_id INT NOT NULL,
    title VARCHAR(200) NOT NULL,
    description TEXT NOT NULL,
    location VARCHAR(255),
    status VARCHAR(50) DEFAULT 'PENDING',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

-- Seed data for testing
INSERT INTO categories (name, description) VALUES 
('Roads', 'Potholes, street lights, blockages'),
('Sanitation', 'Waste collection, sewage issues'),
('Water', 'Leakages, no supply'),
('Electricity', 'Power outages, loose wires');

INSERT INTO users (full_name, email, password_hash, phone, ward, role) 
VALUES ('Admin User', 'admin@civicsathy.com', 'admin123', '9800000000', 1, 'ADMIN')
ON DUPLICATE KEY UPDATE email = email;
