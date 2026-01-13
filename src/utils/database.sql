-- Create Database (Run this first in PostgreSQL)
-- CREATE DATABASE travel_guide_db;

-- Connect to the database and run the following:

-- Locations Table (GeoInfo)
CREATE TABLE IF NOT EXISTS locations (
    id SERIAL PRIMARY KEY,
    location_name VARCHAR(255) NOT NULL,
    country_code VARCHAR(10),
    country VARCHAR(100),
    additional_info JSONB,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Flights Table
CREATE TABLE IF NOT EXISTS flights (
    id SERIAL PRIMARY KEY,
    flight_name VARCHAR(255) NOT NULL,
    arrival_airport VARCHAR(255),
    departure_airport VARCHAR(255),
    arrival_time TIMESTAMP,
    departure_time TIMESTAMP,
    flight_logo TEXT,
    fare DECIMAL(10, 2),
    location_country VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Attractions Table
CREATE TABLE IF NOT EXISTS attractions (
    id SERIAL PRIMARY KEY,
    attraction_name VARCHAR(255) NOT NULL,
    attraction_slug VARCHAR(255) UNIQUE,
    additional_info TEXT,
    cancellation_policy TEXT,
    images JSONB,
    price DECIMAL(10, 2),
    whats_included TEXT,
    country VARCHAR(100),
    city VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Create indexes for better query performance
CREATE INDEX IF NOT EXISTS idx_flights_location ON flights(location_country);
CREATE INDEX IF NOT EXISTS idx_attractions_country ON attractions(country);
CREATE INDEX IF NOT EXISTS idx_attractions_city ON attractions(city);
CREATE INDEX IF NOT EXISTS idx_locations_name ON locations(location_name);