# 🏃 RaceDay – Portfolio of Evidence Part 1

## 1. Project Overview

RaceDay is a web-based event management system designed for the South African road running, walking and cycling community.

The system is designed to make it easier for event organisers to manage events, categories, participant enrolments and race results. Participants can create accounts, browse upcoming events, enrol in events and view their personal results.

Part 1 focuses on planning the system and creating the database before the C# RESTful API and MVC web application are developed in Parts 2 and 3.

---

## 2. Project Objectives

The main objectives of RaceDay are to:

- Allow organisers to create and manage sporting events
- Allow organisers to create and manage event categories
- Allow participants to register for an account
- Allow participants to browse available events
- Allow participants to enrol in event categories
- Allow organisers to view event enrolments
- Allow organisers to capture participant results
- Allow participants to view their personal results
- Store RaceDay information in a structured SQL Server database
- Provide a clear API plan for development in Part 2

---

## 3. System Roles

### Organiser

An Organiser can:

- Create events
- Edit events
- Delete events
- Manage event categories
- View participant enrolments
- Capture participant results
- Manage event information

### Participant

A Participant can:

- Create an account
- Log into the system
- View upcoming events
- View event categories
- Enrol in an event
- View their own enrolments
- View their personal race results

---

## 4. Part 1 Deliverables

Part 1 contains three main components:

### Section A – Entity Relationship Diagram (ERD)

The ERD represents the RaceDay database structure.

The database contains the following **eight entities**:

| # | Entity | Description |
|---|--------|-------------|
| 1 | Users | All system users |
| 2 | Organisers | Event organisers |
| 3 | Participants | Event participants |
| 4 | Events | Race/event details |
| 5 | Categories | Event categories (5km, 10km, etc.) |
| 6 | Enrolments | Participant registrations |
| 7 | Results | Race results |
| 8 | Weather | Weather forecasts for events |

The ERD identifies primary keys, foreign keys and relationships between the entities.

**File:** `docs/ERD.png`

---

### Section B – API Endpoint Plan

The API endpoint plan describes the RESTful API that will be developed in Part 2.

The plan includes endpoints for:

- Authentication (Register, Login, Profile)
- Events (Create, Read, Update, Delete)
- Categories (Create, Read, Update, Delete)
- Enrolments (Enrol, Cancel, View)
- Results (Submit, Update, View)
- Weather (Add, Update, View)
- Dashboard (Statistics)

**File:** `docs/API_Endpoint_Plan.md`

---

### Section C – SQL Database Script

The SQL script creates the RaceDay database using Microsoft SQL Server.

The script includes:

- Database creation
- Table creation (8 tables)
- Primary keys
- Foreign keys
- Unique constraints
- Check constraints
- Default values
- Indexes for performance
- Views for common queries
- Stored procedures
- Sample data:
  - 2 Organisers
  - 2 Participants
  - 3 Events
  - 8 Categories
  - 4 Enrolments
  - 3 Results
  - 5 Weather records
- Test queries

**File:** `docs/RaceDay_Schema.sql`

---

## 5. Database Entities

### Users
Stores information about all users in the RaceDay system.

### Organisers
Stores additional information about users who manage RaceDay events.

### Participants
Stores additional information about users who participate in events.

### Events
Stores information about running, walking and cycling events.

### Categories
Stores event participation categories such as 5km, 10km and cycling categories.

### Enrolments
Records participants who have entered an event category.

### Results
Stores participant race results such as finish time and position.

### Weather
Stores weather information associated with RaceDay events.

---

## 6. Database Relationships

The main relationships are:

| Relationship | Type | Description |
|---|---|---|
| Users → Organisers | 1:1 | One user can have one organiser profile |
| Users → Participants | 1:1 | One user can have one participant profile |
| Organisers → Events | 1:M | One organiser can manage many events |
| Events → Categories | 1:M | One event can have many categories |
| Events → Enrolments | 1:M | One event can have many enrolments |
| Participants → Enrolments | 1:M | One participant can have many enrolments |
| Categories → Enrolments | 1:M | One category can have many enrolments |
| Enrolments → Results | 1:1 | One enrolment can have one result |
| Events → Weather | 1:M | One event can have many weather records |

---

## 7. SQL Server Setup

To run the database:

