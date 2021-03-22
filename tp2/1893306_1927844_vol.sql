SET search_path TO tp2;

DROP SCHEMA IF EXISTS tp2 CASCADE;
CREATE SCHEMA tp2;

CREATE TABLE  Cancelation (

        CancelID INTEGER,

        Reason   VARCHAR(256) NOT NULL,


        PRIMARY KEY(CancelID)
);

CREATE TABLE  FlightDelay  (

        DelayID INTEGER,

        RealDeparture  TIMESTAMP NOT NULL,
        RealArrival    TIMESTAMP NOT NULL,
        Reason   VARCHAR(256)    NOT NULL,


        PRIMARY KEY(DelayID)
);

CREATE TABLE  Fare (

        Code INTEGER,

        Condition VARCHAR(20) NOT NULL,


        PRIMARY KEY(Code)
);

CREATE TABLE  Plane (

        PlaneID INTEGER,

        manufacturer VARCHAR(20) NOT NULL,
        model        VARCHAR(20) NOT NULL,
        acquire      DATE        NOT NULL,
        numberOfSeat SMALLINT,



        PRIMARY KEY(PlaneID)
);

CREATE TABLE  Airport (

        Code INTEGER,

        City VARCHAR(20) NOT NULL,


        PRIMARY KEY(Code)
);

CREATE TABLE  Seat (

        SeatNo  SMALLINT,
        PlaneNo INTEGER        NOT NULL,

        SeatClass  VARCHAR(20) NOT NULL,


        PRIMARY KEY(SeatNo, PlaneNo), -- Un avion est compose de
        FOREIGN KEY(PlaneNo) REFERENCES Plane(PlaneID) ON DELETE CASCADE
);

CREATE TABLE  Client (

       ClientID  INTEGER,

       FirstName VARCHAR(20) NOT NULL,
       LastName  VARCHAR(20) NOT NULL,


       PRIMARY KEY(ClientID)
);


CREATE TABLE  Passenger (

       PassengerID   INTEGER,

       FirstName     VARCHAR(20) NOT NULL,
       LastName      VARCHAR(20) NOT NULL,
       Sexe          CHAR        NOT NULL,

       PRIMARY KEY(PassengerID)
);


CREATE TABLE  Booking (

       BookingID   INTEGER,  -- On suppose que les clefs primaire sont toujours non nulle
       ClientNo    INTEGER   NOT NULL,

       DateBooking DATE      DEFAULT CURRENT_DATE,
       Price       MONEY,
       PaymentDone BOOLEAN   DEFAULT FALSE,


       PRIMARY KEY (BookingID),
       FOREIGN KEY (ClientNo)    REFERENCES Client(ClientID)       -- Effectue
);


CREATE TABLE  Ticket (

      TicketID    INTEGER,
      BookingNo   INTEGER   NOT NULL,
      PassengerNo INTEGER   NOT NULL,


      PRIMARY KEY(TicketID),
      FOREIGN KEY(BookingNo)   REFERENCES Booking(BookingID)      ON DELETE CASCADE, -- Emet
      FOREIGN KEY(PassengerNo) REFERENCES Passenger(PassengerID)  ON DELETE CASCADE  -- Emis pour
);

CREATE TABLE  CreditCard (

        CardNo VARCHAR(16),

        Expiration DATE        NOT NULL,
        OwnerName  VARCHAR(20) NOT NULL,


        PRIMARY KEY (CardNo)
);


CREATE TYPE PaymentType AS ENUM ('Cash', 'Credit', 'Debit');


CREATE TABLE  Payment (

        PaymentID    INTEGER,
        BookingNo    INTEGER     NOT NULL UNIQUE,
        CreditCardNo VARCHAR(16) DEFAULT NULL,

        PaymentDate DATE    DEFAULT CURRENT_DATE,
        mode  PaymentType   NOT NULL,


      PRIMARY KEY (PaymentID),
      FOREIGN KEY (BookingNo) REFERENCES Booking(BookingID)     ON DELETE CASCADE,  -- Confirmee par
      FOREIGN KEY (CreditCardNo) REFERENCES CreditCard(CardNo)  ON DELETE RESTRICT -- Fait par
);



