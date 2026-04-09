# Smart Event Management System

## Project Overview
This project is a **Smart Event Management System** built using **MySQL**. It is designed to help event organizers manage venues, track attendee registrations, monitor ticket sales, and analyze revenue. The system implements advanced SQL concepts including CRUD operations, joins, subqueries, window functions, and case expressions.

## Database Schema
The system consists of 6 primary tables:
- **Venues**: Information about event locations and their capacity.
- **Organizers**: Details of organizations managing the events.
- **Attendees**: Personal information of participants.
- **Events**: Core table containing event schedules, pricing, and seat availability.
- **Tickets**: Records of bookings made by attendees for specific events.
- **Payments**: Financial transaction records linked to tickets.



## Key Features & Functionalities
The project covers the following SQL milestones:
1. **CRUD Operations**: Adding, updating, and deleting events and bookings.
2. **Data Analysis**: Using `GROUP BY`, `ORDER BY`, and `HAVING` for reporting.
3. **Complex Joins**: Combining multiple tables (Inner, Left, Right, Union) to generate insights.
4. **Aggregate Functions**: Calculating total revenue, average prices, and peak attendance.
5. **Advanced Queries**: Implementing **Subqueries** and **Window Functions** for ranking and cumulative totals.
6. **Logical Classification**: Using **CASE Expressions** to categorize event demand and payment statuses.
7. **String & Date Functions**: Formatting dates and cleaning string data for better presentation.

## How to Use
1. Clone this repository.
2. Import the `event_management.sql` file into your MySQL environment.
3. Run the queries sequentially to set up the database, insert dummy data, and test various functionalities.

## Project Structure
```bash
├── event_management.sql   # Complete SQL script with schema and queries
└── README.md              # Project documentation (this file)
