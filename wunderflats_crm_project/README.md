# Wunderflats CRM Lifecycle Analysis - SQL Portfolio Project

## Overview

This project is designed to demonstrate my analytical capabilities and understanding of the CRM Lead role at Wunderflats. It simulates a two-sided marketplace environment (landlords and tenants) and provides a suite of SQL queries to analyze user lifecycles, activation, conversion, and retention.

The goal is to showcase how data can be leveraged to build automated journeys, define segmentation logic, and optimize CRM KPIs across both supply and demand sides of the Wunderflats platform.

## Project Structure

The repository is organized as follows:

- `sql/01_create_schema.sql`: Defines the relational database schema, including tables for `users`, `landlords`, `tenants`, `listings`, `bookings`, and `user_events`.
- `sql/02_seed_data.sql`: Populates the database with realistic sample data representing various stages of the landlord and tenant lifecycles.
- `sql/03_crm_queries.sql`: Contains the core analytical queries designed to answer key business questions and drive CRM strategy.

## Database Schema

The database is structured to capture the complexities of a mid-term rental marketplace:

- **Users**: Central table for all registered accounts, distinguishing between `landlord` and `tenant` types.
- **Landlords & Tenants**: Specialized tables storing profile information specific to each user type.
- **Listings**: Properties offered by landlords, tracking status (draft, active, inactive, booked).
- **Bookings**: Confirmed rental agreements, linking tenants, landlords, and listings.
- **User Events**: A crucial table for lifecycle analysis, logging actions like sign-ups, listing views, booking requests, and listing activations.

## Key CRM Insights Addressed

The SQL queries in `03_crm_queries.sql` are categorized to address specific areas of the CRM Lead's responsibilities:

### 1. Supply (Landlords) Lifecycle
- **Activation Rate**: Measuring the percentage of registered landlords who successfully create their first active listing.
- **Lead-to-Listing Conversion**: Analyzing the time it takes for a new landlord to become active, identifying potential bottlenecks in the onboarding journey.
- **Reactivation Opportunities**: Identifying landlords whose listings have gone inactive, providing a target audience for re-engagement campaigns.
- **Performance Tracking**: Monitoring the number of active listings per landlord to identify high-value partners.

### 2. Demand (Tenants) Lifecycle
- **Behavioral Segmentation**: Categorizing tenants based on their recent activity (e.g., active searchers vs. inactive users) to tailor messaging.
- **Visit-to-Booking Conversion**: Calculating the critical conversion rate from viewing a listing to confirming a booking.
- **Retention & Repeat Usage**: Identifying tenants who book multiple times, crucial for the mid-term rental model where users may move frequently.
- **Re-engagement Targeting**: Finding tenants who have become inactive to trigger win-back campaigns.

### 3. Overall Marketplace Health
- **User Growth**: Tracking monthly registrations across both supply and demand.
- **Booking Value**: Estimating the financial impact of confirmed bookings over time.
- **Churn Analysis**: Identifying structural churn (e.g., landlords who stop listing entirely).

## How to Run This Project

To execute these queries and explore the data yourself, you can use any standard SQL database environment (e.g., MySQL, PostgreSQL, SQLite).

1.  **Set up your database**: Create a new database in your preferred SQL client.
2.  **Run the schema script**: Execute `sql/01_create_schema.sql` to create the necessary tables.
3.  **Load the seed data**: Execute `sql/02_seed_data.sql` to populate the tables with sample data.
4.  **Run the analysis**: Execute the queries in `sql/03_crm_queries.sql` to view the CRM insights.

## Conclusion

This project highlights my ability to translate complex business requirements into actionable data models and analytical queries. By understanding the distinct lifecycles of landlords and tenants, I am prepared to design and execute CRM strategies that drive activation, conversion, and retention at Wunderflats.
