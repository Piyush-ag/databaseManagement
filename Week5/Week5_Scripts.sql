------------------------ Week 5 SQL Pracitce in Class --------------------------
------------------------ WHERE & ORDER BY Clauses ------------------------------
------ Part I --------------
SELECT lastname, state
FROM customers
WHERE state = 'FL';         -- Case and spacing of the entered value must match the column's value

SELECT lastname, state
FROM customers
WHERE state = 'fl';         -- retrieves nothing because state values are stored in upper case

SELECT firstname, lastname
FROM customers
WHERE customer# = 1010;     -- numeric values don't need to be enclosed by single quotes

SELECT *
FROM orders
WHERE orderdate = shipdate; -- can use another column as a comparison value

SELECT *
FROM books
WHERE pubdate = '21-JAN-15';    -- date values need to be enclosed in single quotes (not case sensitive)

SELECT *
FROM books
WHERE pubdate = '21-jan-15';    -- date values are not case sensitive

SELECT title, retail
FROM books
WHERE retail > 55;

SELECT isbn, title
FROM books
WHERE title > 'HOO';            -- comparison operators work for text as well

SELECT title FROM books
WHERE title <= 'HOO';

SELECT order#, orderdate
FROM orders
WHERE orderdate < '01-APR-19';      -- can use > or < comparison operators for date

SELECT title, retail - cost profit
FROM books
WHERE retail - cost < cost * 0.2;   -- can't use column alias in the WHERE clause

SELECT customer#, firstname, lastname, state
FROM customers
WHERE state <> 'GA';                -- same as using !=  or  ^=

SELECT title, pubid
FROM books
WHERE pubid BETWEEN 1 AND 3;        -- same as WHERE pubid IN (4, 5)

SELECT title, pubid
FROM books
WHERE pubid NOT BETWEEN 1 AND 3;    -- same as WHERE pubid IN (4, 5)

SELECT title, pubid
FROM books
WHERE pubid IN (1, 2, 5);        -- same as WHERE pubid NOT IN (3, 4)

SELECT title, pubid
FROM books
WHERE title BETWEEN 'A' AND 'D';   -- title starts with A+ , upper threshold is 'D'

SELECT title, pubid
FROM books
WHERE pubid IN (4, 5);          -- opposite of BETWEEN 1 and 3 (pubid values are 1 to 5)


---- LIKE Operator
SELECT firstname, lastname
FROM customers
WHERE lastname LIKE 'N%';        -- find records that has lastname starts with letter 'N'

SELECT firstname, lastname
FROM customers
WHERE lastname LIKE '%N%';      -- letter N in any position

SELECT customer#, firstname, lastname
FROM customers
WHERE customer# LIKE '10_9';    -- 4 digits: 3rd can be anything

---- Logical Operators
SELECT title, pubid, category
FROM books
WHERE pubid = 3
AND category = 'COMPUTER';      -- Logical operator AND: both search condition must be met

SELECT title, pubid, category
FROM books
WHERE pubid = 3
OR category = 'COMPUTER';

SELECT title, pubid, retail, cost, category
FROM books
WHERE category = 'FAMILY LIFE'
OR pubid = 4
AND cost > 15;          -- always AND proceeds OR (you can use parenthesis to override the order)

SELECT title, pubid, retail, cost, category
FROM books
WHERE NOT category = 'FAMILY LIFE'      -- always in the order of NOT, AND, OR
OR pubid = 4
AND cost > 15;          

SELECT title, pubid, cost, category
FROM books;

SELECT title, pubid, retail, cost, category
FROM books
WHERE NOT category = 'FAMILY LIFE'
AND NOT (pubid = 4
AND cost > 15);          

SELECT title, pubid, retail, cost, category
FROM books
WHERE (category = 'FAMILY LIFE'
OR pubid = 4)
AND cost > 15;                      -- fetched books must cost more than $15

SELECT title, pubid, retail, cost, category
FROM books
WHERE pubid = 4;


---- NULL Values
SELECT order#, orderdate, shipdate
FROM orders
WHERE shipdate IS NULL;         -- no data in shipdate: orders that are not shipped

SELECT order#, orderdate, shipdate
FROM orders
WHERE shipdate IS NOT NULL;     -- already shipped

SELECT order#, orderdate, shipdate
FROM orders
WHERE shipdate = NULL;         -- doesn't give error, but no records are returned


