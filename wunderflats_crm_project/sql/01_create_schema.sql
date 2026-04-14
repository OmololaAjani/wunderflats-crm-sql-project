-- Drop tables if they exist to ensure a clean slate
DROP TABLE IF EXISTS bookings;
DROP TABLE IF EXISTS listings;
DROP TABLE IF EXISTS user_events;
DROP TABLE IF EXISTS landlords;
DROP TABLE IF EXISTS tenants;
DROP TABLE IF EXISTS users;

-- Table: users
CREATE TABLE users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) UNIQUE NOT NULL,
    registration_date DATETIME NOT NULL,
    user_type ENUM('landlord', 'tenant') NOT NULL,
    last_login DATETIME
);

-- Table: landlords
CREATE TABLE landlords (
    landlord_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT UNIQUE NOT NULL,
    company_name VARCHAR(255),
    has_listed BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Table: tenants
CREATE TABLE tenants (
    tenant_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT UNIQUE NOT NULL,
    search_preferences TEXT,
    FOREIGN KEY (user_id) REFERENCES users(user_id)
);

-- Table: listings
CREATE TABLE listings (
    listing_id INT AUTO_INCREMENT PRIMARY KEY,
    landlord_id INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    status ENUM('draft', 'active', 'inactive', 'booked') NOT NULL,
    created_at DATETIME NOT NULL,
    updated_at DATETIME,
    city VARCHAR(100),
    price_per_month DECIMAL(10,2),
    FOREIGN KEY (landlord_id) REFERENCES landlords(landlord_id)
);

-- Table: bookings
CREATE TABLE bookings (
    booking_id INT AUTO_INCREMENT PRIMARY KEY,
    listing_id INT NOT NULL,
    tenant_id INT NOT NULL,
    landlord_id INT NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    booking_date DATETIME NOT NULL,
    status ENUM('pending', 'confirmed', 'cancelled', 'completed') NOT NULL,
    FOREIGN KEY (listing_id) REFERENCES listings(listing_id),
    FOREIGN KEY (tenant_id) REFERENCES tenants(tenant_id),
    FOREIGN KEY (landlord_id) REFERENCES landlords(landlord_id)
);

-- Table: user_events
CREATE TABLE user_events (
    event_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    event_type VARCHAR(100) NOT NULL,
    event_timestamp DATETIME NOT NULL,
    listing_id INT,
    details TEXT,
    FOREIGN KEY (user_id) REFERENCES users(user_id),
    FOREIGN KEY (listing_id) REFERENCES listings(listing_id)
);
