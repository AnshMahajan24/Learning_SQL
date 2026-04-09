-- find the total sales across all the orders
SELECT SUM(SALES)FROM SALES.Orders  
-- find the total sales across all the orders
SELECT SUM(SALES),ORDERID FROM SALES.Orders   -- ERROR
SELECT SUM(SALES) OVER(),ORDERID,ORDERDATE FROM SALES.Orders

-- find the total sales FOR EACH PRODUCT
SELECT PRODUCTID, SUM(SALES) TOTAL_SALES FROM SALES.Orders GROUP BY PRODUCTID
-- we cant do aggregations and provide details at the same time using group by


-- find the total sales FOR EACH PRODUCT additionally provide details such as order id and order date
SELECT PRODUCTID, ORDERID
,SUM(SALES) OVER(PARTITION BY PRODUCTID) TOTAL_SALESBYPRODUCT
,ORDERDATE
FROM SALES.ORDERS
-- THE full OUTPUT IS BY DEFAULT SORTED BY THE COL USED FOR PARTITIONING HERE (PRODUCTID)

-- ALLOWS AGGREGATION OF DATA AT DIFFERENT GRANULARITIES WITHIN THE SAME QUERY
SELECT PRODUCTID, ORDERID,SALES,
SUM(SALES) OVER() AS TOTALSALES,
SUM(SALES) OVER(PARTITION BY PRODUCTID) TOTAL_SALESBYPRODUCT,
SUM(SALES) OVER(PARTITION BY PRODUCTID,ORDERSTATUS) TOTAL_SALESBYPRODUCT_ANDSTATUS,
ORDERSTATUS, ORDERDATE
FROM SALES.ORDERS
-- THE final OUTPUT IS BY DEFAULT SORTED BY THE COL USED FOR PARTITIONING HERE (PRODUCTID) AND THEN ORDERSTATUS AS SECONDARY SORT
-- to order the data winthin the window we use order by inside the over clause of window  

-- frame
select orderid,orderdate,sales,orderstatus,
sum(sales) over(partition by orderstatus order by orderdate rows between current row and 2 following)
from sales.orders

-- for only preceding(n preceding and unbponded preceding as well) , the current row can be skipped in writing
select orderid,orderdate,sales,orderstatus,
sum(sales) over(partition by orderstatus order by orderdate rows between 2 preceding and current row),
sum(sales) over(partition by orderstatus order by orderdate rows 2 preceding) -- same o/p as of above window funcn
from sales.orders

-- sql uses default frame, if order by is used without frame in window function
select orderid,orderdate,sales,orderstatus,
sum(sales) over(partition by orderstatus order by orderdate), -- default frame = rows bw unbounded preceding and current row
sum(sales) over(partition by orderstatus order by orderdate rows unbounded preceding)
from sales.orders

-- rank the customers based on their total sales (first do grouping and then ranking using windiow funxtion) this applies to all the quesries that can be solved using group by and window

-- we can use both group by and window function in the same query but
-- using anything inside the window function should be part of the group by
select
	customerid, 
	sum(sales) as sale_per_customer,
	rank() over(order by sum(sales) desc) as [rank]
from sales.orders group by customerid