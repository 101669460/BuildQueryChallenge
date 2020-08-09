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

BOOKING(ClientID, EventYear, EventMonth, EventDay, DateBooked, Payment)
PK: ClientID, EventYear, EventMonth, EventDay
FK1: ClientID references CLIENT
FK2: EventYear references EVENT
FK3: EventMonth references EVENT
FK4: EventDay references EVENT

CLIENT(ClientID, Surname, GivenName, Gender)
PK: ClientID
*/


