/* Project Title: Smart Event Management System 
   Database Setup and Functionalities 
*/

-- Create Database
create database event_management;
use event_management;

-- TABLE CREATION (Establishing Schema)

-- 1. Venues Table: Stores location and capacity details
create table venues (
    venue_id int primary key auto_increment,
    venue_name varchar(100) not null,
    location varchar(255),
    capacity int
);

-- 2. Organizers Table: Stores contact details of event planners
create table organizers (
    organizer_id int primary key auto_increment,
    organizer_name varchar(100) not null,
    contact_email varchar(100) unique,
    phone_number varchar(15)
);

-- 3. Attendees Table: Stores participant information
create table attendees (
    attendee_id int primary key auto_increment,
    name varchar(100) not null,
    email varchar(100) unique,
    phone_number varchar(15)
);

-- 4. Events Table: Core table for event details linked to venues and organizers
create table events (
    event_id int primary key auto_increment,
    event_name varchar(150) not null,
    event_date date,
    venue_id int,
    organizer_id int,
    ticket_price decimal(10, 2),
    total_seats int,
    available_seats int,
    foreign key (venue_id) references venues(venue_id),
    foreign key (organizer_id) references organizers(organizer_id)
);

-- 5. Tickets Table: Records bookings made by attendees
create table tickets (
    ticket_id int primary key auto_increment,
    event_id int,
    attendee_id int,
    booking_date datetime default current_timestamp,
    status enum('confirmed', 'cancelled', 'pending'),
    foreign key (event_id) references events(event_id),
    foreign key (attendee_id) references attendees(attendee_id)
);

-- 6. Payments Table: Tracks financial transactions for tickets
create table payments (
    payment_id int primary key auto_increment,
    ticket_id int,
    amount_paid decimal(10, 2),
    payment_status enum('success', 'failed', 'pending'),
    payment_date datetime default current_timestamp,
    foreign key (ticket_id) references tickets(ticket_id)
);

-- DATA INSERTION (Populating Tables)

-- Inserting Master Data: Venues
insert into venues (venue_name, location, capacity) values
('science city auditorium', 'ahmedabad', 500),
('reliance greens', 'jamnagar', 1000),
('town hall', 'rajkot', 300),
('convention center', 'surat', 800),
('laxmi vilas palace ground', 'vadodara', 2000);

-- Inserting Master Data: Organizers
insert into organizers (organizer_name, contact_email, phone_number) values
('tech events india', 'info@techevents.com', '9876543210'),
('cultural heritage group', 'events@heritage.org', '9898989898'),
('business summit org', 'contact@bsummit.in', '9765432109'),
('music mania', 'support@musicmania.com', '9123456789'),
('global expo', 'expo@global.com', '9000011122');

-- Inserting Main Data: Events
insert into events (event_name, event_date, venue_id, organizer_id, ticket_price, total_seats, available_seats) values
('ai & future tech', '2026-05-15', 1, 1, 500.00, 100, 5),
('garba night 2026', '2026-10-20', 5, 2, 1200.00, 500, 250),
('startup meetup', '2026-06-10', 3, 3, 300.00, 50, 45),
('rock concert', '2026-07-05', 2, 4, 1500.00, 200, 10),
('corporate finance seminar', '2026-08-12', 4, 3, 800.00, 100, 80),
('digital marketing workshop', '2026-05-20', 1, 1, 400.00, 60, 12),
('classical music evening', '2026-09-15', 3, 2, 600.00, 80, 75);

-- Inserting Records: Attendees
insert into attendees (name, email, phone_number) values
('aarav patel', 'aarav@gmail.com', '9988776655'),
('isha shah', 'isha@yahoo.com', '9977665544'),
('rohan mehta', 'rohan.m@gmail.com', '9966554433'),
('ananya iyer', 'ananya@outlook.com', '9955443322'),
('kabir joshi', 'kabir.j@gmail.com', '9944332211'),
('meera desai', null, '9933221100'),
('vihaan gupta', 'vihaan@gmail.com', '9922110099'),
('sia malhotra', 'sia.m@gmail.com', '9911009988'),
('aryan rao', 'aryan@live.com', '9900998877'),
('diya vyas', 'diya@gmail.com', '9898987766');

-- Inserting Records: Tickets
insert into tickets (event_id, attendee_id, status) values
(1, 1, 'confirmed'), (1, 2, 'confirmed'), (1, 3, 'confirmed'),
(2, 4, 'confirmed'), (2, 5, 'pending'), (2, 6, 'confirmed'),
(3, 7, 'confirmed'), (4, 8, 'confirmed'), (4, 9, 'cancelled'),
(5, 10, 'confirmed'), (1, 4, 'confirmed'), (2, 1, 'confirmed'),
(4, 2, 'confirmed'), (6, 3, 'confirmed'), (7, 5, 'confirmed');

