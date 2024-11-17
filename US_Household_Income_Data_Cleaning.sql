# US Household Income Data Cleaning

SELECT * 
FROM US_Household.USHouseholdIncome;

SELECT *  
FROM US_Household.ushouseholdincome_statistics;

SELECT COUNT(id) 
FROM US_Household.USHouseholdIncome;

SELECT COUNT(id)  
FROM US_Household.ushouseholdincome_statistics;

 # checking the duplicates for income table

SELECT id, COUNT(id)
FROM US_Household.USHouseholdIncome
GROUP BY id
HAVING COUNT(id) > 1 
;

# removing the duplicates from income table

SELECT *
FROM (
  SELECT row_id, 
  id,
  ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) row_num
  FROM US_Household.USHouseholdIncome
  ) duplicates
WHERE row_num > 1
;

DELETE FROM USHouseholdIncome
WHERE row_id IN (
  SELECT row_id
  FROM (
    SELECT row_id, 
    id,
    ROW_NUMBER() OVER(PARTITION BY id ORDER BY id) row_num
    FROM US_Household.USHouseholdIncome
    ) duplicates
  WHERE row_num > 1)
  ;
  
  # checking and fixing spelling errors
  
  SELECT DISTINCT State_name
  FROM US_Household.USHouseholdIncome;
  
 SET SQL_SAFE_UPDATES = 0;
 
UPDATE US_Household.USHouseholdIncome
SET State_name = 'Georgia'
WHERE State_name = 'georia';

SELECT Type, COUNT(Type)
FROM US_Household.USHouseholdIncome
GROUP BY Type
;

UPDATE USHouseholdIncome
SET Type = 'Borough'
WHERE Type = 'Boroughs';

# checking and filling the missing values

SELECT *
FROM US_Household.USHouseholdIncome
WHERE County = 'Autauga County'
ORDER BY 1
;

UPDATE USHouseholdIncome
SET Place = 'Autaugaville'
WHERE County = 'Autauga County'
AND City = 'Vinemont';

SELECT  ALand, AWater
FROM US_Household.USHouseholdIncome
WHERE AWater = 0 ;

SELECT  ALand, AWater
FROM US_Household.USHouseholdIncome
WHERE ALand = 0 ;

SELECT  DISTINCT ALand
FROM US_Household.USHouseholdIncome
WHERE (ALand = 0 OR ALand = '' OR ALand IS NULL);

SELECT  DISTINCT AWater
FROM US_Household.USHouseholdIncome
WHERE (AWater = 0 OR AWater = '' OR AWater IS NULL);