---- ORDER BY Clause ------------------
SELECT title
FROM books
ORDER BY title;     -- A to Z, alphabetical order (ascending is the default order)

SELECT title
FROM books
ORDER BY title DESC;  -- Z to A (DESC changes the order to descending)

DESC testing;

SELECT *
FROM testing
ORDER BY tvalue;             -- the display order is blank > special character > numbers > upper case > lower case > null

SELECT title, retail-cost Profit
FROM books
WHERE retail-cost > 0.5*cost            -- can't us column alias in WHERE
ORDER BY PROFIT;                      -- can use column alias in ORDER BY cluase: must follow the same style of the column alias

SELECT title, retail-cost "Profit"
FROM books
WHERE retail-cost > 0.5*cost            
ORDER BY PROFIT;                      -- error: the case differs from how it's defined

----NULLS FIRST/LAST
SELECT lastname, firstname, state, referred
FROM customers
WHERE state = 'CA'
ORDER BY referred NULLS FIRST;      -- Null values are listed on the top (the opposite is NULLS LAST)

SELECT lastname, firstname, state, referred
FROM customers
WHERE state = 'CA'
ORDER BY referred DESC;     -- DESC option changes the display order to descending

---- Secondary Sort (when same values exist for the primary sort, we further sort based on secondary)
SELECT lastname, firstname, state, city
FROM customers
ORDER BY state, city;       -- sort based on state first, then city within the same state 

SELECT lastname, firstname, state, city
FROM customers
ORDER BY state DESC, city DESC;     

SELECT lastname, firstname, state, city     -- state is the 3rd column, city is the 4th column
FROM customers
ORDER BY 3 DESC, 4 DESC;          -- can use the position of the columns in the SELECT clause instead of the column names


/*------------------ PART II -------------------------------------------------*/
SELECT title, name
FROM books, publisher;

SELECT isbn, title, location, '             ' count
FROM books CROSS JOIN warehouses            -- cartesian joins
ORDER BY location, title;

SELECT title, name
FROM books, publisher
WHERE books.pubid = publisher.pubid;        -- equality join condition given in WHERE clause

SELECT title, pubid, name                   -- error because pubid exists in both tables
FROM books, publisher
WHERE books.pubid = publisher.pubid;

SELECT title, books.pubid, name         -- it works because we clairified where pubid belongs to
FROM books, publisher
WHERE books.pubid = publisher.pubid;        

SELECT title, books.pubid, name
FROM books, publisher
WHERE books.pubid = publisher.pubid     -- WHERE clause can have both join condition and search condition
AND books.retail > 25;

SELECT b.title, b.pubid, p.name, b.cost
FROM books b, publisher p           -- can give table alias; once given in FROM clause, must use the alias instead of the table name
WHERE b.pubid = p.pubid
AND (b.cost < 15 OR p.pubid = 1)    -- get error if we change b.cost to books.cost
ORDER BY title;

SELECT a.title, a.pubid, c.name, a.cost
FROM books a, publisher c           -- can give table alias; once given in FROM clause, must use the alias instead of the table name
WHERE a.pubid = c.pubid
AND a.retail > 25;

---- Joining more than two tables
SELECT c.lastname, c.firstname, b.title, b.isbn
FROM customers c, orders o, orderitems oi, books b      -- 3 join conditions to connect 4 tables
WHERE c.customer# = o.customer#         -- join CUSTOMERS and ORDERS
AND o.order# = oi.order#                -- join ORDERS and ORDERITEMS
AND oi.isbn = b.isbn                    -- join ORDERITEMS and BOOKS
ORDER BY c.lastname, c.firstname;

---- NATURAL JOIN
SELECT b.title, pubid, p.name           -- can't use column qualifier for the column used to join tables with NATURAL JOIN
FROM books b NATURAL JOIN publisher p;

SELECT b.title, b.pubid, p.name         -- error: Natural Join already assumes both tables have the same column, so do not provide column qualifier on that column
FROM books b NATURAL JOIN publisher p;
-- ALTER TABLE publisher        -- test with another common field with the same name
-- ADD category CHAR(10);

---- JOIN USING
SELECT b.title, pubid, p.name       -- can't use column qualifier for the column used to join tables with JOIN USING
FROM books b JOIN publisher p
USING (pubid);                      -- specify the column name to be used to join tables

---- JOIN ON
DESC publisher2;

