-- ============================================
-- RACEDAY DATABASE 
-- SQL Server Management Studio (SSMS)
-- ============================================

-- Drop database if exists
USE master;
GO

IF EXISTS (SELECT name FROM sys.databases WHERE name = N'RaceDayDB')
BEGIN
    ALTER DATABASE RaceDayDB SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE RaceDayDB;
END
GO

-- Create database
CREATE DATABASE RaceDayDB;
GO

USE RaceDayDB;
GO

-- ============================================
-- 1. USERS TABLE
-- ============================================
CREATE TABLE Users (
    UserId INT IDENTITY(1,1) PRIMARY KEY,
    Email NVARCHAR(255) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(255) NOT NULL,
    FirstName NVARCHAR(100) NOT NULL,
    LastName NVARCHAR(100) NOT NULL,
    Role NVARCHAR(20) NOT NULL CHECK (Role IN ('Organiser', 'Participant')),
    DateRegistered DATETIME2 DEFAULT GETUTCDATE(),
    IsActive BIT DEFAULT 1,
    ProfileImageUrl NVARCHAR(500) NULL
);
GO

-- ============================================
-- 2. ORGANISERS TABLE (NO CASCADE)
-- ============================================
CREATE TABLE Organisers (
    OrganiserId INT IDENTITY(1,1) PRIMARY KEY,
    UserId INT NOT NULL,
    CompanyName NVARCHAR(200) NULL,
    ContactNumber NVARCHAR(20) NOT NULL,
    IsVerified BIT DEFAULT 0,
    CreatedAt DATETIME2 DEFAULT GETUTCDATE(),
    UpdatedAt DATETIME2 DEFAULT GETUTCDATE(),
    CONSTRAINT FK_Organisers_Users FOREIGN KEY (UserId) 
        REFERENCES Users(UserId) ON DELETE NO ACTION
);
GO

-- ============================================
-- 3. PARTICIPANTS TABLE (NO CASCADE)
-- ============================================
CREATE TABLE Participants (
    ParticipantId INT IDENTITY(1,1) PRIMARY KEY,
    UserId INT NOT NULL,
    DateOfBirth DATE NOT NULL,
    Gender NVARCHAR(10) NULL CHECK (Gender IN ('Male', 'Female', 'Other')),
    EmergencyContact NVARCHAR(100) NULL,
    MedicalInfo NVARCHAR(500) NULL,
    EmergencyPhone NVARCHAR(20) NULL,
    CreatedAt DATETIME2 DEFAULT GETUTCDATE(),
    UpdatedAt DATETIME2 DEFAULT GETUTCDATE(),
    CONSTRAINT FK_Participants_Users FOREIGN KEY (UserId) 
        REFERENCES Users(UserId) ON DELETE NO ACTION
);
GO

-- ============================================
-- 4. EVENTS TABLE
-- ============================================
CREATE TABLE Events (
    EventId INT IDENTITY(1,1) PRIMARY KEY,
    OrganiserId INT NOT NULL,
    Name NVARCHAR(200) NOT NULL,
    Description NVARCHAR(1000) NULL,
    EventDate DATE NOT NULL,
    StartTime TIME NOT NULL,
    EndTime TIME NULL,
    Location NVARCHAR(255) NOT NULL,
    RouteMap NVARCHAR(500) NULL,
    EventType NVARCHAR(50) NOT NULL CHECK (EventType IN ('Running', 'Walking', 'Cycling')),
    Status NVARCHAR(20) DEFAULT 'Draft' CHECK (Status IN ('Draft', 'Published', 'Cancelled', 'Completed')),
    MaxParticipants INT NOT NULL CHECK (MaxParticipants > 0),
    ImageUrl NVARCHAR(500) NULL,
    CreatedAt DATETIME2 DEFAULT GETUTCDATE(),
    UpdatedAt DATETIME2 DEFAULT GETUTCDATE(),
    CONSTRAINT FK_Events_Organisers FOREIGN KEY (OrganiserId) 
        REFERENCES Organisers(OrganiserId) ON DELETE NO ACTION
);
GO

