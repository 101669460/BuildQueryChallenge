/* 
    Student ID: 101669460
    Name: Dylan Dinsdale
*/
    
/* 
Task 1 (Relational Schema)

TOUR(TourName, Description)
PK: TourName

EVENT(TourName, EventYear, EventMonth, EventDay, Fee)
PK: EventYear, EventMonth, EvenDay, TourName
FK1: TourName references TOUR

BOOKING(ClientID, Tourname, EventYear, EventMonth, EventDay, DateBooked, Payment)
PK: ClientID, Tourname, EventYear, EventMonth, EventDay
FK1: ClientID references CLIENT
FK2: Tourname, EventYear, EventMonth, EventDay references EVENT

CLIENT(ClientID, Surname, GivenName, Gender)
PK: ClientID
*/



USE master
GO
IF NOT EXISTS (
    SELECT name
        FROM sys.databases
        WHERE name = N'BUILDQUERYDATABASE'
)
CREATE DATABASE BUILDQUERYDATABASE
GO

USE BUILDQUERYDATABASE

IF OBJECT_ID('TOUR') IS NOT NULL
DROP TABLE TOUR;

IF OBJECT_ID('EVENTS') IS NOT NULL
DROP TABLE EVENTS;

IF OBJECT_ID('BOOKING') IS NOT NULL
DROP TABLE BOOKING;

IF OBJECT_ID('CLIENT') IS NOT NULL
DROP TABLE CLIENT;
GO
CREATE TABLE TOUR(
    TOURNAME NVARCHAR(50),
    TOURDESCRIPT NVARCHAR(1000),
    PRIMARY KEY(TOURNAME)
);

CREATE TABLE EVENTS(
    TOURNAME NVARCHAR(50),
    EVENTYEAR INT,
    EVENTMONTH NVARCHAR(15),
    EVENTDAY INT,
    FEE INT,
    PRIMARY KEY(TOURNAME, EVENTYEAR, EVENTMONTH, EVENTDAY),
    FOREIGN KEY(TOURNAME) REFERENCES TOUR 
);
CREATE TABLE CLIENT(
    CLIENTID INT,
    SURNAME NVARCHAR(50),
    GIVENNAME NVARCHAR(50),
    GENDER NVARCHAR(1),
    PRIMARY KEY(CLIENTID)
); 

CREATE TABLE BOOKING(
    CLIENTID INT,
    TOURNAME NVARCHAR(50),
    EVENTYEAR INT,
    EVENTMONTH NVARCHAR(15),
    EVENTDAY INT,
    DATEBOOKED DATE,
    PAYMENT INT,
    PRIMARY KEY(CLIENTID, TOURNAME, EVENTYEAR, EVENTMONTH, EVENTDAY),
    FOREIGN KEY(CLIENTID) REFERENCES CLIENT,
    FOREIGN KEY(TOURNAME, EVENTYEAR, EVENTMONTH, EVENTDAY) REFERENCES EVENTS
);
GO
INSERT INTO CLIENT (CLIENTID, SURNAME, GIVENNAME, GENDER) VALUES
(1, 'Price', 'Taylor', 'M'),
(2, 'Gamble', 'Ellyse', 'F'),
(3, 'Tan', 'Tilley', 'F'),
(101669460, 'Dinsdale','Dylan', 'M');

INSERT INTO TOUR (TOURNAME, TOURDESCRIPT) VALUES
('North', 'Tour of winerise and outlets of the Bendigo and Castlemaine region'),
('South', 'Tour of wineries and outlets of Mornington Peninsula'),
('West', 'Tour of wineries and outlets of the Geelong and Otways Region');

INSERT INTO EVENTS (TOURNAME, EVENTMONTH, EVENTDAY, EVENTYEAR, FEE) VALUES
('North', 'Jan', 9, 2016, 200),
('North', 'Feb', 13, 2016, 225),
('South', 'Jan', 9, 2016, 200),
('South', 'Jan', 16, 2016, 200),
('West', 'Jan', 29, 2016, 225);

INSERT INTO BOOKING (CLIENTID, TOURNAME, EVENTMONTH, EVENTDAY, EVENTYEAR, PAYMENT, DATEBOOKED) VALUES
(1, 'North', 'Jan', 9, 2016, 200, CONVERT(DATETIME, '12/10/2015')),
(2, 'North', 'Jan', 9, 2016, 200, CONVERT(DATETIME, '12/16/2015')),
(1, 'North', 'Feb', 13, 2016, 225, CONVERT(DATETIME, '01/08/2016')),
(2, 'North', 'Feb', 13, 2016, 125, CONVERT(DATETIME, '01/14/2016')),
(3, 'North', 'Feb', 13, 2016, 225, CONVERT(DATETIME, '02/03/2016')),
(1, 'South', 'Jan', 9, 2016, 200, CONVERT(DATETIME, '12/10/2015')),
(2, 'South', 'Jan', 16, 2016, 200, CONVERT(DATETIME, '12/18/2015')),
(3, 'South', 'Jan', 16, 2016, 200, CONVERT(DATETIME, '01/09/2016')),
(2, 'West', 'Jan', 29, 2016, 225, CONVERT(DATETIME, '12/17/2015')),
(3, 'West', 'Jan', 29, 2016, 200, CONVERT(DATETIME, '12/18/2015'));
GO
CREATE VIEW QUERY1 AS

    SELECT C.GIVENNAME, C.SURNAME, B.PAYMENT, B.DATEBOOKED, B.EVENTMONTH, B.EVENTDAY, B.EVENTYEAR, E.FEE, T.TOURNAME, T.TOURDESCRIPT
    FROM CLIENT C
    INNER JOIN BOOKING B
    ON C.CLIENTID = B.CLIENTID
    INNER JOIN EVENTS E
    ON E.EVENTYEAR = B.EVENTYEAR
    JOIN TOUR T
    ON T.TOURNAME = E.TOURNAME
;
GO
SELECT * FROM QUERY1;
GO
SELECT B.EVENTMONTH, T.TOURNAME, COUNT(B.EVENTMONTH) AS TOTAL
FROM TOUR T
INNER JOIN EVENTS E
ON T.TOURNAME = E.TOURNAME
INNER JOIN BOOKING B
ON B.EVENTMONTH = E.EVENTMONTH
GROUP BY B.EVENTMONTH, T.TOURNAME
ORDER BY B.EVENTMONTH DESC, T.TOURNAME ASC;
GO
SELECT * FROM BOOKING
WHERE PAYMENT > (SELECT AVG(PAYMENT) FROM BOOKING);
GO

SELECT COUNT(*) FROM QUERY1

/* CHECKED NUMBER OF ROLES IN THE FIRST QUERY */

SELECT COUNT(*) FROM BOOKING
/* MAKING SURE THE TOTAL NUMBER OF BOOKINGS IS EQUAL TO THE TOTAL IN COLUMN TOTAL */

SELECT AVG(PAYMENT) FROM BOOKING
/* CHECKING AVERAGE PAYMENT TO MAKE SURE RETURNED VALUES FROM QUERY 3 ARE LARGER */