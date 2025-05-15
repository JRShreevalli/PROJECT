use ndap;

desc FarmersInsuranceData ;

-- ----------------------------------------------------------------------------------------------
-- SECTION 1. 
-- SELECT Queries [5 Marks]

-- 	Q1.	Retrieve the names of all states (srcStateName) from the dataset.
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
-- <write your answers in the empty spaces given, the length of solution queries (and the solution writing space) can vary>

SELECT DISTINCT srcStateName 
FROM FarmersInsuranceData
ORDER BY srcStateName ASC ;

-- 	Q2.	Retrieve the total number of farmers covered (TotalFarmersCovered) 
-- 		and the sum insured (SumInsured) for each state (srcStateName), ordered by TotalFarmersCovered in descending order.
-- ###
-- 	[3 Marks]
-- ###
-- TYPE YOUR CODE BELOW >

SELECT 
    srcStateName,
    SUM(TotalFarmersCovered) AS TotalFarmersCovered,
    SUM(SumInsured) AS TotalSumInsured
FROM FarmersInsuranceData
GROUP BY srcStateName
ORDER BY TotalFarmersCovered DESC;
-- Insight : Compared to other states, Madhya Pradesh has the highest number farmers covered.
-- Insight : 'MAHARASHTRA' has second highest farmers covered in it's entire state.
-- Insight : 'Punjab' covers lowest number of farmers in entire country.

-- --------------------------------------------------------------------------------------
-- SECTION 2. 
-- Filtering Data (WHERE) [15 Marks]

-- 	Q3.	Retrieve all records where Year is '2020'.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >

SELECT * FROM FarmersInsuranceData
WHERE Year_ = 'Calendar Year (Jan - Dec), 2020';  
-- Insight : Over 235 rows data is covered with Year 2020. 

-- 	Q4.	Retrieve all rows where the TotalPopulationRural is greater than 1 million and the srcStateName is 'HIMACHAL PRADESH'.
-- ###
-- 	[3 Marks]
-- ###
-- TYPE YOUR CODE BELOW >

SELECT * FROM FarmersInsuranceData
WHERE TotalPopulationRural > 1000000
AND srcStateName = 'HIMACHAL PRADESH';
-- Insight : 'Kangra' district from 'HIMACHAL PRADESH' has Total Population Rural greater than 1 million starting from
--            Year 2018 to 2021.

