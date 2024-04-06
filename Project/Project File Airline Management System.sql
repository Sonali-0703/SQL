-- 1. Retrieve information about all airlines:
SELECT * FROM Airlines;

-- 2. Retrieve information about all aircrafts:
SELECT * FROM Aircrafts;

-- 3. Retrieve a list of passengers for a specific flight:
SELECT Passengers.*
FROM Passengers
JOIN Reservations ON Passengers.PassengerID = Reservations.PassengerID
WHERE Reservations.FlightID = 1;

-- 4. Retrieve a list of flights for a specific airline:
SELECT * FROM Flights WHERE AirlineID = 1;

-- 5. Retrieve available seats for a specific flight:
SELECT 
    Flights.FlightNumber, 
    Flights.DepartureTime,
    Flights.ArrivalTime, 
    Flights.DepartureAirport,
    Flights.ArrivalAirport, 
    Flights.AircraftID, 
    Aircrafts.Capacity 
FROM 
    Flights 
JOIN 
    Aircrafts ON Flights.AircraftID = Aircrafts.AircraftID 
LEFT JOIN 
    Reservations ON Flights.FlightID = Reservations.FlightID 
WHERE 
    Flights.FlightID = Reservations.FlightID
    AND (Reservations.ReservationID IS NULL OR Reservations.ReservationTime < NOW()); 

-- 6. Retrieve the total number of reservations for a specific flight:
SELECT COUNT(*) AS ReservationCount FROM Reservations
WHERE FlightID = 1;

-- 7. Retrieve a list of passengers with their flight details for a specific airline:
SELECT 
    Passengers.FirstName, 
    Passengers.LastName, 
    Flights.FlightNumber,
    Flights.DepartureAirport, 
    Flights.ArrivalAirport 
FROM 
    Passengers 
JOIN 
    Reservations ON Passengers.PassengerID = Reservations.PassengerID 
JOIN 
    Flights ON Reservations.FlightID = Flights.FlightID 
WHERE 
    Flights.AirlineID = 1;


