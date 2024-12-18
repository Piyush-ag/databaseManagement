------------------------ Week 7 SQL Pracitce in Class --------------------------
------------------------ Functions ---------------------------------------------

/*----------------------- PART I ------------------------------------*/
SELECT SUM(paideach * quantity) "Total_Sales"
FROM orderitems oi JOIN orders o USING(order#)
WHERE orderdate = '02-APR-19';

SELECT paideach * quantity "Total_Sale per item"        -- Not using SUM
FROM orderitems oi JOIN orders o USING(order#)
WHERE orderdate = '02-APR-19';

-- AVG
SELECT AVG(retail-cost) "Average Profit"
FROM books
WHERE category = 'COMPUTER';

SELECT retail-cost
FROM books
WHERE category = 'COMPUTER';


SELECT TO_CHAR(AVG(retail-cost), '$999.99') "Average Profit"    -- apply TO_CHAR
FROM books
WHERE category = 'COMPUTER';

DESC employees;         

SELECT empno, lname, mthsal, bonus      -- Stuart doesn't have bonus yet
FROM employees;

SELECT SUM(bonus), count(bonus), sum(bonus)/count(bonus)     -- Total bonus from 4 employees is 7,600: average 1,900 per employee
FROM employees;

SELECT AVG(bonus) Avg_bonus       -- 1,900: same as the average value for 4 employees above. Group functions ignore NULLs except for count(*)
FROM employees;

SELECT AVG(bonus)                 -- 1,900 excluding Stuart
FROM employees
WHERE lname <> 'STUART';

SELECT NVL(bonus, 0) Bonus
FROM employees;


SELECT AVG(NVL(bonus,0)) Avg_bonus
FROM employees;             -- 1,520: lower avg value

-- COUNT
SELECT COUNT(*) total_rows, COUNT(bonus) rows_w_bonus
FROM employees;

SELECT COUNT(DISTINCT category)
FROM books;

SELECT COUNT(*)             -- 6 orders have not been shipped    
FROM orders
WHERE shipdate IS NULL;

SELECT COUNT(*) - COUNT(shipdate) "Orders not shipped"
FROM orders;

SELECT SUM(CASE WHEN shipdate IS NULL THEN 1 ELSE 0 END) -- orders not shipped
FROM orders;

SELECT SUM(NVL2(shipdate, 0, 1)) -- orders not shipped
FROM orders;

-- MAX/MIN
SELECT MAX(retail-cost) "Highest Profit"
FROM books;

SELECT MAX(retail-cost) "Highest Profit", title -- error: Title column is a non-aggregate column
FROM books;

SELECT retail-cost "Profit", title
FROM books
WHERE retail - cost = (SELECT MAX(retail-cost)  -- this will solve the question of which book has the highet profit
                        FROM books);

SELECT MIN(pubdate)     -- The earliest publication date
FROM books;

---- GROUP BY -----
SELECT DISTINCT category
FROM books;

SELECT category, AVG(retail-cost) avg_profit
FROM books
GROUP BY category;


SELECT category, TO_CHAR(AVG(retail-cost), '$999.99') avg_profit
FROM books
GROUP BY category
ORDER BY avg_profit;

SELECT category, AVG(retail-cost) avg_profit    -- error: category is non-aggregated single column, and thus, we exepect to have it in the GROUP BY clause
FROM books;


---- HAVING Clause: restricting groups to be displayed (similar to WHERE for non-aggregate terms)
SELECT category, TO_CHAR(AVG(retail-cost), '$999.99') AVG_Profit
FROM books
GROUP BY category
HAVING AVG(retail-cost) > 15;   -- Fetch the groups (categories in this example) that have average profit greater than 15

SELECT category , AVG(retail-cost) AVG_Profit
FROM books
GROUP BY category
HAVING AVG_Profit > 15;         -- Can use column alias in the HAVING clause

SELECT category, TO_CHAR(AVG(retail-cost), '$999.99') "Profit"
FROM books
WHERE pubdate > '01-JAN-15'
GROUP BY category
HAVING AVG(retail-cost) > 15;

SELECT *
FROM books
WHERE pubdate > '01-JAN-15';   -- 9 books

SELECT *
FROM books
WHERE retail - cost > 15;   -- 7 books


--Nested Group Functions
SELECT order#, SUM(paideach * quantity) "Revenue per item"
FROM orderitems
GROUP BY order#;

SELECT AVG(SUM(paideach * quantity)) "Average Order Amount"
FROM orderitems
GROUP BY order#;        -- we can't have order# in the SELECT clause due to the outer layer SUM function


---- Statitical Group Functions
SELECT category, COUNT(*) Num_books,
       TO_CHAR(AVG(retail-cost), '$999.99') "Avg Profit",
       TO_CHAR(STDDEV(retail-cost), '999.9999') "Std. Dev",
       TO_CHAR(VARIANCE(retail-cost), '999.9999') "Variance",
       MEDIAN(retail-cost) "Median",
       MIN(retail-cost) "Minimum",
       MAX(retail-cost) "Maximum"
FROM books
GROUP BY category;


/*----------------- PART II ---------------------------------------*/

SELECT title, cost, category        -- list the books that have higher cost than 'Database Implementation'
FROM books
WHERE cost > (SELECT cost
              FROM books
              WHERE title = 'DATABASE IMPLEMENTATION')
and category = 'COMPUTER';              

SELECT category, AVG(retail-cost) "Average Profit"
FROM books
GROUP BY category
HAVING AVG(retail-cost) > (SELECT AVG(retail-cost)
                            FROM books
                            WHERE category = 'LITERATURE');
                            
SELECT title, retail, 
       (SELECT ROUND(AVG(retail), 2) FROM books) "Overall Avg Retail",
       TO_CHAR(retail - (SELECT AVG(retail) FROM books), '999.99') "Difference"
FROM books;       

-- Multiple Row Subquery
SELECT title, retail, category
FROM books
WHERE retail IN (SELECT MAX(retail)     -- can use =ANY instead of IN
                 FROM books
                 GROUP BY category)
ORDER BY category;       

SELECT retail        -- less than thge highest retail of Cooking category
FROM books
WHERE category = 'COOKING';

SELECT title, retail
FROM books
WHERE retail <ANY (SELECT retail        -- less than thge highest retail of Cooking category
                   FROM books
                   WHERE category = 'COOKING')
ORDER BY title;                   

SELECT title, retail
FROM books
WHERE retail < (SELECT MAX(retail)
                FROM books
                WHERE category = 'COOKING')
ORDER BY title;               

DESC bookauthor;

SELECT order#, SUM(quantity * paideach)
FROM orderitems
GROUP BY order#
HAVING SUM(quantity * paideach) > ALL (SELECT SUM(quantity * paideach)
                                       FROM customers JOIN orders USING(customer#)
                                                      JOIN orderitems USING(order#)
                                       WHERE state = 'FL'
                                       GROUP BY order#);

SELECT SUM(quantity * paideach)
FROM customers JOIN orders USING(customer#)
JOIN orderitems USING(order#) 
WHERE state = 'FL'                                      
GROUP BY order#;


SELECT authorid, SUM(quantity * paideach) total_sales
FROM bookauthor ba JOIN orderitems oi ON ba.isbn = oi.isbn
GROUP BY authorid             
Having SUM(quantity * paideach) > ALL (SELECT SUM(quantity * paideach)
                                       FROM orderitems oi JOIN orders o USING (order#)
                                       GROUP BY orderdate);

-- Multiple-Column Subqueries
SELECT b.title, b.retail, a.category, a.cat_average
FROM books b, (SELECT category, AVG(retail) cat_average
               FROM books
               GROUP BY category) a
WHERE b.category = a.category
AND b.retail > a.cat_average
ORDER BY b.category, b.title, b.retail;

SELECT b.title, b.retail, a.category, a.cat_average     -- use JOIN ON
FROM books b JOIN (SELECT category, AVG(retail) cat_average
                   FROM books
                   GROUP BY category) a
             ON b.category = a.category
WHERE b.retail > a.cat_average
ORDER BY b.category, b.title, b.retail;


SELECT title, retail, category
FROM books
WHERE (category, retail) IN (SELECT category, MAX(retail)
                             FROM books
                             GROUP BY category)
ORDER BY category;                             


---- Uncorrelated vs. Correlated Subqueries -----
SELECT title
FROM books
WHERE exists (SELECT isbn
              FROM orderitems
              WHERE books.isbn = orderitems.isbn);
              
-- Convert the example from previous slide by using Correlated Subquery
SELECT b.title, b.retail, b.category   
FROM books b 
WHERE b.retail > (SELECT AVG(retail)
                  FROM books a
                  WHERE b.category = a.category)
ORDER BY b.category, b.retail desc;


---- Nested Subqueries
SELECT customer#, c.lastname, c.firstname
FROM customers c JOIN orders o USING (customer#)
WHERE o.order# IN (SELECT order#
                   FROM orderitems
                   GROUP BY order#
                   HAVING COUNT(*) = (SELECT MAX(COUNT(*))
                                      FROM orderitems
                                      GROUP BY order#));

SELECT customer#, c.lastname, c.firstname, order#, oi.item# -- above query can be re-written
FROM customers c JOIN orders o USING (customer#)
                 JOIN orderitems oi USING(order#)
WHERE oi.item# = (SELECT MAX(COUNT(*))
                  FROM orderitems
                  GROUP BY order#);


---- Subquery in a DML -----
SELECT *
FROM employees;

UPDATE employees
SET bonus = (SELECT AVG(bonus)
             FROM employees)
WHERE empno = 8844;

