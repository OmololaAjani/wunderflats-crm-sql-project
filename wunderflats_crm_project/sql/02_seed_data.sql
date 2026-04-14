-- Seed data for users
INSERT INTO users (user_id, email, registration_date, user_type, last_login) VALUES
(1, 'landlord1@example.com', '2023-01-01 10:00:00', 'landlord', '2024-04-10 14:30:00'),
(2, 'landlord2@example.com', '2023-01-15 11:00:00', 'landlord', '2024-03-20 09:00:00'),
(3, 'landlord3@example.com', '2023-02-01 12:00:00', 'landlord', '2023-02-01 12:00:00'), -- Registered but inactive
(4, 'tenant1@example.com', '2023-01-05 13:00:00', 'tenant', '2024-04-12 16:00:00'),
(5, 'tenant2@example.com', '2023-01-20 14:00:00', 'tenant', '2024-01-01 10:00:00'), -- Inactive tenant
(6, 'tenant3@example.com', '2023-02-10 15:00:00', 'tenant', '2024-04-11 11:00:00'),
(7, 'landlord4@example.com', '2023-03-01 09:00:00', 'landlord', '2024-04-05 10:00:00'), -- New active landlord
(8, 'tenant4@example.com', '2023-03-05 10:00:00', 'tenant', '2024-04-08 12:00:00'), -- New active tenant
(9, 'landlord5@example.com', '2023-04-01 11:00:00', 'landlord', '2023-04-01 11:00:00'), -- New registered, no listing
(10, 'tenant5@example.com', '2023-04-05 12:00:00', 'tenant', '2024-04-05 12:00:00'); -- New registered, no activity

-- Seed data for landlords
INSERT INTO landlords (landlord_id, user_id, company_name, has_listed) VALUES
(1, 1, 'Property Management Inc.', TRUE),
(2, 2, NULL, TRUE),
(3, 3, NULL, FALSE),
(4, 7, 'City Rentals', TRUE),
(5, 9, NULL, FALSE);

-- Seed data for tenants
INSERT INTO tenants (tenant_id, user_id, search_preferences) VALUES
(1, 4, '{"city": "Berlin", "min_price": 800, "max_price": 1500}'),
(2, 5, '{"city": "Munich", "duration": "3-6 months"}'),
(3, 6, '{"city": "Hamburg", "pets_allowed": true}'),
(4, 8, '{"city": "Berlin", "furnished": true}'),
(5, 10, '{"city": "Cologne"}');

-- Seed data for listings
INSERT INTO listings (listing_id, landlord_id, title, status, created_at, updated_at, city, price_per_month) VALUES
(1, 1, 'Cozy Apartment in Berlin', 'active', '2023-01-02 10:00:00', '2024-03-01 11:00:00', 'Berlin', 1200.00),
(2, 1, 'Spacious Flat in Munich', 'active', '2023-01-03 11:00:00', '2024-02-15 10:00:00', 'Munich', 1500.00),
(3, 2, 'Studio in Hamburg', 'active', '2023-01-16 12:00:00', '2024-01-20 09:00:00', 'Hamburg', 900.00),
(4, 2, 'Luxury Loft in Berlin', 'booked', '2023-02-05 13:00:00', '2023-03-10 14:00:00', 'Berlin', 1800.00),
(5, 4, 'Modern Apartment in Berlin', 'active', '2023-03-02 10:00:00', '2024-04-01 10:00:00', 'Berlin', 1350.00),
(6, 1, 'Small Room in Shared Flat', 'inactive', '2023-01-04 10:00:00', '2023-06-01 10:00:00', 'Berlin', 700.00); -- Inactive listing

-- Seed data for bookings
INSERT INTO bookings (booking_id, listing_id, tenant_id, landlord_id, start_date, end_date, booking_date, status) VALUES
(1, 1, 1, 1, '2023-03-01', '2023-08-31', '2023-02-20 10:00:00', 'completed'),
(2, 4, 3, 2, '2023-04-01', '2023-09-30', '2023-03-15 11:00:00', 'completed'),
(3, 1, 4, 1, '2024-05-01', '2024-10-31', '2024-04-01 12:00:00', 'confirmed'),
(4, 5, 4, 4, '2024-06-01', '2024-11-30', '2024-04-05 14:00:00', 'confirmed');

