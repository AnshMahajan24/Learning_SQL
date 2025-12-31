 -- INNER JOIN
 
 SELECT 
 cust.id,    -- we write in this way to avoid ambiguity , here no ambuiguity is there but what if there was just id 
 -- in place of order_id in the other table so SQL confuces whose table col is this so we specify the table name in this way
 first_name,
 ord.order_id, -- good practise to join this way as we knowing whose col is this
 sales
 FROM customers AS cust  -- as to not write full table names all the times, we give table name a alias
 INNER JOIN orders AS ord
 ON cust.id = ord.customer_id;

 -- LEFT JOIN

 SELECT id,first_name,order_id,sales FROM CUSTOMERS LEFT JOIN ORDERS ON CUSTOMERS.ID = ORDERS.CUSTOMER_ID;

  -- RIGHT JOIN

 SELECT id,first_name,order_id,sales FROM CUSTOMERS RIGHT JOIN ORDERS ON CUSTOMERS.ID = ORDERS.CUSTOMER_ID;
 SELECT id,first_name,order_id,sales FROM ORDERS LEFT JOIN CUSTOMERS ON CUSTOMERS.ID = ORDERS.CUSTOMER_ID;

 -- FULL JOIN

 SELECT * FROM CUSTOMERS FULL JOIN ORDERS ON CUSTOMERS.ID = ORDERS.CUSTOMER_ID
 SELECT * FROM ORDERS FULL JOIN CUSTOMERS ON CUSTOMERS.ID = ORDERS.CUSTOMER_ID

 -- GET ALL CUSTOMERS WHO HASNT PLACED ANY ORDERS YET

 SELECT * FROM CUSTOMERS LEFT JOIN ORDERS ON CUSTOMERS.ID = ORDERS.CUSTOMER_ID WHERE ORDERS.CUSTOMER_ID IS NULL;

 -- GET ALL ORDERS WITHOUT MATCHING CUSTOMERS

 SELECT * FROM ORDERS LEFT JOIN CUSTOMERS ON ORDERS.CUSTOMER_ID = CUSTOMERS.ID WHERE CUSTOMERS.ID IS NULL

 -- FIND ORDERS WITHOUT CUSTOMERS AND CUSTOMERS WITHOUT ORDERS

 SELECT * FROM ORDERS FULL JOIN CUSTOMERS ON ORDERS.CUSTOMER_ID = CUSTOMERS.ID WHERE CUSTOMERS.ID IS NULL OR ORDERS.CUSTOMER_ID IS NULL

 -- FIND CUSTOMERS ALONG WITH THEIR ORDERS BUT ONLY FOR CUSTOMERS WHO HAVE PLACED AN ORDER ( WITHOUT INNER JOIN )

 SELECT * FROM ORDERS FULL JOIN CUSTOMERS ON ORDERS.CUSTOMER_ID = CUSTOMERS.ID WHERE CUSTOMERS.ID IS NOT NULL AND ORDERS.CUSTOMER_ID IS NOT NULL
 SELECT * FROM CUSTOMERS LEFT JOIN ORDERS ON ORDERS.CUSTOMER_ID = CUSTOMERS.ID WHERE ORDERS.CUSTOMER_ID IS NOT NULL
 
 -- generate all possible combinations of customers and orders

 SELECT * FROM CUSTOMERS CROSS JOIN ORDERS

 -- MULTY TABLE JOINS USING SALES DATABASE
 -- RETRIEVE ALL ORDERS ALONG WITH THEIR RELATED CUSTOMERS, PRODUCTS,  EMPLOYE DETAILS (some cols from each not all) we have done it in the query
 use SalesDB
 select * from sales.Products

 SELECT O.OrderID, O.Sales, 
 C.FirstName AS CustFirstName, C.LastName AS CustLastName,   -- here if i not include C. then it will be error as here 2 FirstNmse are there so SQL have to be told whose tables col is this
 P.Product AS ProductName, P.Price AS ProductPrice, 
 E.FirstName AS EmpFirstName, E.LastName AS EmpLastName
 FROM Sales.Orders AS O 
 LEFT JOIN sales.Customers AS C on O.CustomerID = C.CustomerID
 LEFT JOIN sales.Products AS P ON O.ProductID = P.ProductID        -- er diag helps identifying the FK and PK relation or you can manually inspect all the tables
 LEFT JOIN sales.Employees AS E ON O.SalesPersonID = E.EmployeeID   -- on condn are very imp to chack in multiple joins