-- ============================================
-- 5. CATEGORIES TABLE (NO CASCADE)
-- ============================================
CREATE TABLE Categories (
    CategoryId INT IDENTITY(1,1) PRIMARY KEY,
    EventId INT NOT NULL,
    CategoryName NVARCHAR(100) NOT NULL,
    Distance DECIMAL(5,2) NOT NULL,
    EntryFee DECIMAL(10,2) NOT NULL,
    CategoryStartTime TIME NULL,
    MaxParticipants INT NOT NULL CHECK (MaxParticipants > 0),
    CurrentCount INT DEFAULT 0,
    CreatedAt DATETIME2 DEFAULT GETUTCDATE(),
    UpdatedAt DATETIME2 DEFAULT GETUTCDATE(),
    CONSTRAINT FK_Categories_Events FOREIGN KEY (EventId) 
        REFERENCES Events(EventId) ON DELETE NO ACTION
);
GO

-- ============================================
-- 6. ENROLMENTS TABLE (NO CASCADE ON ALL)
-- ============================================
CREATE TABLE Enrolments (
    EnrolmentId INT IDENTITY(1,1) PRIMARY KEY,
    EventId INT NOT NULL,
    ParticipantId INT NOT NULL,
    CategoryId INT NOT NULL,
    EnrolmentDate DATETIME2 DEFAULT GETUTCDATE(),
    Status NVARCHAR(20) DEFAULT 'Pending' CHECK (Status IN ('Pending', 'Confirmed', 'Cancelled', 'Completed')),
    PaymentStatus NVARCHAR(20) DEFAULT 'Unpaid' CHECK (PaymentStatus IN ('Unpaid', 'Paid', 'Refunded')),
    BibNumber INT NULL UNIQUE,
    CreatedAt DATETIME2 DEFAULT GETUTCDATE(),
    UpdatedAt DATETIME2 DEFAULT GETUTCDATE(),
    CONSTRAINT FK_Enrolments_Events FOREIGN KEY (EventId) 
        REFERENCES Events(EventId) ON DELETE NO ACTION,
    CONSTRAINT FK_Enrolments_Participants FOREIGN KEY (ParticipantId) 
        REFERENCES Participants(ParticipantId) ON DELETE NO ACTION,
    CONSTRAINT FK_Enrolments_Categories FOREIGN KEY (CategoryId) 
        REFERENCES Categories(CategoryId) ON DELETE NO ACTION,
    CONSTRAINT UQ_Enrolment_Unique UNIQUE (EventId, ParticipantId, CategoryId)
);
GO

-- ============================================
-- 7. RESULTS TABLE
-- ============================================
CREATE TABLE Results (
    ResultId INT IDENTITY(1,1) PRIMARY KEY,
    EnrolmentId INT NOT NULL,
    FinishTime TIME NULL,
    Position INT NULL,
    OverallPosition INT NULL,
    AgeCategoryPosition INT NULL,
    Status NVARCHAR(20) DEFAULT 'Pending' CHECK (Status IN ('Pending', 'Confirmed', 'Disqualified')),
    CreatedAt DATETIME2 DEFAULT GETUTCDATE(),
    UpdatedAt DATETIME2 DEFAULT GETUTCDATE(),
    CONSTRAINT FK_Results_Enrolments FOREIGN KEY (EnrolmentId) 
        REFERENCES Enrolments(EnrolmentId) ON DELETE NO ACTION
);
GO

-- ============================================
-- 8. WEATHER TABLE
-- ============================================
CREATE TABLE Weather (
    WeatherId INT IDENTITY(1,1) PRIMARY KEY,
    EventId INT NOT NULL,
    ForecastDate DATE NOT NULL,
    Temperature DECIMAL(4,1) NULL,
    Conditions NVARCHAR(100) NULL,
    WindSpeed DECIMAL(5,2) NULL,
    Humidity DECIMAL(3,1) NULL,
    Precipitation DECIMAL(4,1) NULL,
    CreatedAt DATETIME2 DEFAULT GETUTCDATE(),
    UpdatedAt DATETIME2 DEFAULT GETUTCDATE(),
    CONSTRAINT FK_Weather_Events FOREIGN KEY (EventId) 
        REFERENCES Events(EventId) ON DELETE NO ACTION
);
GO