SELECT b.title, b.pubid, p.name     -- must give column qualifier for the common field  
FROM books b JOIN publisher2 p
    ON b.pubid = p.id;

SELECT c.lastname, c.firstname, b.title
FROM customers c JOIN orders o ON c.customer# = o.customer#
     JOIN orderitems oi ON o.order# = oi.order#
     JOIN books b ON oi.isbn = b.isbn       -- 3 join conditions to connect 4 tables
WHERE b.category = 'COMPUTER'               -- getting customers list who purchased books in the Computer category
ORDER BY c.lastname, c.firstname;

SELECT c.lastname, c.firstname, b.title
FROM customers c JOIN orders o USING (customer#)    -- can be done by using JOIN USING
    JOIN orderitems oi USING (order#)
    JOIN books b USING (isbn)
WHERE b.category = 'COMPUTER'               -- getting customers list who purchased books in the Computer category
ORDER BY c.lastname, c.firstname;
    

---- NON-Equality JOINS
SELECT *
FROM promotion;

SELECT b.title, p.gift, b.retail
FROM books b, promotion p
WHERE b.retail BETWEEN p.minretail AND p.maxretail;

SELECT b.title, p.gift, b.retail
FROM books b JOIN promotion p
    ON b.retail BETWEEN p.minretail AND p.maxretail;


---- SELF JOIN ----    
SELECT c.firstname, c.lastname, m.firstname "Referred by"
FROM customers c, customers m       -- regard the second CUSTOMERS as a master table to look up
WHERE c.referred = m.customer#;

SELECT c.firstname, c.lastname, c.firstname "Referred by"
FROM customers c JOIN customers m  
ON c.referred = m.customer#;


---- OUTER JOIN ----
--SELECT c.lastname, c.firstname, o.order#
--FROM customers c, orders o
--WHERE c.customer# = o.customer#(+);         -- Outer Join: Customers table's records must be all retrieved regardless of the match

SELECT * FROM customers;

SELECT c.lastname, c.firstname, o.order#
FROM customers c LEFT JOIN orders o           -- can use LEFT OUTER JOIN
    ON c.customer# = o.customer#;

SELECT c.lastname, c.firstname, o.order#
FROM customers c RIGHT JOIN orders o           -- can use RIGHT OUTER JOIN
    ON c.customer# = o.customer#;

SELECT c.lastname, c.firstname, o.order#
FROM customers c FULL JOIN orders o           -- can use FULL OUTER JOIN
    ON c.customer# = o.customer#;

SELECT oi.order#, oi.item#, b.title
FROM orderitems oi RIGHT JOIN books b
    ON oi.isbn = b.isbn
ORDER BY b.title;    


---- SET Operators ----------
SELECT ba.authorid
FROM books b JOIN bookauthor ba
    USING (isbn)
WHERE b.category = 'FAMILY LIFE'
UNION                           -- SET OPERATOR: UNION suppresses duplicate queries
SELECT ba.authorid
FROM books b JOIN bookauthor ba
    USING (isbn)
WHERE b.category = 'CHILDREN';

SELECT ba.authorid
FROM books b JOIN bookauthor ba
    USING (isbn)
WHERE b.category = 'FAMILY LIFE'
MINUS                          -- MINUS SET OPERATOR: List query resutls from A that are not in the query results B (A - B)
SELECT ba.authorid
FROM books b JOIN bookauthor ba
    USING (isbn)
WHERE b.category = 'CHILDREN';  

SELECT * FROM publisher;
SELECT * FROM publisher3;

SELECT pubid, name
FROM publisher 
UNION
SELECT id, name         -- must have the same # of columns in the matching order
FROM publisher3
ORDER BY pubid;         -- do not give a column qualifier: uses the first query's column names

SELECT customer#                -- 20 customers (20 customer#)
FROM customers
INTERSECT                       -- Results in the list of customer# who placed orders
SELECT customer#                -- 21 orders but 14 customers placed orders
FROM orders;

SELECT customer#                -- 20 customers (20 customer#)
FROM customers
MINUS                           -- Results in the list of customer# who never placed any orders
SELECT customer#                -- 21 orders but 14 customers placed orders
FROM orders;

SELECT pubid, name "Pub Name"           -- QUERY 1
FROM publisher
UNION
SELECT id, name                         -- QUERY 2
FROM publisher3
ORDER BY "Pub Name";                    -- always use Query1's column names (alias if assigned)








    




