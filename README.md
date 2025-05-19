# Week-8-assignment-on-PLP-Database-Management
Building a Complete Database Management System
PROJECT TITLE- Employee Performance & Attendance Tracking System
project Description:
The Employee Performance & Attendance Tracking System is a fully optimized relational database designed to track employee attendance, performance evaluations, project assignments, and promotions in an organization.

Key Features:
Employee Management: Stores complete employee records, including department and joining date.
Attendance Tracking: Logs employee check-in/check-out times for productivity analysis.
Project Assignment: Allows managers to assign employees to different projects.
Performance Evaluation: Tracks periodic employee performance reviews, enabling structured feedback.
Automated Promotions: Uses SQL triggers to promote employees based on performance scores.
Data Integrity & Relationships: Ensures structured storage and logical connections between employees, attendance, projects, and promotions using optimized indexing and cascading deletions.

How It Works:
Employees register in the database.
Attendance records are maintained daily for each employee.
Employees are assigned projects based on their skills and availability.
Performance evaluations are conducted, tracking employees' strengths and areas for improvement.
If an employee scores high on evaluations, the system automatically promotes them using SQL triggers.
Reports can be generated to analyze workforce productivity, attendance trends, and promotion history.

Ideal Use Case:
This system is perfect for corporate organizations, HR departments, and business management applications, ensuring efficient workforce tracking, structured career progression, and data-driven decision-making.



How to Run/Set Up the Project (Import SQL Database)

To run the "Employee Performance & Attendance Tracking System Using MySQL", please follow these steps:  

Step 1: Install MySQL Database Server
Ensure that you have MySQL installed on your system. You can download it from:  
🔗 [MySQL Community Server](https://dev.mysql.com/downloads/mysql/)  

Step 2: Open MySQL Workbench or MySQL Command Line
Use MySQL Workbench (GUI) or MySQL CLI to execute SQL queries.  

Step 3: Create and Select the Database
CREATE DATABASE EmployeeDB;
USE EmployeeDB;
This creates the database and selects it for further operations.  

Step 4: Import the SQL File into MySQL Workbench
Open MySQL Workbench  
Go to File > Open SQL Script  
Select EmployeeDB.sql  
Click Execute (RUN Script) to create tables and insert sample data  

Alternatively, you can use MySQL Command Line:  
mysql -u root -p EmployeeDB < EmployeeDB.sql
This imports the SQL file directly into the MySQL server.  

Step 5: Verify Database Tables
Run the following query to check if all tables were created successfully:
SHOW TABLES;
You should see: Employees, Attendance, Projects, EmployeeProjects, PerformanceReviews, and Promotions.

Step 6: Run Sample Queries to Test the System
- To view all employees:
SELECT * FROM Employees;
- To see attendance records:
SELECT * FROM Attendance;
- To check employees who have received promotions:
SELECT FullName, NewRole, PromotionDate FROM Employees JOIN Promotions ON Employees.EmployeeID = Promotions.EmployeeID;

Step 7: Test the Automatic Promotion Trigger
If you add a high performance score, the trigger should automatically insert a promotion:
INSERT INTO PerformanceReviews (EmployeeID, ReviewDate, PerformanceScore, Comments)
VALUES (3, CURDATE(), 9, 'Exceptional leadership and coding skills!');
Now check the promotions table:
SELECT * FROM Promotions;

THIS IS THE ERM FILE
![ERD Diagram](https://github.com/Unbornmoral/Week-8-assignment-on-PLP-Database-Management/blob/main/Untitled.png)
