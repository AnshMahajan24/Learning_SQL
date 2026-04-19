-- segment all the orders into 3 categories : high, medium, and low sales
select *,
case when category = 1 then 'high'
	 when category = 2 then 'medium'
	 when category = 3 then 'low'
end [sales segmentation] from (
select
orderid,
sales,
ntile(3) over(order by sales desc) as category
from sales.orders
) t 
select * from sales.Products

-- find the products that fall within the highrst 40% of the prices
select * from (
	select *,
    cume_dist() over(order by price desc) dst
	from sales.products
) t where dst <= 0.4

-- lag and lead value window function use cases -:

-- analyse the month over month performance by finding percentage change in sales bw the current and previous monht
-- month over month analysis
select *, ((curr_month_sale-prev_month_sale)*1.0/prev_month_sale)*100 percentChangeInSale from
(
select month(orderdate) as month, sum(sales) as curr_month_sale,
lag(sum(sales)) over(order by month(orderdate) asc) prev_month_sale
from sales.orders
group by month(orderdate)
) t


-- customer retention analysis
-- rank cutomers based on the avg no. of days bw orders
select customerid,
avg(daysUntillNextOrder) as average,
rank() over(order by coalesce(avg(daysUntillNextOrder), 99999) asc) as ranking
from
(
select
orderid,
customerid,
orderdate as currentOrder,
lead(orderdate) over(partition by customerid order by orderdate asc) nextorder,
datediff(day,orderdate,lead(orderdate) over(partition by customerid order by orderdate asc)) daysUntillNextOrder
from sales.orders
) t
group by customerid


 -- find the lowest and highest sales for each product
 select productid, min(sales) as mini, max(sales) as maxi from sales.orders group by productid

 select orderid,productid,sales,
 first_value(sales) over(partition by productid order by sales asc) as min_sale,
 last_value(sales) over(partition by productid order by sales asc rows between current row and unbounded following) as max_sale,
 first_value(sales) over(partition by productid order by sales desc) as max_sale2,
 min(sales) over(partition by productid) as min_sale2
 from sales.orders
 -- we can use this first and last value value wind function to compare our value to its extremes
 -- to chech how well a value is performin grelative to its extremes, they are similar to min max function