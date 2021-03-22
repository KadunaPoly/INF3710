SET search_path TO tp2;

-- Clients & Passengers
INSERT INTO Client(ClientID, FirstName, LastName) VALUES (1, 'Toto', 'Otot');
INSERT INTO Client(ClientID, FirstName, LastName) VALUES (2, 'Tata', 'Atat');

INSERT INTO Passenger(PassengerID, FirstName, LastName, Sexe) VALUES (1, 'Toto', 'Otot', 'M');
INSERT INTO Passenger(PassengerID, FirstName, LastName, Sexe) VALUES (2, 'Tata', 'Atat', 'F');
INSERT INTO Passenger(PassengerID, FirstName, LastName, Sexe) VALUES (3, 'Poly', 'Mtl',  'U'); -- Sexe is undefined


-- Airports
INSERT INTO Airport(Code, City) VALUES (1, 'Montréal') , (2, 'Rabat'), (3, 'Toronto');

-- The only plane
INSERT INTO Plane(PlaneID, manufacturer, model, acquire, numberOfSeat) VALUES (1,
                                                                               'Boeing',
                                                                               'Boeing 737 MAX',
                                                                               CURRENT_DATE,
                                                                               204);
-- Fare
INSERT INTO Fare(Code, Condition) VALUES (1, 'Regular');
INSERT INTO Fare(Code, Condition) VALUES (2, 'Student');

-- Flights

-- Mtl => Rabat
INSERT INTO Flight(FlightID, PlaneNo, DepartureNo, ArrivalNo) VALUES (
       1,
       (SELECT PlaneID FROM Plane LIMIT 1),
       (SELECT Code    FROM Airport WHERE City = 'Montréal'),
       (SELECT Code    FROM Airport WHERE City = 'Rabat')
);

-- Mtl => Toronto
INSERT INTO Flight(FlightID, PlaneNo, DepartureNo, ArrivalNo) VALUES (
       2,
       (SELECT  PlaneID FROM Plane LIMIT 1),
       (SELECT  Code    FROM Airport WHERE City = 'Montréal'),
       (SELECT  Code    FROM Airport WHERE City = 'Toronto')
);

-- Bookings
INSERT INTO Booking(BookingID, ClientNo, Price) VALUES (1, (SELECT  ClientID FROM Client WHERE FirstName = 'Toto'), 20);
INSERT INTO Booking(BookingID, ClientNo, Price) VALUES (2, (SELECT  ClientID FROM Client WHERE FirstName = 'Tata'), 20);
INSERT INTO Booking(BookingID, ClientNo, Price) VALUES (3, (SELECT  ClientID FROM Client WHERE FirstName = 'Tata'), 40);

-- Tickets
INSERT INTO Ticket(TicketID, BookingNo, PassengerNo) VALUES (
       1,
       (SELECT  BookingID FROM Booking WHERE BookingID = 1),
       (SELECT  PassengerID FROM Passenger WHERE FirstName = 'Toto')
);

INSERT INTO Ticket(TicketID, BookingNo, PassengerNo) VALUES (
       2,
       (SELECT  BookingID FROM Booking WHERE BookingID = 2),
       (SELECT  PassengerID FROM Passenger WHERE FirstName = 'Tata')
);

INSERT INTO Ticket(TicketID, BookingNo, PassengerNo) VALUES (
       3,
       (SELECT  BookingID FROM Booking WHERE BookingID = 3),
       (SELECT  PassengerID FROM Passenger WHERE FirstName = 'Poly')
);

INSERT INTO FlightBooking(BookingNo, FlightNo, FareNo) VALUES (1, 1, 1), -- Toto : Mtl => Rabat
                                                              (2, 1, 1), -- Tata : Mtl => Rabat
                                                              (3, 2, 1); -- Poly : Mtl => Toronto
