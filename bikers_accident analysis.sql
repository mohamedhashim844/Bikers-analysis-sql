
--#This is a Data set analysis of Bicycle accidents in Great Britain
--from 1970 to 2018 from road types to gender casualties.

--##This Dataset contains two table of data
-- 1- the first table(accidents) contains Details of the accidents like time,date and 
--weather condition.
-- 2- second table(bikers) contains bikers Details like gender and age    

--###  SELECT THE DATA 
SELECT * 
FROM Bikers_Accidents.dbo.accident


--SELECT * 
--FROM Bikers_Accidents.dbo.bikers
--ORDER BY 1

________________________________________________________________
--###   CLEANING DATA
--  ACCIDENTS TABLE

--SELECT Date  , CONVERT(date,Date)
--FROM  Bikers_Accidents.dbo.accident

--UPDATE Bikers_Accidents.dbo.accident
--SET Date = CONVERT(date,Date)

--### I tried to convert date column to (yyy-mm-dd) but it did not work
--so i added anthor coloumn(accident_date) and i converted it 


ALTER TABLE Bikers_Accidents.dbo.accident
ADD accident_date date

UPDATE Bikers_Accidents.dbo.accident
SET accident_date = CONVERT(date,Date)

SELECT accident_date , CONVERT(date,Date)
FROM  Bikers_Accidents.dbo.accident

--## Drop date column
ALTER TABLE Bikers_Accidents.dbo.accident
DROP COLUMN date

--##separate date from time 

--SELECT   CONVERT(TIME(0),Time)
--FROM  Bikers_Accidents.dbo.accident

--UPDATE Bikers_Accidents.dbo.accident
--SET Time = CONVERT(TIME(0),Time)

ALTER TABLE Bikers_Accidents.dbo.accident
ADD accident_time time

UPDATE Bikers_Accidents.dbo.accident
SET accident_time = CONVERT(TIME(0),accident_time)

--##DROP time column
ALTER TABLE Bikers_Accidents.dbo.accident
DROP COLUMN time 

--## weather_conditions
--## set missing data as clear and unknown data as other

SELECT distinct(Weather_conditions) , count(Weather_conditions) 
FROM Bikers_Accidents.dbo.accident
GROUP BY Weather_conditions


UPDATE Bikers_Accidents.dbo.accident
SET Weather_conditions = 'clear'
WHERE Weather_conditions = 'missing data'

UPDATE Bikers_Accidents.dbo.accident
SET Weather_conditions = 'other'
WHERE Weather_conditions = 'unknown'


SELECT * 
FROM Bikers_Accidents.dbo.accident

--##road_conditions
--##set missing data as dry

SELECT distinct(Road_conditions) , count(Road_conditions) 
FROM Bikers_Accidents.dbo.accident
GROUP BY Road_conditions


UPDATE Bikers_Accidents.dbo.accident
SET Road_conditions = 'Dry'
WHERE Road_conditions = 'missing data'

SELECT distinct(Speed_limit) , count(Speed_limit) AS COUNT
FROM Bikers_Accidents.dbo.accident
GROUP BY Speed_limit

UPDATE Bikers_Accidents.dbo.accident
SET Speed_limit = 30
WHERE Speed_limit = 660

--## I FOUND VALUE = 660 IN SPEED_LIMIT COLUMN AND I ADDED IT TO 
-- THE AVERAG VALUES WHICH IS 30

--## BIKERS TABLE

SELECT * 
FROM Bikers_Accidents.dbo.bikers
ORDER BY Accident_Id

SELECT distinct(Severity)  
FROM Bikers_Accidents.dbo.bikers

________________________________________________________________

SELECT * 
FROM Bikers_Accidents.dbo.accident


SELECT *  
FROM Bikers_Accidents.dbo.bikers
ORDER BY Accident_Id

--## TOP TIME IN WEEK WHERE ACCIDENT MOSTLY HAPPEND

--#DAY

SELECT Day , COUNT(Day)  as Count
FROM Bikers_Accidents.dbo.accident
GROUP BY Day
ORDER BY 2 DESC
--## WORKING DAY IS THE MOST DAY WHEN ACCIDENT HAPPEND(WED , TUS , THU , MON)

--#HOUR
SELECT DATEPART(HOUR,accident_time)AS HOUR , COUNT(*) AS COUNT
FROM Bikers_Accidents.dbo.accident
GROUP BY  DATEPART(HOUR,accident_time)
ORDER BY COUNT DESC
--# MOST HOUR WHEN ACCDENT HAPPEND (17,16,8,18,15,7)WHICH IS WHEN PEOPLE GO TO WORK
--IN MORNING AND COME BACK IN EVENING

--# MOST DAY VS MOST HOUR
SELECT Day, DATEPART(HOUR,accident_time) ,COUNT(*)
FROM Bikers_Accidents.dbo.accident
GROUP BY Day ,DATEPART(HOUR,accident_time)
ORDER BY COUNT(*) DESC
--# MOST ACCIDENT HAPPEND IN (TUE,WED,THU,MON,) AT (5PM) AND (WED,TUE,THU) AT 8AM

--## IN WHICH MONTH OF THE YEAR DO MOST ACCIDENT OCCUR?

SELECT MONTH(accident_date) as month , COUNT(*) AS COUNT
FROM Bikers_Accidents.dbo.accident
GROUP BY MONTH(accident_date)
ORDER BY COUNT(*) DESC

--## MOST ACCIDENT HAPPEND IN SUMMER MONTHS
____________________________________________________________________________________

--## GENDER VS AVERAG_SPEED 

SELECT Gender , AVG(speed_limit)
FROM Bikers_Accidents.dbo.accident a JOIN Bikers_Accidents.dbo.bikers b 
	 ON a.Accident_id = b.Accident_id
	 GROUP BY Gender

--## AGE_GROUP VS  AVERAG_SPEED
SELECT Age_Grp , AVG(speed_limit) AS AVERAG_SPEED
FROM Bikers_Accidents.dbo.accident a JOIN Bikers_Accidents.dbo.bikers b 
	 ON a.Accident_id = b.Accident_id
GROUP BY B.Age_Grp
ORDER BY AVG(speed_limit) DESC