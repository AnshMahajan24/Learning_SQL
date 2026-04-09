-- find % contri of each products sales to total sales in sales orders table
select orderid,
productid,
orderdate,
sales,
sum(sales) over() totalsales,
round(cast(sales as float)/ sum(sales) over() * 100, 2) order_contribution_in_sales,
round(cast((sum(sales) over(partition by productid)) as float)/ sum(sales) over() * 100, 2) product_contribution_in_sales
from sales.orders

select productid,
round(cast(sum(sales) as float) / sum(sum(sales)) over() *100 , 2)
from sales.orders group by productid

-- list all the orders where sales are hight=er than the avg sales across all the orders
select * from(
	select orderid,productid,orderdate,sales,
	avg(sales) over() averagesale
	from sales.orders
) alias_required
where sales > averagesale
-- or
SELECT *
FROM sales.orders
WHERE sales > (SELECT AVG(sales) FROM sales.orders);


 -- calculate the moving avg of sales for each product over time
 select orderid,productid,orderdate,sales,
 avg(sales) over(partition by productid order by orderdate) movingavg
 from sales.orders

 -- calculate the moving avg of sales for each product over time including only the next order
 select orderid,productid,orderdate,sales,
 avg(sales) over(partition by productid order by orderdate rows between current row and 1 following) movingavg
 from sales.orders

 -- deviation from each sales from min and max sale overall
 select orderid,productid,orderdate,sales,
 min(sales) over() minsale,
 max(sales) over() maxsale,
 sales - min(sales) over() deviation_from_min,
 max(sales) over() - sales deviation_from_min
 from sales.orders