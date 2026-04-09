-- using format function
select orderid, 
creationtime,
'Day '+FORMAT(creationtime, 'ddd MMM')+' Q'
+DATENAME(QUARTER, CREATIONTIME)+' '+FORMAT(CREATIONTIME,'yyyy hh:mm:ss tt') AS [CUSTOM CREATION TIME]
from sales.orders




/* handling null before applying any aggregate function */
SELECT Customerid,
score,
COALESCE(Score,0) as updated_score, 
AVG(COALESCE(Score,0)) over(),
AVG(Score) over()
FROM Sales.CUSTOMERS

/* handling null before applying any mathematical operation on it */
select firstname+lastname as fullNameBefore,
firstname+(isnull(lastname,'')) as firstNameAfter,
score + 10 as score_before,
isnull(score,0)+10 as score_after
from sales.customers

-- 