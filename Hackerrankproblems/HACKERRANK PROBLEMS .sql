--Query the two cities in STATION with the shortest and longest CITY names, as well as their respective lengths (i.e.: number of characters in the name). If there is more than one smallest or largest city, choose the one that comes first when ordered alphabetically.
--The STATION table is described as follows:

--this is for the Shortest city name 
Select top 1 city ,
 len(CITY) as CITY_length
 from STATION
 order by LEN(CITY) ASC , CITY ASC
 GO

 -- this is for the longest city name
 Select top 1 CITY , len(CITY) as CITY_length
 from STATION 
 order by len(CITY) DESC, CITY ASC
 GO

