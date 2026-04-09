create database FinalProject;
use FinalProject;

create table Students(
	StuId int primary key,
    FirstName varchar(100),
    LastName varchar(100),
    Email varchar(50),
    Birthdate date,
    EnrollmentDate date
);

create table Departments(
	DepartmentID int primary key,
    DepartmentName varchar(100)
);

create table Courses(
	CourseID int primary key,
    CourseName varchar(100),
    DepartmentID int,
    Credits decimal (2,1),
	foreign key (DepartmentID) references Departments(DepartmentID)
);

create table Instructors(
	InstructorID int primary key,
    FirstName varchar(100),
    LastName varchar(100),
    Email varchar(100),
    DepartmentID int,
    foreign key (DepartmentID) references Departments(DepartmentID)
);

create table Enrollments(
	EnrollmentID int,
    StuID int,
    CourseID int,
    EnrollmentDate date,
	foreign key (StuID) references Students(StuID),
    foreign key (CourseID) references Courses(CourseID)
);


-- 1. Perform CRUD Operations on all tables.
INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
(1, 'Computer Science'),
(2, 'Mathematics'),
(3, 'Physics'),
(4, 'Mechanical Engineering'),
(5, 'Civil Engineering'),
(6, 'Electrical Engineering'),
(7, 'Information Technology'),
(8, 'Chemical Engineering'),
(9, 'Humanities'),
(10, 'Business Administration');

INSERT INTO Students (StuId, FirstName, LastName, Email, Birthdate, EnrollmentDate) VALUES
(101, 'Aarav', 'Patel', 'aarav.p@example.com', '2004-05-15', '2021-08-20'),
(102, 'Dhara', 'Shah', 'dhara.s@example.com', '2003-11-22', '2020-07-15'),
(103, 'Kavan', 'Mehta', 'kavan.m@example.com', '2005-01-10', '2023-09-01'),
(104, 'Ishani', 'Gajjar', 'ishani.g@example.com', '2002-03-30', '2019-06-10'),
(105, 'Meet', 'Prajapati', 'meet.p@example.com', '2004-12-12', '2022-08-15'),
(106, 'Riya', 'Chauhan', 'riya.c@example.com', '2005-06-25', '2024-01-10'),
(107, 'Harsh', 'Vaghela', 'harsh.v@example.com', '2003-08-05', '2021-07-20'),
(108, 'Nidhi', 'Joshi', 'nidhi.j@example.com', '2004-02-14', '2022-09-15'),
(109, 'Parth', 'Zala', 'parth.z@example.com', '2002-10-10', '2019-08-05'),
(110, 'Bansi', 'Thakar', 'bansi.t@example.com', '2005-04-05', '2023-12-01');

INSERT INTO Courses (CourseID, CourseName, DepartmentID, Credits) VALUES
(201, 'Introduction to SQL', 1, 4.0),
(202, 'Data Structures', 1, 4.0),
(203, 'Calculus I', 2, 3.0),
(204, 'Quantum Physics', 3, 3.5),
(205, 'Linear Algebra', 2, 3.0),
(206, 'Python Programming', 7, 4.0),
(207, 'Thermodynamics', 4, 3.0),
(208, 'Discrete Math', 2, 3.0),
(209, 'Machine Learning', 1, 4.0),
(210, 'Web Development', 7, 3.5);

INSERT INTO Instructors (InstructorID, FirstName, LastName, Email, DepartmentID) VALUES
(301, 'Rajesh', 'Vyas', 'rajesh.v@university.com', 1),
(302, 'Snehal', 'Patel', 'snehal.p@university.com', 2),
(303, 'Amit', 'Trivedi', 'amit.t@university.com', 1),
(304, 'Bhavna', 'Desai', 'bhavna.d@university.com', 3),
(305, 'Kishor', 'Parmar', 'kishor.p@university.com', 4),
(306, 'Pooja', 'Rathod', 'pooja.r@university.com', 2),
(307, 'Vijay', 'Mistry', 'vijay.m@university.com', 7),
(308, 'Deepa', 'Pandya', 'deepa.p@university.com', 2),
(309, 'Sanjay', 'Jadeja', 'sanjay.j@university.com', 5),
(310, 'Megha', 'Bhatt', 'megha.b@university.com', 1);

INSERT INTO Enrollments (EnrollmentID, StuID, CourseID, EnrollmentDate) VALUES
(1, 101, 201, '2021-08-25'),
(2, 101, 202, '2021-08-25'), 
(3, 102, 201, '2020-07-20'), 
(4, 103, 202, '2023-09-05'), 
(5, 105, 201, '2022-08-20'),
(6, 105, 202, '2022-08-20'),
(7, 107, 203, '2021-07-25'),
(8, 108, 201, '2022-09-20'),
(9, 109, 201, '2019-08-10'),
(10, 110, 208, '2023-12-05');

UPDATE Students SET LastName = 'Vora' WHERE StuId = 101;
SELECT * FROM Students WHERE Birthdate LIKE '2004%';

