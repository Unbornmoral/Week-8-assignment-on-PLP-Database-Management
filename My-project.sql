/*
-- Employee Performance & Attendance Tracking System
-- Optimized with indexing, reporting queries, and triggers
*/

-- Create Database --
CREATE DATABASE EmployeeDB;
USE EmployeeDB;

-- Employees Table --
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
    FullName VARCHAR(255) NOT NULL,
    Email VARCHAR(255) UNIQUE NOT NULL,
    Department VARCHAR(100) NOT NULL,
    JoinDate DATE NOT NULL
);

-- Attendance Table (WITH CASCADE DELETE) --
CREATE TABLE Attendance (
    AttendanceID INT PRIMARY KEY AUTO_INCREMENT,
    EmployeeID INT,
    CheckInTime TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CheckOutTime TIMESTAMP,
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID) ON DELETE CASCADE
);

-- Projects Table --
CREATE TABLE Projects (
    ProjectID INT PRIMARY KEY AUTO_INCREMENT,
    ProjectName VARCHAR(255) NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NOT NULL
);

-- EmployeeProjects Table (Many-to-Many Relationship WITH CASCADE DELETE) --
CREATE TABLE EmployeeProjects (
    EmployeeProjectID INT PRIMARY KEY AUTO_INCREMENT,
    EmployeeID INT,
    ProjectID INT,
    AssignedDate DATE NOT NULL,
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID) ON DELETE CASCADE,
    FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID) ON DELETE CASCADE
);

-- PerformanceReviews Table (WITH CASCADE DELETE) --
CREATE TABLE PerformanceReviews (
    ReviewID INT PRIMARY KEY AUTO_INCREMENT,
    EmployeeID INT,
    ReviewDate DATE NOT NULL,
    PerformanceScore INT CHECK (PerformanceScore BETWEEN 1 AND 10),
    Comments TEXT,
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID) ON DELETE CASCADE
);

-- Promotions Table (WITH CASCADE DELETE) --
CREATE TABLE Promotions (
    PromotionID INT PRIMARY KEY AUTO_INCREMENT,
    EmployeeID INT,
    PromotionDate DATE NOT NULL,
    NewRole VARCHAR(255) NOT NULL,
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID) ON DELETE CASCADE
);

-- Indexing for Performance Optimization --
CREATE INDEX idx_employee_email ON Employees(Email);
CREATE INDEX idx_attendance_empid ON Attendance(EmployeeID);
CREATE INDEX idx_projects_dates ON Projects(StartDate, EndDate);

-- Insert Sample Employees (Using Nigerian Names) --
INSERT INTO Employees (FullName, Email, Department, JoinDate)
VALUES 
    ('Chinonso Okeke', 'chinonso.okeke@example.com', 'Software Engineering', '2023-02-15'),
    ('Aisha Bello', 'aisha.bello@example.com', 'Human Resources', '2022-07-10'),
    ('Emeka Nwosu', 'emeka.nwosu@example.com', 'Finance', '2023-01-20'),
    ('Fatima Abubakar', 'fatima.abubakar@example.com', 'Marketing', '2022-09-05'),
    ('Tunde Adeyemi', 'tunde.adeyemi@example.com', 'Product Management', '2021-12-10'),
    ('Ngozi Eze', 'ngozi.eze@example.com', 'Data Science', '2022-03-25'),
    ('Babatunde Owolabi', 'babatunde.owolabi@example.com', 'Cybersecurity', '2022-06-30'),
    ('Kelechi Onuoha', 'kelechi.onuoha@example.com', 'Legal', '2023-04-18'),
    ('Hadiza Yusuf', 'hadiza.yusuf@example.com', 'Operations', '2021-11-22'),
    ('Osas Okonkwo', 'osas.okonkwo@example.com', 'Customer Support', '2023-07-14');

-- Insert Sample Attendance Records --
INSERT INTO Attendance (EmployeeID, CheckInTime, CheckOutTime)
VALUES 
    (1, '2025-05-19 08:30:00', '2025-05-19 17:30:00'),
    (2, '2025-05-19 08:45:00', '2025-05-19 16:45:00');

-- Insert Sample Projects --
INSERT INTO Projects (ProjectName, StartDate, EndDate)
VALUES 
    ('E-Commerce Platform', '2025-04-01', '2025-06-30'),
    ('Employee Welfare Program', '2025-05-01', '2025-07-15');

-- Assign Employees to Projects --
INSERT INTO EmployeeProjects (EmployeeID, ProjectID, AssignedDate)
VALUES 
    (1, 1, '2025-04-05'),
    (2, 2, '2025-05-03');

-- Insert Performance Reviews --
INSERT INTO PerformanceReviews (EmployeeID, ReviewDate, PerformanceScore, Comments)
VALUES 
    (1, '2025-05-10', 9, 'Outstanding problem-solving skills!'),
    (2, '2025-05-12', 7, 'Shows good leadership potential.');

-- Insert Promotions --
INSERT INTO Promotions (EmployeeID, PromotionDate, NewRole)
VALUES 
    (1, '2025-06-01', 'Senior Software Engineer');

-- Update Employee Department --
UPDATE Employees
SET Department = 'Product Management'
WHERE EmployeeID = 1;

-- Update Performance Review Score --
UPDATE PerformanceReviews
SET PerformanceScore = 8, Comments = 'Improved leadership skills'
WHERE EmployeeID = 2 AND ReviewDate = '2025-05-12';

-- Delete Employee (Works with ON DELETE CASCADE) --
DELETE FROM Employees WHERE EmployeeID = 2;

-- Delete Old Project --
DELETE FROM Projects WHERE ProjectID = 2;

-- Reporting Queries --
SELECT * FROM Employees ORDER BY Department;
SELECT EmployeeID, COUNT(*) AS DaysPresent FROM Attendance GROUP BY EmployeeID;
SELECT Employees.FullName, Promotions.NewRole, Promotions.PromotionDate 
FROM Promotions 
JOIN Employees ON Promotions.EmployeeID = Employees.EmployeeID;

-- Triggers for Automation --

DELIMITER $$
CREATE TRIGGER PromoteHighPerformers
AFTER INSERT ON PerformanceReviews
FOR EACH ROW
BEGIN
    IF NEW.PerformanceScore >= 9 THEN
        INSERT INTO Promotions (EmployeeID, PromotionDate, NewRole)
        VALUES (NEW.EmployeeID, CURDATE(), 'Senior Level');
    END IF;
END $$
DELIMITER ;