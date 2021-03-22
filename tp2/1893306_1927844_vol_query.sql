SET search_path to tp2;

SELECT * FROM Passenger WHERE PassengerID IN (
       SELECT PassengerNo FROM Ticket WHERE BookingNo IN (
              SELECT BookingNo FROM FlightBooking WHERE FlightNo IN (
                     SELECT FlightID FROM Flight WHERE
                            DepartureNo IN (SELECT Code FROM Airport WHERE City = 'Montréal')
                            AND
                            ArrivalNo   IN (SELECT Code FROM Airport WHERE City = 'Rabat')
              )
       )
);
-- Toto et Tata :-)