-- ============================================
-- CREATE INDEXES
-- ============================================
CREATE INDEX IX_Users_Email ON Users(Email);
CREATE INDEX IX_Users_Role ON Users(Role);
CREATE INDEX IX_Events_OrganiserId ON Events(OrganiserId);
CREATE INDEX IX_Events_EventDate ON Events(EventDate);
CREATE INDEX IX_Categories_EventId ON Categories(EventId);
CREATE INDEX IX_Enrolments_EventId ON Enrolments(EventId);
CREATE INDEX IX_Enrolments_ParticipantId ON Enrolments(ParticipantId);
CREATE INDEX IX_Enrolments_CategoryId ON Enrolments(CategoryId);
CREATE INDEX IX_Results_EnrolmentId ON Results(EnrolmentId);
CREATE INDEX IX_Weather_EventId ON Weather(EventId);
GO

-- ============================================
-- INSERT DATA - ALL TABLES
-- ============================================

-- 1. Insert Users (4 users)
INSERT INTO Users (Email, PasswordHash, FirstName, LastName, Role) VALUES
('john.organiser@raceday.co.za', 'hashed_password_1', 'John', 'Smith', 'Organiser'),
('sarah.organiser@raceday.co.za', 'hashed_password_2', 'Sarah', 'Johnson', 'Organiser'),
('thabo.participant@raceday.co.za', 'hashed_password_3', 'Thabo', 'Mokoena', 'Participant'),
('linda.participant@raceday.co.za', 'hashed_password_4', 'Linda', 'van der Merwe', 'Participant');
GO

-- 2. Insert Organisers (2 organisers)
INSERT INTO Organisers (UserId, CompanyName, ContactNumber, IsVerified) VALUES
(1, 'Smith Event Management', '+27761234567', 1),
(2, 'Cape Town Race Promotions', '+27769876543', 1);
GO

-- 3. Insert Participants (2 participants)
INSERT INTO Participants (UserId, DateOfBirth, Gender, EmergencyContact, MedicalInfo, EmergencyPhone) VALUES
(3, '1990-05-15', 'Male', 'Maria Mokoena', 'No known allergies', '+27765554433'),
(4, '1985-08-22', 'Female', 'Pieter van der Merwe', 'Mild asthma', '+27764443322');
GO

-- 4. Insert Events (3 events)
INSERT INTO Events (OrganiserId, Name, Description, EventDate, StartTime, Location, EventType, Status, MaxParticipants) VALUES
(1, 'Soweto Marathon 2025', 'Annual Soweto Marathon through the streets of Soweto', '2025-09-15', '06:00:00', 'Orlando Stadium, Soweto', 'Running', 'Published', 5000),
(2, 'Cape Town Cycle Tour 2025', 'World famous Cape Town Cycle Tour', '2025-03-09', '06:30:00', 'Cape Town Stadium, Cape Town', 'Cycling', 'Published', 35000),
(2, 'Two Oceans Marathon 2025', 'The ultimate ultra-marathon with stunning coastal views', '2025-04-12', '05:30:00', 'Newlands Stadium, Cape Town', 'Running', 'Published', 10000);
GO

-- 5. Insert Categories (8 categories)
INSERT INTO Categories (EventId, CategoryName, Distance, EntryFee, CategoryStartTime, MaxParticipants, CurrentCount) VALUES
(1, 'Full Marathon', 42.20, 450.00, NULL, 2000, 0),
(1, 'Half Marathon', 21.10, 300.00, NULL, 2000, 0),
(1, '10km Run', 10.00, 150.00, NULL, 1000, 0),
(2, 'Full Tour', 109.00, 500.00, NULL, 25000, 0),
(2, 'Half Tour', 60.00, 350.00, NULL, 10000, 0),
(3, 'Ultra Marathon', 56.00, 550.00, NULL, 4000, 0),
(3, 'Half Marathon', 21.10, 350.00, NULL, 4000, 0),
(3, '12km Trail', 12.00, 200.00, NULL, 2000, 0);
GO

-- 6. Insert Enrolments (4 enrolments) ✅
INSERT INTO Enrolments (EventId, ParticipantId, CategoryId, Status, PaymentStatus, BibNumber) VALUES
(1, 1, 1, 'Confirmed', 'Paid', 1001),
(1, 2, 2, 'Confirmed', 'Paid', 1002),
(2, 1, 4, 'Confirmed', 'Paid', 2001),
(3, 2, 7, 'Pending', 'Unpaid', NULL);
GO