-- Inserting Records: Payments
insert into payments (ticket_id, amount_paid, payment_status) values
(1, 500.00, 'success'), (2, 500.00, 'success'), (3, 500.00, 'success'),
(4, 1200.00, 'success'), (5, 0.00, 'pending'), (6, 1200.00, 'success'),
(7, 300.00, 'success'), (8, 1500.00, 'success'), (9, 0.00, 'failed'),
(10, 800.00, 'success'), (11, 500.00, 'success'), (12, 1200.00, 'success'),
(13, 1500.00, 'success'), (14, 400.00, 'success'), (15, 600.00, 'success');

-- ---------------------------------------------------------
-- TASK 1: Implement CRUD Operations 
-- ---------------------------------------------------------
-- to add new event
insert into events (event_name, event_date, venue_id, organizer_id, ticket_price, total_seats, available_seats) 
values ('tech expo 2026', '2026-12-01', 1, 1, 450.00, 100, 100);

-- to update ticket price of eventid 1
update events 
set ticket_price = 550.00 
where event_id = 1;

-- to reduce available seats when booking a tickets
update events 
set available_seats = available_seats - 1 
where event_id = 1 and available_seats > 0;

-- to delete ticketid 9
delete from tickets 
where ticket_id = 9;

-- if specific event is canceled
delete from events 
where event_id = 7;

-- to search tech events
select * from events 
where event_name like '%tech%';

-- to search events happening in ahmedabad
select e.event_name, v.venue_name, v.location 
from events e
join venues v on e.venue_id = v.venue_id
where v.location = 'ahmedabad';

-- search event price under 500
select * from events 
where ticket_price <= 500;

-- ---------------------------------------------------------
-- TASK 2: Use SQL Clauses (WHERE, HAVING, LIMIT)
-- ---------------------------------------------------------
-- get upcoming events happening in a specific city
select e.event_name, e.event_date, v.venue_name, v.location
from events e
join venues v on e.venue_id = v.venue_id
where v.location = 'rajkot';

-- retrieve the top 5 highest revenue-generating events
select e.event_name, sum(p.amount_paid) as total_revenue
from events e
join tickets t on e.event_id = t.event_id
join payments p on t.ticket_id = p.ticket_id
where p.payment_status = 'success'
group by e.event_id
order by total_revenue desc
limit 5;

-- find attendees who booked tickets in the last 7 days
select a.name, t.booking_date, e.event_name
from attendees a
join tickets t on a.attendee_id = t.attendee_id
join events e on t.event_id = e.event_id
where t.booking_date >= date_sub(curdate(), interval 7 day);

-- ---------------------------------------------------------
-- TASK 3: Apply SQL Operators (AND, OR, NOT) 
-- ---------------------------------------------------------
-- retrieve events scheduled in december and have more than 50% available seats
select event_name, event_date, available_seats, total_seats
from events
where month(event_date) = 12 
and available_seats > (total_seats / 2);

-- list attendees who have booked a ticket or have a pending payment
select distinct a.name, a.email
from attendees a
join tickets t on a.attendee_id = t.attendee_id
left join payments p on t.ticket_id = p.ticket_id
where t.status = 'confirmed' 
or p.payment_status = 'pending';

-- identify events that are not fully booked
select event_name, available_seats
from events
where not available_seats = 0;

-- ---------------------------------------------------------
-- TASK 4: Sorting and Grouping Data (ORDER BY, GROUP BY)
-- ---------------------------------------------------------
-- sort events by date in ascending order
select * from events 
order by event_date asc;

-- count the number of attendees per event
select e.event_name, count(t.attendee_id) as total_attendees
from events e
left join tickets t on e.event_id = t.event_id
group by e.event_id, e.event_name;

-- show the total revenue generated per event
select e.event_name, sum(p.amount_paid) as total_revenue
from events e
join tickets t on e.event_id = t.event_id
join payments p on t.ticket_id = p.ticket_id
where p.payment_status = 'success'
group by e.event_id, e.event_name;

-- ---------------------------------------------------------
-- TASK 5: Aggregate Functions (SUM, AVG, MAX, MIN, COUNT)
-- ---------------------------------------------------------
-- calculate the total revenue generated from all events
select sum(amount_paid) as overall_total_revenue 
from payments 
where payment_status = 'success';

-- find the event with the highest number of attendees
select event_name 
from events 
where event_id = (
    select event_id 
    from tickets 
    group by event_id 
    order by count(attendee_id) desc 
    limit 1
);

-- compute the average ticket price across all events
select avg(ticket_price) as average_price 
from events;

-- ---------------------------------------------------------
-- TASK 6: Primary & Foreign Key Relationships (Constraints)
-- ---------------------------------------------------------
-- ensure that attendees cannot book the same event multiple times
alter table tickets 
add unique index unique_booking (event_id, attendee_id);

