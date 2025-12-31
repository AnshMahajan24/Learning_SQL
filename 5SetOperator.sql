-- combines the data of employe and customers in one table
use SalesDB
SELECT    -- NO NEED TO SELECT ID AS ID IS NOT UNIQUE fter combining records of the two table so, we ignore it as it doesnt make any diff 
FirstName , LastName FROM sales.Customers
UNION
select FirstName, LastName from sales.Employees
-- the order of the table in query does not matters, the output will be exact same in both the cases



SELECT    
FirstName , LastName FROM sales.Employees   -- all records from 1st and 2nd tables are in the output as it is
UNION ALL
select FirstName, LastName from sales.Customers



-- INSERT INTO SALES.customers (CustomerID, FirstName, LastName) VALUES (8, 'Ansh', 'Mahajan')
SELECT    
FirstName , LastName FROM sales.Employees   -- notice no duplicates are allowed even from first table record that is not there in the 2nd table, similar with union but not in case of union all
EXCEPT
select FirstName, LastName from sales.Customers



SELECT    
FirstName , LastName FROM sales.Employees  
INTERSECT
select FirstName, LastName from sales.Customers


-- combine all orders into one report without any duplcates following best practices
SELECT
       'Orders' AS Src_Table
      ,[OrderID]
      ,[ProductID]
      ,[CustomerID]
      ,[SalesPersonID]
      ,[OrderDate]
      ,[ShipDate]
      ,[OrderStatus]
      ,[ShipAddress]
      ,[BillAddress]
      ,[Quantity]
      ,[Sales]
      ,[CreationTime]
FROM
SALES.Orders
UNION
SELECT
       'OrderArchive' AS Src_Table
      ,[OrderID]
      ,[ProductID]
      ,[CustomerID]
      ,[SalesPersonID]
      ,[OrderDate]
      ,[ShipDate]
      ,[OrderStatus]
      ,[ShipAddress]
      ,[BillAddress]
      ,[Quantity]
      ,[Sales]
      ,[CreationTime]
FROM
SALES.OrdersArchive
ORDER BY OrderID, Src_Table DESC