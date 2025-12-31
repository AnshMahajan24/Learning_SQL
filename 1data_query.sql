-- use MyDatabase
SELECT *
FROM CUSTOMERS

select 
	first_name,
	SCORE,
	score 
from customers

SELECT *
FROM customers 
WHERE score != 0 AND country = 'Germany'

SELECT first_name,score
from customers
ORDER BY score DESC

SELECT first_name,score,country
from customers
ORDER BY country ASC, score DESC      -- priority given to country here for sorting and then to the score if any duplicates present in the country


/* find avg score for each country considering only customers 
with a score not equal to 0 and return only those countries with average score greater than 430 */

--as a hack we can use where condn for score not eual to 0 as there no agrregation function is required and in the other the aggreg is req
-- go step by step like first query all required col and full data once then include where and run and then group by then having and then check full quesry
SELECT    -- 5
COUNT(id) AS total_count,
country,
AVG(score) AS total_score
FROM customers   -- 1
WHERE score != 0 -- 2
GROUP BY country    -- 3
HAVING AVG(score)>430   --4

SELECT COUNTRY, SCORE,COUNT(ID)
from CUSTOMERS
GROUP BY COUNTRY,SCORE
HAVING COUNTRY='USA' AND SCORE=900  -- WE GROUP BY THESE 2 COL ARE WE CAN USE THESE TWO INDEPENDENTLY IN HAVING

SELECT DISTINCT country
FROM CUSTOMERS

-- retrieve top 3  customers based on the score
SELECT TOP 3 *     --3
FROM customers  --1 
ORDER BY score DESC   --2

-- retrieve lowest 2 customers based on the score
SELECT TOP 2 *
FROM customers
ORDER BY score ASC;

--get 2 most recent orders
SELECT TOP 2 *
FROM orders
ORDER BY order_date DESC;

SELECT first_name,'hello' AS message
FROM customers