-- DATA MANIPULATION LNGUAGE

INSERT INTO customers (first_name, id, country, score)
VALUES('saksham',8,'INDIA',NULL),
	  ('himani',9,NULL,85)

INSERT INTO customers (first_name, id)  -- other cols are filled with NULL, but the cols have to not be in the constraint of NOT NULL
VALUES('saksham',10),
	  ('himani',11)

SELECT * FROM customers

-- copying data from 1 table to another with smartness
INSERT INTO persons (id,person_name,birth_date,email)
SELECT
id,
first_name,
NULL,
'unknown'
FROM customers

UPDATE customers
SET score=0
WHERE ID=6

UPDATE customers
SET score=0, country='UK'
WHERE id=10

Update customers   -- updating multiple cols in one go
SET score=0
WHERE score IS NULL  -- notice


DELETE from customers
WHERE id > 5

DELETE FROM persons   -- deletes all data in the table persons, not table is deleted  ut data inside it
TRUNCATE TABLE persons -- better faster