CREATE TABLE  Luggage(

        LuggageID INTEGER,


        PRIMARY KEY(LuggageID)
);


CREATE TABLE  LuggageRegistration(

        RegistrationID   INTEGER,
        LuggageNo        INTEGER NOT NULL,

        RegistrationDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- (date + heure)


        PRIMARY KEY(RegistrationID),
        FOREIGN KEY(LuggageNo) REFERENCES Luggage(LuggageID) -- Possede
);


CREATE TABLE  Flight (

        FlightID       INTEGER,
        PlaneNo        INTEGER NOT NULL,
        DepartureNo    INTEGER NOT NULL,
        ArrivalNo      INTEGER NOT NULL,
        CancelationNo  INTEGER DEFAULT NULL,
        DelayNo        INTEGER DEFAULT NULL,

        Departure TIMESTAMP, -- DateDepart  + HeureDepart
        Arrival   TIMESTAMP, -- DateArrivee + HeureArrivee


      PRIMARY KEY (FlightID),
      FOREIGN KEY (PlaneNo)       REFERENCES Plane(PlaneID),          -- Assure par
      FOREIGN KEY (DepartureNo)   REFERENCES Airport(Code),           -- Quitte
      FOREIGN KEY (ArrivalNo)     REFERENCES Airport(Code),           -- Arrive
      FOREIGN KEY (CancelationNo) REFERENCES Cancelation(CancelID),   -- Suivi de
      FOREIGN KEY (DelayNo)       REFERENCES FlightDelay(DelayID)     -- Possede
);

CREATE TABLE  FlightLuggage(

        PassengerNo           INTEGER NOT NULL,
        FlightNo              INTEGER NOT NULL,
        LuggageRegistrationNo INTEGER NOT NULL,


        PRIMARY KEY(PassengerNo, FlightNo, LuggageRegistrationNo),
        FOREIGN KEY(PassengerNo) REFERENCES Passenger(PassengerID)                        ON DELETE CASCADE, -- Appartient À
        FOREIGN KEY(FlightNo) REFERENCES Flight(FlightID)                                 ON DELETE CASCADE,
        FOREIGN KEY(LuggageRegistrationNo) REFERENCES LuggageRegistration(RegistrationID) ON DELETE CASCADE
);


CREATE TABLE  Employee(

       EmployeeID INTEGER,

       HireDate   DATE NOT NULL,


        PRIMARY KEY (EmployeeID)
);

CREATE TABLE  Pilot (

        LicenceNo INTEGER,

        LicenceObtentionDate DATE NOT NULL,


        PRIMARY KEY(LicenceNo)

) INHERITS(Employee);


CREATE TYPE ResponsabilityType AS ENUM ('CrewMember', 'Janitor', 'Agent', 'Technician', 'Engineer');

CREATE TABLE  Responsability(

        EmployeeNo INTEGER            NOT NULL,
        FlightNo   INTEGER            NOT NULL,

        rType      ResponsabilityType NOT NULL,


        PRIMARY KEY(EmployeeNo, FlightNo),

        -- Fait appel
        FOREIGN KEY(EmployeeNo) REFERENCES Employee(EmployeeID) ON DELETE CASCADE,
        FOREIGN KEY(FlightNo)   REFERENCES Flight(FlightID)     ON DELETE CASCADE
);


CREATE TABLE  FlightBooking (

        BookingNo INTEGER NOT NULL,
        FlightNo  INTEGER NOT NULL,
        FareNo    INTEGER NOT NULL,


        PRIMARY KEY (BookingNo, FlightNo),
        FOREIGN KEY (BookingNo) REFERENCES Booking(BookingID)     ON DELETE CASCADE,
        FOREIGN KEY (FlightNo)  REFERENCES Flight(FlightID)       ON DELETE CASCADE,
        FOREIGN KEY (FareNo)    REFERENCES Fare(Code)             ON DELETE CASCADE -- Applique a
);