-- Seed data for user_events
INSERT INTO user_events (event_id, user_id, event_type, event_timestamp, listing_id, details) VALUES
-- Landlord 1
(1, 1, 'signed_up', '2023-01-01 10:00:00', NULL, NULL),
(2, 1, 'listing_created', '2023-01-02 10:00:00', 1, '{"title": "Cozy Apartment in Berlin"}'),
(3, 1, 'listing_activated', '2023-01-02 10:30:00', 1, NULL),
(4, 1, 'listing_created', '2023-01-03 11:00:00', 2, '{"title": "Spacious Flat in Munich"}'),
(5, 1, 'listing_activated', '2023-01-03 11:30:00', 2, NULL),
(6, 1, 'booking_confirmed', '2023-02-20 10:00:00', 1, '{"tenant_id": 1}'),
(7, 1, 'listing_created', '2023-01-04 10:00:00', 6, '{"title": "Small Room in Shared Flat"}'),
(8, 1, 'listing_deactivated', '2023-06-01 10:00:00', 6, NULL),

-- Landlord 2
(9, 2, 'signed_up', '2023-01-15 11:00:00', NULL, NULL),
(10, 2, 'listing_created', '2023-01-16 12:00:00', 3, '{"title": "Studio in Hamburg"}'),
(11, 2, 'listing_activated', '2023-01-16 12:30:00', 3, NULL),
(12, 2, 'listing_created', '2023-02-05 13:00:00', 4, '{"title": "Luxury Loft in Berlin"}'),
(13, 2, 'listing_activated', '2023-02-05 13:30:00', 4, NULL),
(14, 2, 'booking_confirmed', '2023-03-15 11:00:00', 4, '{"tenant_id": 3}'),

-- Landlord 3 (Inactive)
(15, 3, 'signed_up', '2023-02-01 12:00:00', NULL, NULL),

-- Landlord 4 (New active)
(16, 7, 'signed_up', '2023-03-01 09:00:00', NULL, NULL),
(17, 7, 'listing_created', '2023-03-02 10:00:00', 5, '{"title": "Modern Apartment in Berlin"}'),
(18, 7, 'listing_activated', '2023-03-02 10:30:00', 5, NULL),
(19, 7, 'booking_confirmed', '2024-04-05 14:00:00', 5, '{"tenant_id": 4}'),

-- Landlord 5 (New registered, no listing)
(20, 9, 'signed_up', '2023-04-01 11:00:00', NULL, NULL),

-- Tenant 1
(21, 4, 'signed_up', '2023-01-05 13:00:00', NULL, NULL),
(22, 4, 'viewed_listing', '2023-01-06 14:00:00', 1, NULL),
(23, 4, 'sent_booking_request', '2023-01-07 15:00:00', 1, NULL),
(24, 4, 'booking_confirmed', '2023-02-20 10:00:00', 1, '{"landlord_id": 1}'),
(25, 4, 'viewed_listing', '2024-03-25 10:00:00', 1, NULL),
(26, 4, 'sent_booking_request', '2024-03-26 11:00:00', 1, NULL),
(27, 4, 'booking_confirmed', '2024-04-01 12:00:00', 1, '{"landlord_id": 1}'),

-- Tenant 2 (Inactive)
(28, 5, 'signed_up', '2023-01-20 14:00:00', NULL, NULL),
(29, 5, 'viewed_listing', '2023-01-21 15:00:00', 2, NULL),
(30, 5, 'viewed_listing', '2023-01-22 16:00:00', 3, NULL),

-- Tenant 3
(31, 6, 'signed_up', '2023-02-10 15:00:00', NULL, NULL),
(32, 6, 'viewed_listing', '2023-02-11 16:00:00', 4, NULL),
(33, 6, 'sent_booking_request', '2023-02-12 17:00:00', 4, NULL),
(34, 6, 'booking_confirmed', '2023-03-15 11:00:00', 4, '{"landlord_id": 2}'),

-- Tenant 4 (New active)
(35, 8, 'signed_up', '2023-03-05 10:00:00', NULL, NULL),
(36, 8, 'viewed_listing', '2024-03-06 11:00:00', 5, NULL),
(37, 8, 'sent_booking_request', '2024-03-07 12:00:00', 5, NULL),
(38, 8, 'booking_confirmed', '2024-04-05 14:00:00', 5, '{"landlord_id": 4}'),

-- Tenant 5 (New registered, no activity)
(39, 10, 'signed_up', '2023-04-05 12:00:00', NULL, NULL);