-- 7. Insert Results (3 results) ✅
INSERT INTO Results (EnrolmentId, FinishTime, Position, OverallPosition, AgeCategoryPosition, Status) VALUES
(1, '03:45:22', 345, 345, 78, 'Confirmed'),
(2, '01:58:15', 120, 120, 25, 'Confirmed'),
(3, '04:12:30', 234, 234, 56, 'Confirmed');
GO

-- 8. Insert Weather (5 weather records) ✅
INSERT INTO Weather (EventId, ForecastDate, Temperature, Conditions, WindSpeed, Humidity, Precipitation) VALUES
(1, '2025-09-15', 22.5, 'Sunny, light breeze', 15.0, 65.0, 10.0),
(2, '2025-03-09', 25.0, 'Clear skies', 12.0, 70.0, 5.0),
(3, '2025-04-12', 18.0, 'Partly cloudy', 20.0, 75.0, 20.0),
(1, '2025-09-14', 20.0, 'Sunny', 10.0, 60.0, 0.0),
(2, '2025-03-08', 24.0, 'Clear', 8.0, 65.0, 0.0);
GO

-- 9. Update Category Counts ✅
UPDATE Categories SET CurrentCount = 
    (SELECT COUNT(*) FROM Enrolments 
     WHERE Enrolments.CategoryId = Categories.CategoryId 
     AND Enrolments.Status = 'Confirmed');
GO

-- ============================================
-- VIEWS
-- ============================================

-- View: Event details with organiser info
CREATE VIEW vw_EventDetails AS
SELECT 
    e.EventId,
    e.Name AS EventName,
    e.Description,
    e.EventDate,
    e.Location,
    e.EventType,
    e.Status,
    o.OrganiserId,
    u.FirstName + ' ' + u.LastName AS OrganiserName,
    o.CompanyName,
    (SELECT COUNT(*) FROM Categories c WHERE c.EventId = e.EventId) AS CategoryCount,
    (SELECT COUNT(*) FROM Enrolments en WHERE en.EventId = e.EventId AND en.Status = 'Confirmed') AS TotalEnrolments
FROM Events e
INNER JOIN Organisers o ON e.OrganiserId = o.OrganiserId
INNER JOIN Users u ON o.UserId = u.UserId;
GO

-- View: Participant enrolment history
CREATE VIEW vw_ParticipantEnrolments AS
SELECT 
    p.ParticipantId,
    u.FirstName + ' ' + u.LastName AS ParticipantName,
    e.EventId,
    e.Name AS EventName,
    e.EventDate,
    e.Location,
    c.CategoryName,
    c.Distance,
    en.EnrolmentId,
    en.Status AS EnrolmentStatus,
    en.PaymentStatus,
    en.BibNumber,
    en.EnrolmentDate,
    r.FinishTime,
    r.Position,
    r.OverallPosition
FROM Participants p
INNER JOIN Users u ON p.UserId = u.UserId
INNER JOIN Enrolments en ON p.ParticipantId = en.ParticipantId
INNER JOIN Events e ON en.EventId = e.EventId
INNER JOIN Categories c ON en.CategoryId = c.CategoryId
LEFT JOIN Results r ON en.EnrolmentId = r.EnrolmentId;
GO

-- ============================================
-- STORED PROCEDURES
-- ============================================

CREATE PROCEDURE sp_GetEventStatistics
    @EventId INT
AS
BEGIN
    SELECT 
        (SELECT COUNT(*) FROM Enrolments WHERE EventId = @EventId) AS TotalEnrolments,
        (SELECT COUNT(*) FROM Enrolments WHERE EventId = @EventId AND Status = 'Confirmed') AS ConfirmedEnrolments,
        (SELECT COUNT(*) FROM Enrolments WHERE EventId = @EventId AND PaymentStatus = 'Paid') AS PaidEnrolments,
        (SELECT COUNT(*) FROM Enrolments WHERE EventId = @EventId AND Status = 'Cancelled') AS CancelledEnrolments,
        (SELECT COUNT(*) FROM Results WHERE EnrolmentId IN (SELECT EnrolmentId FROM Enrolments WHERE EventId = @EventId)) AS ResultsSubmitted
END
GO

