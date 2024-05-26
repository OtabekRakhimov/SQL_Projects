#Data Cleaning Project

SELECT * FROM World_Life_Expectancy;

# Find and Remove the Duplicates
SELECT Country, Year, CONCAT(Country, Year), Count(CONCAT(Country, Year))
FROM World_Life_Expectancy
group by Country, Year, CONCAT(Country, Year)
having Count(CONCAT(Country, Year)) > 1
;

SELECT *
FROM (
      Select Row_ID, 
      CONCAT(Country, Year), 
      row_number() Over(partition by CONCAT(Country, Year) order by CONCAT(Country, Year)) as Row_Num
      FROM World_Life_Expectancy
      ) as Row_table
where Row_Num > 1
;


SET SQL_SAFE_UPDATES = 0;


DELETE FROM World_Life_Expectancy
WHERE 
     Row_ID IN (
     SELECT Row_ID
FROM (
      Select Row_ID, 
      CONCAT(Country, Year), 
      row_number() Over(partition by CONCAT(Country, Year) order by CONCAT(Country, Year)) as Row_Num
      FROM World_Life_Expectancy
      ) as Row_table
where Row_Num > 1
     )
     ;
     
    #Find the missing data and fulfill
    SELECT * 
     FROM World_Life_Expectancy
     WHERE Status = '' 
     ;
     
	 SELECT DISTINCT(Status) 
     FROM World_Life_Expectancy
     WHERE Status <> '' 
     ;
     
	 SELECT DISTINCT(Country) 
     FROM World_Life_Expectancy
     WHERE Status = 'Developing' 
     ;
     
     UPDATE World_Life_Expectancy t1
     JOIN World_Life_Expectancy t2
      ON t1.Country = t2.Country
     SET t1.Status = 'Developing'
     WHERE t1.Status = ''
     AND t2.Status <> ''
     AND t2.Status = 'Developing'
     ;
     
     
     UPDATE World_Life_Expectancy t1
     JOIN World_Life_Expectancy t2
      ON t1.Country = t2.Country
     SET t1.Status = 'Developed'
     WHERE t1.Status = ''
     AND t2.Status <> ''
     AND t2.Status = 'Developed'
     ;
     
	
    
    SELECT t1.Country, t1.Year, t1.Lifeexpectancy, 
			t2.Country, t2.Year, t2.Lifeexpectancy,
			t3.Country, t3.Year, t3.Lifeexpectancy,
            ROUND((t2.Lifeexpectancy + t3.Lifeexpectancy)/2,1)
     FROM World_Life_Expectancy t1
     JOIN World_Life_Expectancy t2
       ON t1.Country = t2.Country
       AND  t1.Year = t2.Year - 1
     JOIN World_Life_Expectancy t3
       ON t1.Country = t3.Country
       AND  t1.Year = t3.Year + 1 
	WHERE t1.Lifeexpectancy = ''
     ;
     
     UPDATE World_Life_Expectancy t1
     JOIN World_Life_Expectancy t2
       ON t1.Country = t2.Country
       AND  t1.Year = t2.Year - 1
     JOIN World_Life_Expectancy t3
       ON t1.Country = t3.Country
       AND  t1.Year = t3.Year + 1
     SET t1.Lifeexpectancy = ROUND((t2.Lifeexpectancy + t3.Lifeexpectancy)/2,1) 
     WHERE t1.Lifeexpectancy = ''
     ;
     
     SELECT *
     FROM World_Life_Expectancy
     #WHERE Lifeexpectancy = ''
     ;
      