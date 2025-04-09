CREATE DATABASE IF NOT EXISTS ventech_db;

USE ventech_db;

-- Create the users table first
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,  -- Ensuring uniqueness of email
    password VARCHAR(255) NOT NULL,
    contact_number VARCHAR(15),  -- Can store phone numbers including international formats
    location VARCHAR(100),  -- For storing the user's location
    role ENUM('admin', 'guest', 'client') DEFAULT 'guest',  -- Added 'client' role
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB; -- Correct position for ENGINE

INSERT INTO `users` (`id`, `username`, `email`, `password`, `contact_number`, `location`, `role`, `created_at`) VALUES
(1, 'kaylaok', 'kaylatizon5@gmail.com', '$2y$10$4ULv/NJcXUyCZBkFQyDtr.0g6IxE5ZBlAi4pbxv2.67xdWamNEoqC', '09612345678', 'Manila', 'client', '2025-04-09 10:08:55');

-- Create the venue table with user_id as a foreign key
CREATE TABLE venue (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,  -- Foreign key to the users table
    title VARCHAR(100) NOT NULL,
    price DECIMAL(10,2) NOT NULL,
    image_path VARCHAR(255),  -- Updated from image_url to image_path
    description TEXT,
    additional_info TEXT,
    reviews INT DEFAULT 0,
    amenities VARCHAR(255) DEFAULT '',  -- New column for amenities
    wifi ENUM('yes', 'no') DEFAULT 'no',  -- New column for wifi availability
    parking ENUM('yes', 'no') DEFAULT 'no',  -- New column for parking availability
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB;



-- Create the reservations table
CREATE TABLE reservations (
    id INT AUTO_INCREMENT PRIMARY KEY,
    venue_id INT NOT NULL,
    guest_name VARCHAR(100),
    guest_email VARCHAR(100),
    check_in DATE,
    check_out DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (venue_id) REFERENCES venue(id)
) ENGINE=InnoDB;  -- Correct position for ENGINE

-- Create the venue_availability table
CREATE TABLE venue_availability (
    id INT AUTO_INCREMENT PRIMARY KEY,
    venue_id INT NOT NULL,
    date DATE NOT NULL,
    available BOOLEAN DEFAULT 0,  -- 0 for unavailable, 1 for available
    FOREIGN KEY (venue_id) REFERENCES venue(id)
) ENGINE=InnoDB;  -- Correct position for ENGINE
