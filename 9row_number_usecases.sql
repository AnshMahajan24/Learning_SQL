-- find the top highest sales for each product (top n analysis)
select productid,max(sales) highest_sale from sales.orders group by productid;
-- or query with detailed info
select * from(
select orderid, productid,orderdate,sales,
row_number() over(partition by productid order by sales desc) as rank
from sales.orders
) t where rank = 1

-- find the lowest 2 customers based on their total sales (bottom n analysis)
select * from(
select customerid,sum(sales) as total_sales,
row_number() over(order by sum(sales)) as rank   -- alias both both the table of subquery and created cols of subquery table is necessary to not see the errors
from sales.orders group by customerid
) t where rank <= 2


--assign unique ids to the rows of the orders archive table (generate unique ids) to generate PK
select 
row_number() over(order by orderid, orderdate) as unique_id,
*
from sales.OrdersArchive

-- (identify duplicates and remove them to improve data quality) to make pk of the table unique (if not already as here)
select * from(
select 
row_number() over(partition by orderid order by creationtime desc) as unique_id,   -- partition the data by the PK of the table to solve this task
*
from sales.OrdersArchive) t where unique_id = 1 -- use unique_id > 1 in place of this if you wanna see duplicate data that is needed to be removed