-- Importing large data more than lakhs of rows
USE AthetesData;
-- 1. Create the table athletes
create table athletes(
	Id int,
    Name varchar(200),
    Sex char(1),
    Age int,
    Height float,
    Weight float,
    Team varchar(200),
    NOC char(3),
    Games varchar(200),
    Year int,
    Season varchar(200),
    City varchar(200),
    Sport varchar(200),
    Event varchar(200),
    Medal Varchar(50));

-- View the blank Athletes table
select * from athletes;

-- Location to add the csv
SHOW VARIABLES LIKE "secure_file_priv";

-- Load the data from csv file after saving to above location
load data infile './Athletes_Cleaned.csv'
into table athletes
fields terminated by ','
enclosed by '"'
lines terminated by '\r\n'
ignore 1 rows;

-- View the table
select * from athletes;

-- Check number of rows in the table
select count(*) from athletes;
 
 
 -- Q1. Show how many medal counts present for entire data.

SELECT MEDAL ,COUNT(MEDAL) FROM  athletes
group by MEDAL;


-- Q2 Show count of unique Sports are present in olympics.
SELECT  COUNT(DISTINCT(Sport))FROM athletes;

-- Q3. Show how many different medals won by Team India in data.

select medal ,NOC,count(medal) as count_medal
from athletes
where NOC = 'IND'and medal!= 'nomedal'
group by medal;



-- Q4. Show event wise medals won by india show from highest to lowest medals won in order.
SELECT event, NOC,
COUNT(medal) AS medals_won
FROM athletes
WHERE NOC = 'Ind'AND MEDAL!= 'NOMEDAL'
GROUP BY event
ORDER BY medals_won DESC;


-- Q5. Show event and yearwise medals won by india in order of year.

SELECT event, year, TEAM,
    COUNT(medal) AS medals_won
FROM ATHLETES
WHERE team = 'India' AND MEDAL != 'NOMEDAL'
GROUP BY event, year
ORDER BY year ASC;


-- Q6 Show the country with maximum medals won gold, silver, bronze
SELECT TEAM , count(MEDAL) as medal_count FROM  ATHLETES
where medal !="NoMedal"
GROUP BY team
order by medal_count DESC 
limit 1;



-- Q7. Show the top 10 countries with respect to gold medals

select medal ,count(medal) as medal_count, NOC from athletes
where medal = "gold"
group by NOC
order by medal_count desc limit 10;


select * from athletes;

-- Q8. Show in which year did United States won most medals
SELECT  YEAR ,NOC , COUNT(MEDAL) as medal_count FROM ATHLETES
WHERE NOC = 'USA' AND MEDAL != 'NOMEDAL' 
group by year,NOC
ORDER BY medal_count DESC limit 1; 

-- Q9. In which sports United States has most medals
SELECT  SPORT ,NOC ,COUNT(MEDAL) AS MEDAL_COUNT 
FROM ATHLETES
WHERE NOC = 'USA' AND MEDAL!='NOMEDAL'
GROUP BY SPORT
ORDER BY MEDAL_COUNT  DESC LIMIT 1;

select * FROM ATHLETES;

-- Q10. Find top 3 players who have won most medals along with their sports and country.
SELECT Name,SPORT, TEAM  ,COUNT(MEDAL) AS MEDAL_COUNT FROM ATHLETES
WHERE MEDAL!= 'NOMEDAL'
GROUP  BY TEAM, sport, name
order by medal_count desc limit 3;


-- Q11. Find player with most gold medals in cycling along with his country
SELECT NAME ,SPORT ,NOC ,COUNT(MEDAL) AS MEDAL_COUNT FROM ATHLETES
WHERE SPORT = 'CYCLING'AND MEDAL= 'GOLD'
GROUP BY NOC,NAME
ORDER BY  MEDAL_COUNT desc LIMIT 2 ;

/*Q12. Find player with most medals (Gold + Silver + Bronze) 
in Basketball also show his country.*/

SELECT  NOC ,SPORT ,NAME ,COUNT(MEDAL)AS MEDAL_COUNT FROM ATHLETES
WHERE SPORT = 'BASKETBALL' AND MEDAL!= 'NO MEDAL'
GROUP BY NOC,NAME,SPORT
ORDER BY   MEDAL_COUNT DESC LIMIT 1 ;


-- Q13. Find out the count of different medals of the top basketball player.
select name, sport, medal, count(medal)as mdedal_count from athletes
where sport = 'basketball' and medal !='nomedal'
group by medal, name, sport
order by mdedal_count desc;


-- Q14. Find out medals won by male, female each year . Export this data and plot graph in excel.

select * from athletes;

SELECT YEAR ,SEX,COUNT(MEDAL) 
FROM ATHLETES
WHERE MEDAL != 'NOMEDAL'
GROUP BY SEX,year
ORDER BY YEAR;


