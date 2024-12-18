----Q1: 10 points	
SELECT title, (retail-cost)/retail Profit_Margin    -- no need to query profit_margin
FROM books
WHERE retail-cost >= 0.3 * retail      -- can't use column alias
ORDER BY Profit_Margin DESC;           -- can use column alias (same format as shown in SELECT)


----Q2: 20 points (Must use WHERE clause to specify join conditions)  
SELECT a.lname, a.fname, b.title
 FROM books b, orders o, orderitems i, customers c, bookauthor t, author a
 WHERE c.customer# = o.customer#
  AND o.order# = i.order#
  AND i.isbn = b.isbn
  AND b.isbn = t.isbn
  AND t.authorid = a.authorid
  AND c.firstname = 'TAMMY'
  AND c.lastname = 'GIANA'
ORDER BY a.lname;

----Q3: 10 points (If using WHERE clause to specify join conditions)
SELECT b.isbn, b.title, b.retail-NVL(b.discount, 0) sales_price,  -- no need to use NVL if we haven't used NVL in advance
       o.order#, oi.quantity
FROM books b LEFT JOIN orderitems oi ON b.isbn = oi.isbn
    LEFT JOIN orders o ON oi.order# = o.order#
ORDER BY b.title;       -- order by is optional

----Q4
SELECT b.title
 FROM books b JOIN bookauthor ba USING (isbn)
  JOIN author a USING (authorid)
 WHERE a.lname = 'JONES';


----Q5
SELECT isbn
 FROM books
MINUS
SELECT isbn
 FROM orderitems;



----Q6
-- Since we haven't learned subqueries by the assignment due, you can perform two SQL statements sequentially.
SELECT DISTINCT order#
FROM books b JOIN orderitems oi ON b.isbn = oi.isbn
WHERE b.category = 'CHILDREN'
INTERSECT
SELECT DISTINCT order#
FROM orderitems
WHERE item# > 1;

SELECT customer#, c.firstname, c.lastname, o.order#
FROM customers c JOIN orders O USING(customer#)
WHERE o.order# IN (1007, 1012);  -- these order# are the result of the first statement


-- or, you can use self-join on orderitems to get orders with different item#
SELECT DISTINCT c.customer#, c.firstname, c.lastname, o.order#
FROM customers c JOIN orders o ON c.customer# = o.customer#
                 JOIN orderitems oia ON o.order# = oia.order#
                 JOIN books b ON oia.isbn = b.isbn
                 JOIN orderitems oib ON oia.order# = oib.order#
                                    AND oia.item# <> oib.item#
WHERE b.category = 'CHILDREN';


---- If you use one statement by using Week 7 learning content: 
SELECT customer#, c.firstname, c.lastname, o.order#
FROM customers c JOIN orders O USING(customer#)
WHERE o.order# IN (SELECT DISTINCT order#
                    FROM books b JOIN orderitems oi ON b.isbn = oi.isbn
                    WHERE b.category = 'CHILDREN'
                    INTERSECT
                    SELECT DISTINCT order#
                    FROM orderitems
                    GROUP BY order#
                    HAVING count(*) > 1);


SELECT customer#, c.firstname, c.lastname, o.order#
FROM customers c JOIN orders O USING(customer#)
WHERE o.order# IN (SELECT DISTINCT order#
                    FROM books b JOIN orderitems oi ON b.isbn = oi.isbn
                    WHERE b.category = 'CHILDREN'
                    INTERSECT
                    SELECT DISTINCT order#
                    FROM orderitems
                    GROUP BY order#
                    HAVING count(*) > 1);

-- there are many other ways to produce the same results


-- Q7
SELECT INITCAP(title) as Book_title, ROUND(100*(retail-cost)/cost, 0) || '%' "Mark Up",
       TO_CHAR(retail, '$999.99') "Retail Price" 
FROM books;