CREATE PROCEDURE sp_GetUpcomingEventsForParticipant
    @ParticipantId INT
AS
BEGIN
    SELECT 
        e.EventId,
        e.Name,
        e.EventDate,
        e.Location,
        c.CategoryName,
        c.Distance,
        en.EnrolmentId,
        en.Status AS EnrolmentStatus
    FROM Enrolments en
    INNER JOIN Events e ON en.EventId = e.EventId
    INNER JOIN Categories c ON en.CategoryId = c.CategoryId
    WHERE en.ParticipantId = @ParticipantId
        AND en.Status = 'Confirmed'
        AND e.EventDate >= CAST(GETDATE() AS DATE)
    ORDER BY e.EventDate ASC
END
GO

-- ============================================
-- TEST QUERIES - SHOW ALL DATA
-- ============================================

PRINT '============================================';
PRINT 'RACEDAY DATABASE CREATED SUCCESSFULLY!';
PRINT '============================================';
PRINT '';

-- TABLE 1: USERS
SELECT 'USERS (4 rows)' AS TableName;
SELECT * FROM Users;
GO

-- TABLE 2: ORGANISERS
SELECT 'ORGANISERS (2 rows)' AS TableName;
SELECT * FROM Organisers;
GO

-- TABLE 3: PARTICIPANTS
SELECT 'PARTICIPANTS (2 rows)' AS TableName;
SELECT * FROM Participants;
GO

-- TABLE 4: EVENTS
SELECT 'EVENTS (3 rows)' AS TableName;
SELECT * FROM Events;
GO

-- TABLE 5: CATEGORIES
SELECT 'CATEGORIES (8 rows)' AS TableName;
SELECT * FROM Categories;
GO

-- TABLE 6: ENROLMENTS ✅
SELECT 'ENROLMENTS (4 rows)' AS TableName;
SELECT * FROM Enrolments;
GO

-- TABLE 7: RESULTS ✅
SELECT 'RESULTS (3 rows)' AS TableName;
SELECT * FROM Results;
GO

-- TABLE 8: WEATHER ✅
SELECT 'WEATHER (5 rows)' AS TableName;
SELECT * FROM Weather;
GO

-- TABLE COUNTS - SHOWS ALL TABLES WITH DATA ✅
SELECT 'TABLE COUNTS' AS TableName;
SELECT 
    'Users' AS TableName, 
    COUNT(*) AS RecordCount 
FROM Users
UNION
SELECT 'Organisers', COUNT(*) FROM Organisers
UNION
SELECT 'Participants', COUNT(*) FROM Participants
UNION
SELECT 'Events', COUNT(*) FROM Events
UNION
SELECT 'Categories', COUNT(*) FROM Categories
UNION
SELECT 'Enrolments', COUNT(*) FROM Enrolments
UNION
SELECT 'Results', COUNT(*) FROM Results
UNION
SELECT 'Weather', COUNT(*) FROM Weather
ORDER BY TableName;
GO

-- VIEWS
SELECT 'EVENT DETAILS VIEW' AS TableName;
SELECT * FROM vw_EventDetails;
GO

SELECT 'PARTICIPANT ENROLMENTS VIEW' AS TableName;
SELECT * FROM vw_ParticipantEnrolments;
GO

-- STORED PROCEDURES
SELECT 'EVENT STATISTICS (Event 1)' AS TableName;
EXEC sp_GetEventStatistics @EventId = 1;
GO

SELECT 'UPCOMING EVENTS (Participant 1)' AS TableName;
EXEC sp_GetUpcomingEventsForParticipant @ParticipantId = 1;
GO

PRINT '============================================';
PRINT '✅ ALL DONE! ALL TABLES HAVE DATA!';
PRINT '============================================';
PRINT '';
PRINT 'Data Summary:';
PRINT '   - Users: 4 rows';
PRINT '   - Organisers: 2 rows';
PRINT '   - Participants: 2 rows';
PRINT '   - Events: 3 rows';
PRINT '   - Categories: 8 rows';
PRINT '   - Enrolments: 4 rows ✅';
PRINT '   - Results: 3 rows ✅';
PRINT '   - Weather: 5 rows ✅';
PRINT '';
PRINT 'Check the Results tab for all data!';
PRINT '============================================';
GO