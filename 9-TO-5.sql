/*
SELECT data_type_code 
FROM LaborStatisticsDB.dbo.datatype
WHERE data_type_text = 'women employees';

SELECT data_type_text
FROM LaborStatisticsDB.dbo.datatype
WHERE data_type_text = 'women employees';

SELECT *
FROM LaborStatisticsDB.dbo.series AS s 
JOIN LaborStatisticsDB.dbo.industry AS i 
ON s.industry_code = i.industry_code
JOIN LaborStatisticsDB.dbo.supersector AS su 
ON s.supersector_code=su.supersector_code
WHERE series_title LIKE 'Women employees' AND industry_name LIKE 'commercial banking' 
    AND  supersector_name LIKE 'financial activities';

SELECT round(sum(value), 0) AS 'number of employees 2016'
FROM  LaborStatisticsDB.dbo.annual_2016 AS a
JOIN LaborStatisticsDB.dbo.series AS s
ON a.series_id = s.series_id
WHERE s.series_title = 'All employees';

SELECT round(sum(value), 0) AS 'women employees 2016'
FROM  LaborStatisticsDB.dbo.annual_2016 AS a
JOIN LaborStatisticsDB.dbo.series AS s
ON a.series_id = s.series_id
WHERE s.series_title = 'women employees';
     
SELECT round(sum(value), 0) AS ' num production/nonsupervisory employees 2016'
FROM  LaborStatisticsDB.dbo.annual_2016 AS a
JOIN LaborStatisticsDB.dbo.series AS s
ON a.series_id = s.series_id
WHERE s.series_title = 'production and nonsupervisory employees';
     
SELECT AVG(j.value) AS 'Average weekly hrs'
FROM LaborStatisticsDB.dbo.january_2017 AS j 
JOIN LaborStatisticsDB.dbo.series AS s  
ON j.series_id = s.series_id
WHERE s.series_title = 'Average weekly hours of production and nonsupervisory employees';

SELECT ROUND(SUM(j17.value), 2) AS 'Total weekly payrolls'
FROM LaborStatisticsDB.dbo.january_2017 AS j17 
JOIN LaborStatisticsDB.dbo.series AS s  
ON j17.series_id = s.series_id
WHERE s.series_title = 'Average weekly earnings of production and nonsupervisory employees';
     
SELECT  TOP 1 i.industry_name, Min(j17.value) AS 'lowest'
FROM LaborStatisticsDB.dbo.industry AS i 
JOIN LaborStatisticsDB.dbo.series AS s 
ON i.industry_code= s.industry_code
JOIN LaborStatisticsDB.dbo.january_2017 AS j17
ON s.series_id= j17.series_id
WHERE s.series_title LIKE 'Average weekly hours of production and nonsupervisory employees' 
GROUP by industry_name
order by lowest ASC;



SELECT  TOP 1 i.industry_name, MAX(j17.value) AS  'highest'
FROM LaborStatisticsDB.dbo.industry AS  i 
JOIN LaborStatisticsDB.dbo.series AS  s 
ON i.industry_code= s.industry_code
JOIN LaborStatisticsDB.dbo.january_2017 AS  j17
ON s.series_id= j17.series_id
WHERE s.series_title LIKE 'Average weekly earnings of production and nonsupervisory employees' 
GROUP BY industry_name
ORDER BY highest DESC;

SELECT  TOP 1 i.industry_name, MIN(j17.value) AS 'lowest'
FROM LaborStatisticsDB.dbo.industry AS i 
JOIN LaborStatisticsDB.dbo.series AS s 
ON i.industry_code= s.industry_code
JOIN LaborStatisticsDB.dbo.january_2017 AS j17
ON s.series_id= j17.series_id
WHERE s.series_title LIKE 'Average weekly earnings of production and nonsupervisory employees' 
GROUP BY industry_name
ORDER BY lowest ASC;



SELECT TOP 50 *
FROM LaborStatisticsDB.dbo.annual_2016 as a 
LEFT JOIN  LaborStatisticsDB.dbo.series as s
ON a.series_id= s.series_id
ORDER BY id;

SELECT TOP 50 *
FROM LaborStatisticsDB.dbo.series as s
JOIN LaborStatisticsDB.dbo.datatype as d
ON s.data_type_code=d.data_type_code

SELECT top 50 *
FROM LaborStatisticsDB.dbo.series as s
JOIN LaborStatisticsDB.dbo.industry as i
ON s.industry_code=i.industry_code
ORDER BY id

SELECT   j17.series_id,  i.industry_code, i.industry_name,j17.value
FROM LaborStatisticsDB.dbo.january_2017 as j17
JOIN LaborStatisticsDB.dbo.series as s 
ON j17.series_id= s.series_id
JOIN LaborStatisticsDB.dbo.industry as i 
ON s.industry_code= i.industry_code
WHERE j17.value >
   ( SELECT AVG(a16.value) 
    FROM LaborStatisticsDB.dbo.annual_2016 as a16 
    JOIN LaborStatisticsDB.dbo.series as s 
    ON a16.series_id = s.series_id
    WHERE s.data_type_code = '82')
*/

SELECT  j17.series_id,  i.industry_code, i.industry_name,j17.value
FROM LaborStatisticsDB.dbo.january_2017 as j17
JOIN LaborStatisticsDB.dbo.series as s 
ON j17.series_id= s.series_id
JOIN LaborStatisticsDB.dbo.industry as i 
ON s.industry_code= i.industry_code
WHERE j17.value >
   ( SELECT AVG(a16.value) 
    FROM LaborStatisticsDB.dbo.annual_2016 as a16 
    JOIN LaborStatisticsDB.dbo.series as s 
    ON a16.series_id = s.series_id
    WHERE s.data_type_code = '82');


SELECT ROUND(AVG(a16.value), 2)  AS 'avg weekly earnings',  MAX(a16.year) AS 'year'
from LaborStatisticsDB.dbo.annual_2016 AS a16 
JOIN LaborStatisticsDB.dbo.series AS s 
ON a16.series_id=s.series_id
WHERE s.data_type_code = '30' AND s.series_title = 'Average weekly earnings of production and nonsupervisory employees'
UNION 
SELECT ROUND(AVG(j17.value), 2) AS 'avg weekly earnings', MAX(j17.year) AS 'year'
from LaborStatisticsDB.dbo.january_2017 AS j17 
JOIN LaborStatisticsDB.dbo.series AS s 
ON j17.series_id=s.series_id
WHERE s.data_type_code = '30' AND s.series_title = 'Average weekly earnings of production and nonsupervisory employees';

