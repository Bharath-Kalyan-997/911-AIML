-- Create a database
CREATE DATABASE EmergencyCallAnalysis;

USE EmergencyCallAnalysis;

--table has been created
CREATE TABLE Calls (
    CallID INT PRIMARY KEY AUTO_INCREMENT,
    Timestamp DATETIME,
    CallType VARCHAR(50),
    Description TEXT,
    Latitude FLOAT,
    Longitude FLOAT,
    City VARCHAR(50),
    ZipCode INT
);

CREATE TABLE Responders (
    ResponderID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100),
    Role VARCHAR(50),
    ContactInfo VARCHAR(50)
);

CREATE TABLE CallAssignments (
    AssignmentID INT PRIMARY KEY AUTO_INCREMENT,
    CallID INT,
    ResponderID INT,
    ResponseTime FLOAT,
    FOREIGN KEY (CallID) REFERENCES Calls(CallID),
    FOREIGN KEY (ResponderID) REFERENCES Responders(ResponderID)
);

-- Insert sampledata with refined variables
INSERT INTO Calls (Timestamp, CallType, Description, Latitude, Longitude, City, ZipCode)
VALUES 
('2024-12-01 14:30:00', 'Fire', 'House fire', 40.7128, -74.0060, 'New York', 10001),
('2024-12-01 15:00:00', 'Medical', 'Heart attack', 34.0522, -118.2437, 'Los Angeles', 90001);

INSERT INTO Responders (Name, Role, ContactInfo)
VALUES 
('John Doe', 'Firefighter', '555-1234'),
('Jane Smith', 'Paramedic', '555-5678');

INSERT INTO CallAssignments (CallID, ResponderID, ResponseTime)
VALUES
(1, 1, 10.5),
(2, 2, 8.3);