1. Open Microsoft SQL Server Management Studio (SSMS)
2. Connect to a SQL Server instance
3. Open: `docs/RaceDay_Schema.sql`
4. Execute the complete script (F5)
5. Confirm that the RaceDayDB database has been created
6. Refresh the Databases folder
7. Open the RaceDayDB tables
8. Run the SELECT statements included at the end of the script
9. Confirm that the sample data has been inserted successfully

The script is designed to create the database from a clean SQL Server instance.

---

## 8. Expected Sample Data

The database contains sample data including:

| Table | Record Count |
|---|---|
| Users | 4 |
| Organisers | 2 |
| Participants | 2 |
| Events | 3 |
| Categories | 8 |
| Enrolments | 4 |
| Results | 3 |
| Weather | 5 |

This sample data is included to demonstrate that the database relationships work correctly.

---
## 9. GitHub Repository Structure
Race-dayDB-PROG-1
│
├── docs/
│ ├── ERD.png
│ ├── API_Endpoint_Plan.md
│ └── RaceDay_Schema.sql
│
├── .github/
│ └── workflows/
│ └── validate-docs.yml
│
├── README.md
├── .gitattributes
└── .gitignore

---

## 10. CI/CD Pipeline

GitHub Actions is used in Part 1 to validate the required project structure.

### Workflow Status

[![Validate Documentation](https://github.com/Molly-seemola/Race-dayDB-PROG-1/actions/workflows/validate-docs.yml/badge.svg)](https://github.com/Molly-seemola/Race-dayDB-PROG-1/actions/workflows/validate-docs.yml)

### What the Workflow Checks

| Check | Description |
|---|---|
| ✅ | `docs` folder exists |
| ✅ | ERD file exists (`ERD.png` or `ERD.pdf`) |
| ✅ | API endpoint plan exists (`API_Endpoint_Plan.md` or `.pdf`) |
| ✅ | SQL script exists (`RaceDay_Schema.sql`) |
| ✅ | SQL contains `CREATE TABLE` statements |
| ✅ | SQL contains `INSERT INTO` statements |
| ✅ | `README.md` exists |
| ✅ | `README.md` contains "System" and "Role" sections |

### Green Build Screenshot

![Green Build](docs/screenshot.png)

---

## 11. Video Presentation

A video presentation is required for Part 1.

### What the Presentation Covers

- The RaceDay project overview
- The ERD and database design
- The relationships between the database entities
- The API endpoint plan
- The SQL database script
- The execution of the SQL script in SSMS
- The resulting database and sample data
- The GitHub repository structure
- The successful GitHub Actions build

### Video Link

[📺 Watch Part 1 Walkthrough on YouTube](https://youtu.be/your-video-id)

---

## 12. Part 1 Testing

The SQL database will be tested by executing the complete SQL script in SQL Server Management Studio.

### Test Checklist

| Test | Status |
|---|---|
| Database is created successfully | ✅ |
| All tables are created | ✅ |
| Primary keys work correctly | ✅ |
| Foreign keys work correctly | ✅ |
| Unique constraints work correctly | ✅ |
| Check constraints work correctly | ✅ |
| Sample data is inserted | ✅ |
| Relationships return expected information | ✅ |
| Enrolment information can be retrieved | ✅ |
| Participant results can be retrieved | ✅ |

---

## 13. Future Development

Part 1 provides the foundation for the remaining RaceDay project.

### Part 2 – RESTful API

- Build RESTful API in C# as per the approved plan
- Connect to the database
- Write unit tests with GitHub CI/CD
- Implement role-based access control

### Part 3 – MVC Web Application

- Build MVC web application that consumes the API
- Integrate Azure Blob Storage
- Containerise the application using Docker

---

## 14. Conclusion

RaceDay Part 1 establishes the foundation for the complete RaceDay event management system.

The ERD defines the database structure, the API endpoint plan defines how the future application will communicate with the database, and the SQL script creates and populates the database.

The planning completed in Part 1 will be used as the foundation for the C# RESTful API in Part 2 and the MVC web application in Part 3.

---

## 15. Student Information

| Detail | Information |
|---|---|
| **Student Name** | Molly Seemola |
| **Project** | RaceDay Part 1 |
| **Portfolio of Evidence** | Part 1 |
| **Project Type** | Event Management System |
| **Database** | Microsoft SQL Server |
| **API Technology** | C# / ASP.NET Core |
| **Future Web Application** | ASP.NET Core MVC |


*Created for Portfolio of Evidence (PoE) – Part 1*

*Student: Molly Seemola*

## 9. GitHub Repository Structure
