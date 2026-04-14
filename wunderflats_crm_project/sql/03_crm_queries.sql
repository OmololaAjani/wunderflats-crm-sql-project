-- CRM Analytical Queries for Wunderflats

-- 1. Landlord Lifecycle Analysis

-- 1.1. Landlord Activation Rate
-- Percentage of registered landlords who have created at least one active listing.
SELECT
    (COUNT(DISTINCT l.landlord_id) * 100.0 / (SELECT COUNT(*) FROM landlords)) AS activation_rate_percentage
FROM
    landlords l
WHERE
    l.has_listed = TRUE;

-- 1.2. Lead-to-Listing Conversion Time
-- Average time taken from landlord registration to their first active listing.
SELECT
    AVG(TIMESTAMPDIFF(HOUR, u.registration_date, MIN(le.event_timestamp))) AS avg_hours_to_first_listing
FROM
    users u
JOIN
    landlords l ON u.user_id = l.user_id
JOIN
    user_events le ON u.user_id = le.user_id
WHERE
    u.user_type = 'landlord'
    AND le.event_type = 'listing_activated'
GROUP BY
    u.user_id;

-- 1.3. Inactive Landlords (for Reactivation Campaigns)
-- Landlords who have not had an active listing in the last 3 months.
SELECT
    u.user_id, u.email, u.registration_date, l.landlord_id
FROM
    users u
JOIN
    landlords l ON u.user_id = l.user_id
LEFT JOIN
    listings li ON l.landlord_id = li.landlord_id AND li.status = 'active'
WHERE
    u.user_type = 'landlord'
GROUP BY
    u.user_id, u.email, u.registration_date, l.landlord_id
HAVING
    MAX(li.updated_at) < DATE_SUB(CURDATE(), INTERVAL 3 MONTH) OR MAX(li.updated_at) IS NULL;

-- 1.4. Landlord Listing Performance
-- Number of active listings per landlord.
SELECT
    l.landlord_id, u.email, COUNT(li.listing_id) AS active_listings_count
FROM
    landlords l
JOIN
    users u ON l.user_id = u.user_id
LEFT JOIN
    listings li ON l.landlord_id = li.landlord_id AND li.status = 'active'
GROUP BY
    l.landlord_id, u.email
ORDER BY
    active_listings_count DESC;

-- 2. Tenant Lifecycle Analysis

-- 2.1. Tenant Segmentation (Active Searchers vs. Inactive Searchers)
-- Active searchers: viewed a listing or sent a booking request in the last 30 days.
-- Inactive searchers: registered but no activity in the last 30 days.
SELECT
    u.user_id, u.email,
    CASE
        WHEN MAX(ue.event_timestamp) >= DATE_SUB(CURDATE(), INTERVAL 30 DAY) THEN 'Active Searcher'
        ELSE 'Inactive Searcher'
    END AS tenant_segment
FROM
    users u
JOIN
    tenants t ON u.user_id = t.user_id
LEFT JOIN
    user_events ue ON u.user_id = ue.user_id
WHERE
    u.user_type = 'tenant'
GROUP BY
    u.user_id, u.email;

-- 2.2. Visit-to-Booking Conversion Rate
-- Percentage of tenants who viewed a listing and then confirmed a booking.
SELECT
    (COUNT(DISTINCT b.tenant_id) * 100.0 / COUNT(DISTINCT ue.user_id)) AS visit_to_booking_conversion_rate
FROM
    user_events ue
LEFT JOIN
    bookings b ON ue.user_id = b.tenant_id
WHERE
    ue.event_type = 'viewed_listing'
    AND b.status = 'confirmed';

-- 2.3. Tenant Retention / Repeat Usage
-- Tenants with more than one confirmed booking.
SELECT
    t.tenant_id, u.email, COUNT(b.booking_id) AS total_bookings
FROM
    tenants t
JOIN
    users u ON t.user_id = u.user_id
JOIN
    bookings b ON t.tenant_id = b.tenant_id
WHERE
    b.status = 'confirmed'
GROUP BY
    t.tenant_id, u.email
HAVING
    COUNT(b.booking_id) > 1
ORDER BY
    total_bookings DESC;

-- 2.4. Inactive Tenants (for Re-engagement Campaigns)
-- Tenants who have not logged in or performed any event in the last 60 days.
SELECT
    u.user_id, u.email, u.registration_date, u.last_login
FROM
    users u
LEFT JOIN
    user_events ue ON u.user_id = ue.user_id
WHERE
    u.user_type = 'tenant'
GROUP BY
    u.user_id, u.email, u.registration_date, u.last_login
HAVING
    MAX(ue.event_timestamp) < DATE_SUB(CURDATE(), INTERVAL 60 DAY) OR MAX(ue.event_timestamp) IS NULL
    AND u.last_login < DATE_SUB(CURDATE(), INTERVAL 60 DAY);

-- 3. General CRM Metrics

-- 3.1. Monthly New User Registrations (Landlords vs. Tenants)
SELECT
    DATE_FORMAT(registration_date, '%Y-%m') AS registration_month,
    user_type,
    COUNT(user_id) AS new_users_count
FROM
    users
GROUP BY
    registration_month, user_type
ORDER BY
    registration_month, user_type;

-- 3.2. Monthly Booking Volume and Value
SELECT
    DATE_FORMAT(b.booking_date, '%Y-%m') AS booking_month,
    COUNT(b.booking_id) AS total_bookings,
    SUM(li.price_per_month * TIMESTAMPDIFF(MONTH, b.start_date, b.end_date)) AS estimated_booking_value
FROM
    bookings b
JOIN
    listings li ON b.listing_id = li.listing_id
WHERE
    b.status = 'confirmed'
GROUP BY
    booking_month
ORDER BY
    booking_month;

-- 3.3. Churn Analysis (Landlords)
-- Landlords who had active listings but now have none for over 3 months.
SELECT
    u.user_id, u.email, l.landlord_id
FROM
    users u
JOIN
    landlords l ON u.user_id = l.user_id
WHERE
    u.user_type = 'landlord'
    AND l.has_listed = TRUE -- They had listed before
    AND NOT EXISTS (
        SELECT 1
        FROM listings li
        WHERE li.landlord_id = l.landlord_id
        AND li.status = 'active'
        AND li.updated_at >= DATE_SUB(CURDATE(), INTERVAL 3 MONTH)
    );