-- 	Q5.	Retrieve the srcStateName, srcDistrictName, and the sum of FarmersPremiumAmount for each district in the year 2018, 
-- 		and display the results ordered by FarmersPremiumAmount in ascending order.
-- ###
-- 	[5 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT srcStateName,
       srcDistrictName,
       SUM(FarmersPremiumAmount) AS TotalFarmersPremium
FROM FarmersInsuranceData
WHERE Year_ = 'Calendar Year (Jan - Dec), 2018'  
GROUP BY srcStateName, srcDistrictName
ORDER BY TotalFarmersPremium ASC;
-- Insight : Total Premium Amount is great for Ujain district of Madhya Pradesh state. Amount is about 3273.090087890625.
-- Insight : Total Premium Amount is 2nd greatest for Hugli district of West Bengal state. Amount is about 2777.030029296875.
-- Insight : Karnataka state has mostly 0's for Total Farmers Premium Amount. 
--           But few districts i.e Davangere, Kolar, Mandya and Hasan has little bit of Farmers Premium Amount which is 
--           greater the 0 but less than 1. 

-- 	Q6.	Retrieve the total number of farmers covered (TotalFarmersCovered) and the sum of premiums (GrossPremiumAmountToBePaid) for each state (srcStateName) 
-- 		where the insured land area (InsuredLandArea) is greater than 5.0 and the Year is 2018.
-- ###
-- 	[5 Marks]
-- ###
-- TYPE YOUR CODE BELOW >

SELECT srcStateName,
       SUM(TotalFarmersCovered) AS TotalFarmersCovered,
       SUM(GrossPremiumAmountToBePaid) AS TotalPremium
FROM FarmersInsuranceData
WHERE InsuredLandArea > 5.0 AND Year_ = 'Calendar Year (Jan - Dec), 2018' 
GROUP BY srcStateName;
-- Insight : In 2018, 16 Indian states recorded insured land areas exceeding 5.0.

-- ------------------------------------------------------------------------------------------------

-- SECTION 3.
-- Aggregation (GROUP BY) [10 marks]
-- 	Q7. Calculate the average insured land area (InsuredLandArea) for each year (srcYear).
-- ###
-- 	[3 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT srcYear,
       AVG(InsuredLandArea) AS AverageInsuredLandArea
FROM FarmersInsuranceData
GROUP BY srcYear
ORDER BY srcYear;
-- Insight : Highest Average Insured land area is observerd in year 2020. 
-- Insight : Lowest Average Insured land area is observed in year 2018. 

-- 	Q8.Calculate the total number of farmers covered (TotalFarmersCovered) for each district (srcDistrictName) where Insurance units is greater than 0.
-- ###
-- 	[3 Marks]
-- ###
-- TYPE YOUR CODE BELOW >

SELECT srcDistrictName,
       SUM(TotalFarmersCovered) AS TotalFarmersCovered
FROM FarmersInsuranceData
WHERE InsuranceUnits > 0
GROUP BY srcDistrictName
ORDER BY TotalFarmersCovered DESC;
-- Insight :Bid district of Maharashtra has count of Total Farmer covered highest i.e 1430532 where insurance units 
-- are greater than 0.
-- Insight : Latur district of Maharashtra has the second highest count of Total Farmer covered i.e 1184066 
-- where insurance units are greater than 0.
-- Insight : Kodagu and DakshinaKannada are the districts where Total Farmers covered is 0. 
-- In these two districts only farmers covered is lowest i.e almost negligable even though Insurance units are greater than 0.

-- 	Q9.For each state (srcStateName), calculate the total premium amounts (FarmersPremiumAmount, StatePremiumAmount, GOVPremiumAmount) 
-- 	   and the total number of farmers covered (TotalFarmersCovered). Only include records where the sum insured 
--     (SumInsured) is greater than 500,000 (remember to check for scaling).
-- ###
-- 	[4 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT srcStateName,
       SUM(FarmersPremiumAmount) AS TotalFarmersPremium,
       SUM(StatePremiumAmount) AS TotalStatePremium,
       SUM(GOVPremiumAmount) AS TotalGovPremium,
       SUM(TotalFarmersCovered) AS TotalFarmersCovered
FROM FarmersInsuranceData
WHERE SumInsured > 5
GROUP BY srcStateName
ORDER BY srcStateName;


-- -------------------------------------------------------------------------------------------------
-- SECTION 4.
-- Sorting Data (ORDER BY) [10 Marks]

-- 	Q10.Retrieve the top 5 districts (srcDistrictName) with the highest TotalPopulation in the year 2020.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >

SELECT srcDistrictName,
       TotalPopulation
FROM FarmersInsuranceData
WHERE Year_ = 'Calendar Year (Jan - Dec), 2020'
ORDER BY TotalPopulation DESC
LIMIT 5;
-- Insight : Highest Population is observed in Thane district of Maharashtra for the Yaer 2020. 
-- Insight : Second Highest Population is observed in Jaipur district of Rajasthan for the Yaer 2020.

-- 	Q11.Retrieve the srcStateName, srcDistrictName, and SumInsured for the 10 districts with the lowest non-zero FarmersPremiumAmount, 
-- 		ordered by insured sum and then the FarmersPremiumAmount.
-- ###
-- 	[3 Marks]
-- ###
-- TYPE YOUR CODE BELOW >

SELECT srcStateName, srcDistrictName, SumInsured, FarmersPremiumAmount
FROM FarmersInsuranceData
WHERE FarmersPremiumAmount > 0
ORDER BY SumInsured ASC, FarmersPremiumAmount ASC
LIMIT 10;
-- Insight : When data is grouped with srcStateName, srcDistrictName, SumInsured, FarmersPremiumAmount then
--           Karnataka state has minimum Farmer's Premium Amount of 0.0002 and 0.0003.
-- Insight : Also Uttar Pradesh has 0.0003 as Farmer's Premium Amount which is almost equal to Karnataka Farmer's 
--           Premium amount of 0.0003.

-- 	Q12. Retrieve the top 3 states (srcStateName) along with the year (srcYear) where the ratio of insured farmers (TotalFarmersCovered) to the total population (TotalPopulation) is highest. 
-- 		Sort the results by the ratio in descending order.
-- ###
-- 	[5 Marks]
-- ###
-- TYPE YOUR CODE BELOW >

SELECT srcStateName,
       srcYear,
       SUM(TotalFarmersCovered) AS TotalFarmersCovered,
       SUM(TotalPopulation) AS TotalPopulation,
       (SUM(TotalFarmersCovered) / SUM(TotalPopulation)) AS CoverageRatio
FROM FarmersInsuranceData
WHERE TotalPopulation > 0  -- avoid division by zero
GROUP BY srcStateName, srcYear
ORDER BY CoverageRatio DESC
LIMIT 3;
-- Insight : Coverage Ratio is nothing but how well Total population is covered for that particular state with respect to farmers in that state.
-- Insight : CHHATTISGARH has very good coverage ratio for it's entire state and stays first in Coverage ratio for year 2020.
-- Insight : TRIPURA stays 2nd and 3rd in coverage ratio for years 2020 and 2021 with good coverage ratio.

-- -------------------------------------------------------------------------------------------------

-- SECTION 5.
-- String Functions [6 Marks]

-- 	Q13. Create StateShortName by retrieving the first 3 characters of the srcStateName for each unique state.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >

SELECT DISTINCT srcStateName, LEFT(srcStateName, 3) AS StateShortName
FROM FarmersInsuranceData;

-- 	Q14. Retrieve the srcDistrictName where the district name starts with 'B'.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >

SELECT DISTINCT srcDistrictName
FROM FarmersInsuranceData
WHERE srcDistrictName LIKE 'B%';
-- Insight : There are a total of 60 District's which start with 'B'.

-- 	Q15. Retrieve the srcStateName and srcDistrictName where the district name contains the word 'pur' at the end.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >

SELECT srcStateName, srcDistrictName
FROM FarmersInsuranceData
WHERE srcDistrictName LIKE '%pur';
-- Insight : 193 district names end with 'pur' in entire India. 
-- -------------------------------------------------------------------------------------------------

-- SECTION 6.
-- Joins [14 Marks]
-- 	Q16.Perform an INNER JOIN between the srcStateName and srcDistrictName columns to retrieve the aggregated 
--      FarmersPremiumAmount for districts where the district’s Insurance units for an individual year are greater than 10.
-- ###
-- 	[4 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT a.srcStateName, 
       a.srcDistrictName, 
       SUM(a.FarmersPremiumAmount) AS total_FarmersPremiumAmount 
FROM FarmersInsuranceData a
INNER JOIN FarmersInsuranceData b 
ON (a.srcStateName = b.srcStateName) AND (a.srcDistrictName = b.srcDistrictName)
WHERE b.InsuranceUnits > 10
GROUP BY a.srcStateName, a.srcDistrictName;

-- 	Q17.Write a query that retrieves srcStateName, srcDistrictName, Year, TotalPopulation for each district and 
-- the the highest recorded FarmersPremiumAmount for that district over all available years
-- 	Return only those districts where the highest FarmersPremiumAmount exceeds 20 crores.
-- ###
-- 	[5 Marks]
-- ###
-- TYPE YOUR CODE BELOW >

SELECT f.srcStateName,
       f.srcDistrictName,
       f.Year_,
       f.TotalPopulation,
       MAX(f.FarmersPremiumAmount) AS HighestFarmersPremium
FROM FarmersInsuranceData f
GROUP BY f.srcStateName,
         f.srcDistrictName,
         f.Year_,
         f.TotalPopulation
HAVING MAX(f.FarmersPremiumAmount) > (200000000/100000)
ORDER BY HighestFarmersPremium DESC;
-- Insight : Maharashtra's district namely 'Bid' has the highest FarmersPremiumAmount which exceeds 20 crores.

-- 	Q18.Perform a LEFT JOIN to combine the total population statistics with the farmers’ data (TotalFarmersCovered, SumInsured) 
--      for each district and state.Return the total premium amount (FarmersPremiumAmount) and the average population count 
--      for each district aggregated over the years, where the total FarmersPremiumAmount is greater than 100 crores.
-- 		Sort the results by total farmers' premium amount, highest first.
-- ###
-- 	[5 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SELECT a.srcStateName,
       a.srcDistrictName,
       SUM(a.FarmersPremiumAmount) AS TotalFarmersPremium,
       AVG(b.TotalPopulation) AS AveragePopulation
FROM FarmersInsuranceData a
LEFT JOIN FarmersInsuranceData b 
ON (a.srcStateName = b.srcStateName) AND (a.srcDistrictName = b.srcDistrictName)
GROUP BY a.srcStateName, a.srcDistrictName
HAVING SUM(a.FarmersPremiumAmount) > (100000000/100000) 
ORDER BY TotalFarmersPremium DESC; 
-- Insight : Average population of Maharashtra's Bid district is highest when Farmer's Premium amount is greater than 100 Crores.
-- Insight : Average population of Haryana's Mewat district is lowest when Farmer's Premium amount is greater than 100 Crores.
-- -------------------------------------------------------------------------------------------------

-- SECTION 7.
-- Subqueries [10 Marks]

-- 	Q19.Write a query to find the districts (srcDistrictName) where the TotalFarmersCovered is greater than the 
--      average TotalFarmersCovered across all records.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >

SELECT srcDistrictName,
       TotalFarmersCovered
FROM FarmersInsuranceData
WHERE TotalFarmersCovered > (
	  SELECT AVG(TotalFarmersCovered)
	  FROM FarmersInsuranceData
    );

-- 	Q20.Write a query to find the srcStateName where the SumInsured is higher than the SumInsured of the district with the highest FarmersPremiumAmount.
-- ###
-- 	[3 Marks]
-- ###
-- TYPE YOUR CODE BELOW >

SELECT srcStateName,
       SumInsured
FROM FarmersInsuranceData
WHERE SumInsured >= 
(
        SELECT MAX(SumInsured)
        FROM FarmersInsuranceData
        WHERE FarmersPremiumAmount = 
	     (
                SELECT MAX(FarmersPremiumAmount)
                FROM FarmersInsuranceData
            )
    );
-- Insight : Maharashtra has the highest SumInsured amount with the highest FarmersPremiumAmount.

-- 	Q21.Write a query to find the srcDistrictName where the FarmersPremiumAmount is higher than the average 
--      FarmersPremiumAmount of the state that has the highest TotalPopulation.
-- ###
-- 	[5 Marks]
-- ###
-- TYPE YOUR CODE BELOW >

SELECT srcDistrictName,
       srcStateName,
       FarmersPremiumAmount
FROM FarmersInsuranceData
WHERE FarmersPremiumAmount > 
(
        SELECT AVG(FarmersPremiumAmount)
        FROM FarmersInsuranceData
        WHERE srcStateName = 
        (
            SELECT srcStateName
            FROM FarmersInsuranceData
            GROUP BY srcStateName
            ORDER BY SUM(TotalPopulation) DESC
            LIMIT 1
        )
    )
AND srcStateName = 
(
    SELECT srcStateName
    FROM FarmersInsuranceData
    GROUP BY srcStateName
    ORDER BY SUM(TotalPopulation) DESC
    LIMIT 1
);
-- Insight : Agra district from Uttar Pradesh has the maximum Farmer's Premium Amount which is higher than the average 
--           FarmersPremiumAmount of the state that has the highest TotalPopulation.
-- -------------------------------------------------------------------------------------------------

-- SECTION 8.
-- Advanced SQL Functions (Window Functions) [10 Marks]

-- 	Q22.Use the ROW_NUMBER() function to assign a row number to each record in the dataset ordered by total farmers covered 
--      in descending order.
-- ###
-- 	[3 Marks]
-- ###
-- TYPE YOUR CODE BELOW >

SELECT 
    ROW_NUMBER() OVER (ORDER BY TotalFarmersCovered DESC) AS RowNum,
    srcStateName,
    srcDistrictName,
    srcYear,
    TotalFarmersCovered
FROM FarmersInsuranceData;
-- Rank 1 is given to Bid district present in Maharashtra which has highest TotalFarmersCovered.

-- 	Q23.Use the RANK() function to rank the districts (srcDistrictName) based on the SumInsured (descending) and 
--      partition by alphabetical srcStateName.
-- ###
-- 	[3 Marks]
-- ###
-- TYPE YOUR CODE BELOW >

SELECT 
    srcStateName,
    srcDistrictName,
    SumInsured,
    RANK() OVER (
        PARTITION BY srcStateName 
        ORDER BY SumInsured DESC
    ) AS DistrictRank
FROM 
    FarmersInsuranceData
ORDER BY 
    srcStateName ASC, DistrictRank ASC ; 


-- 	Q24.Use the SUM() window function to calculate a cumulative sum of FarmersPremiumAmount for each district 
--      (srcDistrictName), ordered ascending by the srcYear, partitioned by srcStateName.
-- ###
-- 	[4 Marks]
-- ###
-- TYPE YOUR CODE BELOW >

SELECT srcStateName,
       srcDistrictName,
       srcYear,
       FarmersPremiumAmount,
       SUM(FarmersPremiumAmount) OVER (
	   PARTITION BY srcStateName, srcDistrictName
	   ORDER BY srcYear ASC
	   ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
       ) AS CumulativeFarmersPremium
FROM 
    FarmersInsuranceData
ORDER BY 
    srcStateName, srcDistrictName, srcYear ;

-- -------------------------------------------------------------------------------------------------

-- SECTION 9.
-- Data Integrity (Constraints, Foreign Keys) [4 Marks]

-- 	Q25. Create a table 'districts' with DistrictCode as the primary key and columns for DistrictName and StateCode. 
-- 		Create another table 'states' with StateCode as primary key and column for StateName.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >

-- Create the 'states' table
CREATE TABLE states (
    StateCode INT PRIMARY KEY,
    StateName VARCHAR(255) NOT NULL
);

-- Create the 'districts' table
CREATE TABLE districts (
    DistrictCode INT PRIMARY KEY,
    DistrictName VARCHAR(255) NOT NULL,
    StateCode INT,
    FOREIGN KEY (StateCode) REFERENCES states(StateCode)
);


-- 	Q26.	Add a foreign key constraint to the districts table that references the StateCode column from a states table.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >

ALTER TABLE districts
ADD CONSTRAINT fk_statecode
FOREIGN KEY (StateCode)
REFERENCES states(StateCode);


-- -------------------------------------------------------------------------------------------------

-- SECTION 10.
-- UPDATE and DELETE [6 Marks]

-- 	Q27. Update the FarmersPremiumAmount to 500.0 for the record where rowID is 1.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >

UPDATE FarmersInsuranceData
SET FarmersPremiumAmount = 500.0
WHERE rowID = 1;


-- 	Q28.	Update the Year to '2021' for all records where srcStateName is 'HIMACHAL PRADESH'.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >
SET SQL_SAFE_UPDATES = 0;
UPDATE FarmersInsuranceData
SET Year_ = 'Calendar Year (Jan - Dec), 2021'
WHERE srcStateName = 'HIMACHAL PRADESH'
AND rowID IS NOT NULL; 

-- 	Q29.	Delete all records where the TotalFarmersCovered is less than 10000 and Year is 2020.
-- ###
-- 	[2 Marks]
-- ###
-- TYPE YOUR CODE BELOW >

DELETE FROM FarmersInsuranceData
WHERE TotalFarmersCovered < 10000
AND Year_ = 'Calendar Year (Jan - Dec), 2020'; 