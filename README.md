# RaceDay – Portfolio of Evidence Part 1

## 1. Project Overview

RaceDay is a web-based event management system designed for the South African road running, walking and cycling community.

The system is designed to make it easier for event organisers to manage events, categories, participant enrolments and race results. Participants can create accounts, browse upcoming events, enrol in events and view their personal results.

Part 1 focuses on **planning the system and creating the database** before the C# RESTful API and MVC web application are developed in Parts 2 and 3.

## 2. Project Objectives

The main objectives of RaceDay are to:

* Allow organisers to create and manage sporting events.
* Allow organisers to create and manage event categories.
* Allow participants to register for an account.
* Allow participants to browse available events.
* Allow participants to enrol in event categories.
* Allow organisers to view event enrolments.
* Allow organisers to capture participant results.
* Allow participants to view their personal results.
* Store RaceDay information in a structured SQL Server database.
* Provide a clear API plan for development in Part 2.

---

## 3. User Roles

RaceDay has two main user roles.

### Organiser

An Organiser can:

* Create events.
* Edit events.
* Delete events.
* Manage event categories.
* View participant enrolments.
* Capture participant results.
* Manage event information.

### Participant

A Participant can:

* Create an account.
* Log into the system.
* View upcoming events.
* View event categories.
* Enrol in an event.
* View their own enrolments.
* View their personal race results.
  

## 4. Part 1 Deliverables

Part 1 contains three main components.

### Section A – Entity Relationship Diagram

The ERD represents the RaceDay database structure.

The database contains the following eight entities:

1. Users
2. Organisers
3. Participants
4. Events
5. Categories
6. Enrolments
7. Results
8. Weather

The ERD identifies primary keys, foreign keys and relationships between the entities.

### Section B – API Endpoint Plan

The API endpoint plan describes the RESTful API that will be developed in Part 2.

The plan includes endpoints for:

* Authentication
* User profiles
* Events
* Categories
* Event enrolments
* Results
* Routes
* Weather

### Section C – SQL Database Script

The SQL script creates the RaceDay database using Microsoft SQL Server.

The script includes:

* Database creation.
* Table creation.
* Primary keys.
* Foreign keys.
* Unique constraints.
* Check constraints.
* Default values.
* Sample Organisers.
* Sample Participants.
* Sample Events.
* Event Categories.
* Sample Enrolments.
* Sample Results.
* Route information.
* Weather information.
* Test queries.


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

Stores event participation categories such as 5 km, 10 km and cycling categories.

### Enrolments

Records participants who have entered an event category.

### Results

Stores participant race results such as finish time and position.

### Weather

Stores weather information associated with RaceDay events.

---

## 6. Database Relationships

The main relationships are:

* One User can have one Organiser profile.
* One User can have one Participant profile.
* One Organiser can manage many Events.
* One Event can have many Categories.
* One Event can have many Enrolments.
* One Participant can have many Enrolments.
* One Category can have many Enrolments.
* One Enrolment can have one Result.
* One Event can have many Weather records.

---

## 7. SQL Server Setup

To run the database:

1. Open Microsoft SQL Server Management Studio (SSMS).
2. Connect to a SQL Server instance.
3. Open:

`docs/RaceDay_Database.sql`

4. Execute the complete script.
5. Confirm that the `RaceDayDB` database has been created.
6. Refresh the Databases folder.
7. Open the RaceDayDB tables.
8. Run the SELECT statements included at the end of the script.
9. Confirm that the sample data has been inserted successfully.

The script is designed to create the database from a clean SQL Server instance.

---

## 8. Expected Sample Data

The database contains sample data including:

* 2 Organisers.
* 2 Participants.
* 3 Events.
* 5 Categories.
* 5 Event Category records.
* 4 Enrolments.
* 2 Results.
* 3 Routes.
* 3 Weather records.

This sample data is included to demonstrate that the database relationships work correctly.

---

## 9. GitHub Repository Structure

The intended repository structure is:

```text
RaceDay/
│
├── docs/
│   ├── RaceDay_ERD.pdf
│   ├── RaceDay_API_Endpoint_Plan.md
│   └── RaceDay_Database.sql
│
├── .github/
│   └── workflows/
│       └── part1-validation.yml
│
└── README.md
```

---

## 10. CI/CD

GitHub Actions is used in Part 1 to validate the required project structure.

The workflow checks that:

* The `docs` folder exists.
* The ERD exists.
* The API endpoint plan exists.
* The SQL script exists.
* The README file exists.

## 11. Video Presentation

A video presentation is required for Part 1.

The presentation will demonstrate:

1. The RaceDay project.
2. The ERD and database design.
3. The relationships between the database entities.
4. The API endpoint plan.
5. The SQL database script.
6. The execution of the SQL script in SSMS.
7. The resulting database and sample data.
8. The GitHub repository structure.
9. The successful GitHub Actions build.


## 12. Part 1 Testing

The SQL database will be tested by executing the complete SQL script in SQL Server Management Studio.

The following will be checked:

* Database is created successfully.
* All tables are created.
* Primary keys work correctly.
* Foreign keys work correctly.
* Unique constraints work correctly.
* Check constraints work correctly.
* Sample data is inserted.
* Relationships return the expected information.
* Enrolment information can be retrieved.
* Participant results can be retrieved.

Screenshots of the successful execution will be included as evidence where required.

---

## 13. Future Development

Part 1 provides the foundation for the remaining RaceDay project.


## 14. Conclusion

RaceDay Part 1 establishes the foundation for the complete RaceDay event management system.

The ERD defines the database structure, the API endpoint plan defines how the future application will communicate with the database, and the SQL script creates and populates the database.

The planning completed in Part 1 will be used as the foundation for the C# RESTful API in Part 2 and the MVC web application in Part 3.

---

## 15. Student Information

**Student Name:** Molly Seemola
**Project:** RaceDay
**Portfolio of Evidence:** Part 1
**Project Type:** Event Management System
**Database:** Microsoft SQL Server
**API Technology:** C# / ASP.NET Core
**Future Web Application:** ASP.NET Core MVC