UPDATE Departments SET DepartmentName = 'IT & Analytics' WHERE DepartmentID = 7;
DELETE FROM Departments WHERE DepartmentID = 8;

SELECT * FROM Courses WHERE Credits = 4.0;
UPDATE Courses SET Credits = 4.0 WHERE CourseID = 210;

SELECT * FROM Instructors WHERE LastName = 'Patel';
UPDATE Instructors SET DepartmentID = 7 WHERE InstructorID = 301;
DELETE FROM Instructors WHERE InstructorID = 310;

SELECT EnrollmentID, StuID, CourseID FROM Enrollments WHERE EnrollmentID = 5;
UPDATE Departments SET DepartmentName = 'Robotics & Mechanical' WHERE DepartmentID = 4;

-- 2. Retrieve students who enrolled after 2022.
select * from Students
where year(EnrollmentDate) > 2022;

-- 3. Retrieve courses offered by the Mathematics department with a limit of 5 courses.
select c.CourseID, c.COurseName, d.DepartmentName 
from Courses c
inner join Departments d
on c.DepartmentID = d.DepartmentID
where d.DepartmentName = 'Mathematics'
limit 5;

-- 4. Get the number of students enrolled in each course, filtering for courses with more than 5 students.
select CourseID, count(StuID) as TotalStudents
from Enrollments
group by CourseID
having count(StuID) > 5;

-- 5. Find students who are enrolled in both Introduction to SQL and Data Structures.
select FirstName, LastName from Students
where StuId in (
				select StuID from Enrollments 
                where CourseID in (
									select CourseID from Courses
                                    where CourseName = 'Introduction to SQL' 
									and CourseName = 'Data Structures'
				)
);

-- 6. Find students who are either enrolled in Introduction to SQL or Data Structures.
select FirstName, LastName from Students
where StuId in (
				select StuID from Enrollments 
                where CourseID in (
									select CourseID from Courses
                                    where CourseName = 'Introduction to SQL' 
									or CourseName = 'Data Structures'
				)
);

-- 7. Calculate the average number of credits for all courses.
select avg(Credits) as AverageCredits 
from Courses;

-- 8. Find the maximum salary of instructors in the Computer Science department.
alter table Instructors add Salary decimal(10,2);

update Instructors set Salary = 75000 where InstructorID = 301;
update Instructors set Salary = 62000 where InstructorID = 302;
update Instructors set Salary = 68000 where InstructorID = 303;
update Instructors set Salary = 71000 where InstructorID = 304;
update Instructors set Salary = 55000 where InstructorID = 305;
update Instructors set Salary = 59000 where InstructorID = 306;
update Instructors set Salary = 64000 where InstructorID = 307;
update Instructors set Salary = 60000 where InstructorID = 308;
update Instructors set Salary = 52000 where InstructorID = 309;
update Instructors set Salary = 72000 where InstructorID = 310;

select max(Salary) as MaxSalary
from Instructors
where DepartmentID = (
    select DepartmentID from Departments 
    where DepartmentName = 'Computer Science'
);

-- 9. Count the number of students enrolled in each department.
select DepartmentName, 
    (select count(distinct StuID) 
     from Enrollments 
     where CourseID in (
         select CourseID from Courses 
         where DepartmentID = d.DepartmentID
     )
    ) as TotalStudents
from Departments d;

-- 10. INNER JOIN: Retrieve students and their corresponding courses.
select s.FirstName, s.LastName, c.CourseName
from Students s, Enrollments e, Courses c
where s.StuId = e.StuID 
  and e.CourseID = c.CourseID;

-- 11. LEFT JOIN: Retrieve all students and their corresponding courses, if any.
select FirstName, LastName, 
    (select CourseName from Courses 
     where CourseID = (
         select CourseID from Enrollments 
         where StuID = s.StuId limit 1
     )
    ) as CourseName
from Students s;

-- 12. Subquery: Find students enrolled in courses that have more than 10 students.
select FirstName, LastName, Email 
from Students 
where StuId in (
    select StuID from Enrollments 
    where CourseID in (
        select CourseID from Enrollments 
        group by CourseID 
        having count(StuID) > 10
    )
);

-- 13. Extract the year from the EnrollmentDate of students.
select FirstName, LastName, year(EnrollmentDate) as EnrollmentYear 
from Students;

-- 14. Concatenate the instructor's first and last name.
select concat(FirstName, ' ', LastName) as FullName 
from Instructors;

-- 15. Calculate the running total of students enrolled in courses.
select InstructorID, FirstName, Salary,
       sum(Salary) over (order by InstructorID) as RunningTotalSalary
from Instructors;

-- 16. Label students as 'Senior' or 'Junior' based on their year of enrollment.
--     (If the enrollment date is more than 4 years from the current date, put the label 'Senior' otherwise 'Junior')
select FirstName, LastName, EnrollmentDate,
    case 
        when datediff(curdate(), EnrollmentDate) > 1460 then 'Senior'
        else 'Junior'
    end as StudentLevel
from Students;