-- link payments to tickes, ensuring a valid foreign key relationship
alter table payments 
add constraint fk_ticket_payment 
foreign key (ticket_id) references tickets(ticket_id);

-- ---------------------------------------------------------
-- TASK 7: Implement Joins (INNER, LEFT, RIGHT, UNION)
-- ---------------------------------------------------------
-- retrieve event details along with venue information using inner join 
select e.event_name, e.event_date, v.venue_name, v.location
from events e
inner join venues v on e.venue_id = v.venue_id;

-- get a list of attendees who booked a ticket but did not complete payment using left join 
select a.name, t.ticket_id, p.payment_status
from attendees a
join tickets t on a.attendee_id = t.attendee_id
left join payments p on t.ticket_id = p.ticket_id
where p.payment_status is null or p.payment_status != 'success';

-- identify events without any attendees using right join 
select e.event_name
from tickets t
right join events e on t.event_id = e.event_id
where t.ticket_id is null;

-- show attendees who have not booked any ticket 
select a.name
from attendees a
left join tickets t on a.attendee_id = t.attendee_id
where t.ticket_id is null
union
select a.name
from attendees a
right join tickets t on a.attendee_id = t.attendee_id
where a.attendee_id is null;

-- ---------------------------------------------------------
-- TASK 8: Use Subqueries (Nested Queries)
-- ---------------------------------------------------------
-- find events that generated revenue above the average ticket sales
select event_name 
from events 
where event_id in (
    select event_id 
    from tickets t 
    join payments p on t.ticket_id = p.ticket_id 
    where p.payment_status = 'success'
    group by event_id 
    having sum(p.amount_paid) > (select avg(amount_paid) from payments)
);

-- identify attendees who have booked tickets for multiple events
select name 
from attendees 
where attendee_id in (
    select attendee_id 
    from tickets 
    group by attendee_id 
    having count(distinct event_id) > 1
);

-- retrieve organizers who have managed more than 3 events
select organizer_name 
from organizers 
where organizer_id in (
    select organizer_id 
    from events 
    group by organizer_id 
    having count(event_id) > 3
); 

-- ---------------------------------------------------------
-- TASK 9: Date & Time Functions (Trend Analysis)
-- ---------------------------------------------------------
-- extract the month from event_date to analyze event trends
select event_name, monthname(event_date) as event_month 
from events;

-- calculate the number of days remaining for an upcoming event
select event_name, event_date, datediff(event_date, curdate()) as days_remaining 
from events 
where event_date >= curdate();

-- format payment_date as yyyy-mm-dd hh:mm:ss
select payment_id, date_format(payment_date, '%y-%m-%d %h:%i:%s') as formatted_date 
from payments;

-- ---------------------------------------------------------
-- TASK 10: String Manipulation Functions (Data Cleaning)
-- ---------------------------------------------------------
-- convert all organizer names to uppercase
select upper(organizer_name) as organizer_name_upper 
from organizers;

-- remove extra spaces from attendee names using trim()
select trim(name) as cleaned_name 
from attendees;

-- replace null email fields with "not provided"
select name, coalesce(email, 'not provided') as email_status 
from attendees;

-- ---------------------------------------------------------
-- TASK 11: Window Functions (Advanced Ranking & Totals)
-- ---------------------------------------------------------
-- rank events based on total revenue earned
select e.event_name, sum(p.amount_paid) as total_revenue,
rank() over (order by sum(p.amount_paid) desc) as revenue_rank
from events e
join tickets t on e.event_id = t.event_id
join payments p on t.ticket_id = p.ticket_id
where p.payment_status = 'success'
group by e.event_id, e.event_name;

-- display the cumulative sum of ticket sales
select payment_date, amount_paid,
sum(amount_paid) over (order by payment_date) as cumulative_revenue
from payments
where payment_status = 'success';

-- show the running total of attendees registered per event
select event_id, booking_date,
count(attendee_id) over (partition by event_id order by booking_date) as running_attendee_count
from tickets
where status = 'confirmed';

-- ---------------------------------------------------------
-- TASK 12: SQL CASE Expressions (Logical Classification)
-- ---------------------------------------------------------
-- categorize events based on ticket sales
select event_name, available_seats, total_seats,
case 
    when available_seats < (0.2 * total_seats) then 'high demand'
    when available_seats between (0.2 * total_seats) and (0.5 * total_seats) then 'moderate demand'
    else 'low demand'
end as demand_status
from events;

-- assign payment statuses based on payment_status column
select payment_id, amount_paid,
case 
    when payment_status = 'success' then 'successful'
    when payment_status = 'failed' then 'failed'
    else 'pending'
end as detailed_status
from payments;