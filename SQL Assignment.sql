-- Q1) Create a table “STATION ” to store information about weather observation stations:

CREATE TABLE STATION (
ID INT PRIMARY KEY, 
CITY CHAR(20),
STATE CHAR(2),
LAT_N INT,
LONG_W INT );
SELECT * FROM STATION;

-- Q2) Insert the following records into the table:

INSERT INTO STATION VALUES
(13 ,"PHOENIX", "AZ",33,112),
(44, "DENVER", "CO",40,105),
(66, "CARIBOU", "ME",47,68);

-- Q3) Execute a query to look at table STATION in undefined order.

SELECT * FROM STATION;

-- Q4) Execute a query to select Northern stations (Northern latitude > 39.7).

SELECT * FROM STATION
WHERE LAT_N> 39.7;

-- Q5) Create another table, ‘STATS’, to store normalized temperature and precipitation data:

CREATE TABLE STATS (
    ID INT,
    MONTH INT CHECK (MONTH BETWEEN 1 AND 12),
    TEMP_F FLOAT CHECK (TEMP_F BETWEEN -80 AND 150),
    RAIN_I FLOAT CHECK (RAIN_I BETWEEN 0 AND 100),
    CONSTRAINT FK_STATION_ID FOREIGN KEY (ID) REFERENCES STATION(ID),
    CONSTRAINT UNIQUE_ID_MONTH UNIQUE (ID, MONTH)
);
SELECT * FROM STATS;

-- Q6) Populate the table STATS with some statistics for January and July:

INSERT INTO STATS VALUES
(13,1,57.4,.31),
(13,7,91.7,5.15),
(44,1,27.3,.18),
(44,7,74.8,2.11),
(66,1,6.7,2.1),
(66,7,65.8,4.52);

-- Q7) Execute a query to display temperature stats (from the STATS table) for each city (from the STATION table).

SELECT TEMP_F,CITY 
FROM STATS
JOIN STATION 
ON STATS.ID = STATION.ID;

-- Q8) Execute a query to look at the table STATS, ordered by month and greatest rainfall, with columns rearranged. It should also show the corresponding cities.

SELECT MONTH,RAIN_I AS RAINFALL,CITY FROM STATS
JOIN STATION ON STATION.ID = STATS.ID
ORDER BY RAINFALL DESC, MONTH;

-- Q9) Execute a query to look at temperatures for July from table STATS, lowest temperatures first, picking up city name and latitude.

SELECT CITY, LAT_N, TEMP_F
FROM STATS
JOIN STATION 
ON STATS.ID = STATION.ID
WHERE MONTH = 7
ORDER BY TEMP_F ASC;


-- Q10) Execute a query to show MAX and MIN temperatures as well as average rainfall for each city.

SELECT CITY, 
MAX(TEMP_F) AS MAX_TEMP, 
MIN(TEMP_F) AS MIN_TEMP,
AVG (RAIN_I) AS AVG_RAIN
FROM STATS
JOIN STATION ON STATS.ID = STATION.ID
GROUP BY CITY;

-- Q11) Execute a query to display each city’s monthly temperature in Celcius and rainfall in Centimeter

SELECT CITY, MONTH,
(TEMP_F-32)*5/9 AS TEMP_C, 
RAIN_I*2.54 AS RAIN_CM 
FROM STATS
JOIN STATION ON STATS.ID = STATION.ID;

-- Another way using round()

SELECT CITY, MONTH,
ROUND( (TEMP_F-32)*5/9,3) AS TEMP_C, 
ROUND( RAIN_I*2.54,3) AS RAIN_CM 
FROM STATS
JOIN STATION ON STATS.ID = STATION.ID;


-- Q12) Update all rows of table STATS to compensate for faulty rain gauges known to read 0.01 inches low.

UPDATE STATS
SET RAIN_I = RAIN_I+0.01;
SELECT * FROM STATS;
SET SQL_SAFE_UPDATES = 0;

-- Q13) Update Denver's July temperature reading as 74.9.

UPDATE STATS
SET TEMP_F = 74.9
WHERE ID = (SELECT ID FROM STATION WHERE CITY = 'Denver')
AND MONTH = 7;

SELECT STATION.CITY, STATS.MONTH, STATS.TEMP_F
FROM STATS
JOIN STATION ON STATS.ID = STATION.ID
WHERE STATION.CITY = 'Denver' AND STATS.MONTH = 7;


-- NOTE ;
-- For disable the safe update mode
SET SQL_SAFE_UPDATES = 0;
