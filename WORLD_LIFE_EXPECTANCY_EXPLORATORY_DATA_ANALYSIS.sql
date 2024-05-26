# Data Exploratory Analysis Project

USE world_life_expectancy;

SELECT * FROM World_Life_Expectancy;

SELECT Country, MIN(Lifeexpectancy),  MAX(Lifeexpectancy),
ROUND(MAX(Lifeexpectancy) - MIN(Lifeexpectancy), 1) AS Life_Increase_15_Years
FROM World_Life_Expectancy
GROUP BY Country
HAVING  MIN(Lifeexpectancy) <> 0
AND MAX(Lifeexpectancy) <> 0
ORDER BY Life_Increase_15_Years ASC
;


SELECT Year, ROUND(AVG(Lifeexpectancy),2)
FROM World_Life_Expectancy
WHERE  Lifeexpectancy <> 0
AND Lifeexpectancy <> 0
GROUP BY Year
ORDER BY Year
;


SELECT *
FROM World_Life_Expectancy
;

SELECT Country, ROUND(AVG(Lifeexpectancy),1) AS Life_Exp, ROUND(AVG(GDP),1) AS GDP
FROM World_Life_Expectancy
GROUP BY Country
HAVING Life_Exp > 0
AND GDP > 0
ORDER BY GDP DESC
;


SELECT
SUM(CASE WHEN GDP >= 1500 THEN 1 ELSE 0 END) HIGH_GDP_COUNT,
AVG(CASE WHEN GDP >= 1500 THEN Lifeexpectancy ELSE NULL END) HIGH_GDP_LIFE_EXPECTANCY,
SUM(CASE WHEN GDP <= 1500 THEN 1 ELSE 0 END) LOW_GDP_COUNT,
AVG(CASE WHEN GDP <= 1500 THEN Lifeexpectancy ELSE NULL END) LOW_GDP_LIFE_EXPECTANCY

FROM World_Life_Expectancy
;


SELECT Status, ROUND(AVG(Lifeexpectancy),1)
FROM World_Life_Expectancy
GROUP BY Status
;



SELECT Status, COUNT(DISTINCT Country)
FROM World_Life_Expectancy
GROUP BY Status
;



SELECT Country, ROUND(AVG(Lifeexpectancy),1) AS Life_Exp, ROUND(AVG(BMI),1) AS BMI
FROM World_Life_Expectancy
GROUP BY Country
HAVING Life_Exp > 0
AND BMI > 0
ORDER BY BMI DESC
;



SELECT *
FROM World_Life_Expectancy
;




SELECT Country, 
Year, 
Lifeexpectancy, 
AdultMortality, 
SUM(AdultMortality) OVER(PARTITION BY Country ORDER BY Year) AS Rolling_Total
FROM World_Life_Expectancy
WHERE Country LIKE '%United%'
;

