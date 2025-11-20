----------------------------------------------------------------------------------------------
-- Exploratory Data Analysis

-- Table 1
-- I want to see the basic data of the userprofile table
SELECT *
FROM casestudy2.brighttv.userprofiles
LIMIT 50;
-- Assessin the Distinct Races
SELECT DISTINCT IFNULL(race,'Race Unknown') AS Race
FROM casestudy2.brighttv.userprofiles
LIMIT 50;
-- Getting the Distinct Province
SELECT DISTINCT IFNULL(province,'Province Unknown') AS Province
FROM casestudy2.brighttv.userprofiles
LIMIT 50;

SELECT DISTINCT IFNULL(gender,'Gender Unknown') AS Province
FROM casestudy2.brighttv.userprofiles
LIMIT 50;

-- Getting the number of users based on this table
SELECT COUNT(userid) AS Number_Of_Users
FROM casestudy2.brighttv.userprofiles
LIMIT 50;



-- Table 2
-- I want to see the basic data of the viewership table
SELECT *
FROM casestudy2.brighttv.viewership
LIMIT 50;

SELECT DISTINCT channel2
FROM casestudy2.brighttv.viewership
LIMIT 50;

SELECT COUNT(DISTINCT userid) AS Number_Of_Viewership_Stats
FROM casestudy2.brighttv.viewership
LIMIT 50;

-- Checking the first Viewing date
SELECT MIN(recorddate2) AS First_View_Date
FROM casestudy2.brighttv.viewership
LIMIT 50;

-- Checking the Last Viewing date
SELECT MAX(recorddate2) AS Last_View_Date
FROM casestudy2.brighttv.viewership
LIMIT 50;

-- Checking the Minimum Duration
SELECT MIN(duration2) AS Minimum_Duration
FROM casestudy2.brighttv.viewership
LIMIT 50;

-- Checking the Maximum Duration
SELECT MAX(duration2) AS Maximum_Duration
FROM casestudy2.brighttv.viewership
LIMIT 50;

-- Extracting the Time from the timestamp
SELECT recorddate2,
       TIME(DATEADD(hour,2, TO_TIMESTAMP(recorddate2,'YYYY/MM/DD HH24:MI'))) AS Time
FROM casestudy2.brighttv.viewership
LIMIT 50;

-- Extracting the Date from the timestamp
SELECT recorddate2,
       DATE(TO_TIMESTAMP(recorddate2,'YYYY/MM/DD HH24:MI')) AS Date
FROM casestudy2.brighttv.viewership
LIMIT 50;

 
--Inner Join to see all the data together
SELECT *
FROM casestudy2.brighttv.viewership AS A
INNER JOIN casestudy2.brighttv.userprofiles AS B
ON A.userid = B.userid
LIMIT 50;

-----------------------------------------------------------------------------------------------
SELECT A.channel2,
       A.recorddate2,
       A.duration2,
       B.gender,
       B.age,
       B.province,
       --Extracting the Time from the timestamp and converting it from UTC to SA time
       TIME(DATEADD(hour,2, TO_TIMESTAMP(recorddate2,'YYYY/MM/DD HH24:MI'))) AS Time,
       --Extracting the Date from the timestamp
       DATE(TO_TIMESTAMP(recorddate2,'YYYY/MM/DD HH24:MI')) AS Date,
       --Extracting the Month name
       TO_CHAR(TO_TIMESTAMP(recorddate2, 'YYYY/MM/DD HH24:MI'), 'Mon') AS Month_Name,
       --Extracting the Day Name
       TO_CHAR(TO_TIMESTAMP(recorddate2, 'YYYY/MM/DD HH24:MI'), 'Dy') AS Day_Name,
       
       --Checking the different type of durations
       CASE
            WHEN duration2 BETWEEN '00:00:00' AND '00:29:59' THEN 'Short Duration'
            WHEN duration2 BETWEEN '00:30:00' AND '00:59:59' THEN 'Medium Duration'
            WHEN duration2 > '01:00:00' THEN 'Long Duration'
            END AS Type_Duration,
            
        -- Categorizing the different Age Groups
        CASE 
            WHEN age <=12 THEN 'Child'
            WHEN age BETWEEN 13 AND 19 THEN 'Teenager'
            WHEN age BETWEEN 20 AND 29 THEN 'Young Adult'
            WHEN age BETWEEN 30 AND 39 THEN 'Old Adult'
            WHEN age BETWEEN 40 AND 49 THEN 'Senior Adult'
            ELSE 'Senior Citizen'
            END AS Age_Group_Classification,
        --Counting the Distinct number of viewers
        COUNT(DISTINCT A.userid) AS Number_Of_Viewership_Stats
        
FROM casestudy2.brighttv.viewership AS A
INNER JOIN casestudy2.brighttv.userprofiles AS B
ON A.userid = B.userid
GROUP BY ALL;
