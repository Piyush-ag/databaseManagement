------------------------ Week 6 SQL Pracitce in Class --------------------------
------------------------ Functions ---------------------------------------------

SELECT *
FROM dual;

SELECT 25 + 5, SYSDATE, LENGTH('The Assassination of Jesse James by the Coward Robert Ford') title_length
FROM dual;

---- Case Conversion Functions ----
SELECT lastname, LOWER(lastname), UPPER(lastname), INITCAP(lastname)
FROM customers;

SELECT firstname, lastname
FROM customers
WHERE LOWER(lastname) = 'nelson';           -- useful when we don't know how the data are stored

SELECT firstname, lastname
FROM customers
WHERE UPPER(lastname) = 'NELSON';           -- useful when we don't know how the data are stored

SELECT firstname, lastname
FROM customers
WHERE lastname = UPPER('nelson');           -- useful when we know how the data values are stored (we change the data entry to upper case)

SELECT firstname, lastname
FROM customers
WHERE lastname = UPPER('&Last_Name');       -- whichever case is entered, all adjusted to upper case

SELECT title, INITCAP(title) "Book's Title" -- changes every first letter of each word to upper case
FROM books
WHERE rownum <= 5
ORDER BY title;


---- Character Manipulation Functions ----
SELECT SUBSTR('Carey', 3, 2),
       SUBSTR('Carey', 2, 4),
       SUBSTR('Carey', -5, 2)   -- negative position: the position is the nth character from the end (reverse counting)
FROM dual;

SELECT SUBSTR('Carey Business School', 7, 8)    -- extract 8 characters from 7th position
FROM dual;

SELECT zip, SUBSTR(zip, 1, 3), SUBSTR(zip, -3, 2)
FROM customers
WHERE SUBSTR(zip, -3, 2) < 30;

SELECT INSTR('Carey business school', 'e', 5)   -- find the position of 'e' starting from the position 5
FROM dual;

SELECT INSTR('Carey business school', 'e', 5, 2)  -- find the second 'e', search starts from the 5th position
FROM dual;                                        -- result should be zero   

DESC contacts;

SELECT *            -- name column contains lastname, firstname, and phone number
FROM contacts;

SELECT name, INSTR(name, ',') "First Comma",        -- find the position of the first comma
             INSTR(name, ',', 10) "Start read position 10", -- find comma from 10th position in the name column
             INSTR(name, ',', 1, 2) "Second Comma"  -- find the position of the 2nd comma
FROM contacts;             

SELECT INSTR('Brown,Charlie,410-234-5678', ',') first_comma,
       INSTR('Brown,Charlie,410-234-5678', ',', 1, 2) second_comma,
       INSTR('Brown,Charlie,410-234-5678', ',', 1, 2) - INSTR('Brown,Charlie,410-234-5678', ',') - 1 first_name_length
FROM dual;       

-- Nesting Functions
SELECT name, SUBSTR(name, 1, INSTR(name, ',')-1) Last_Name,
       SUBSTR(name, INSTR(name, ',')+1, INSTR(name, ',', 1, 2)-INSTR(name, ',')-1) First_Name 
FROM contacts;  

SELECT DISTINCT LENGTH(address)
FROM customers
ORDER BY length(address) DESC;

SELECT MAX(LENGTH(address))
FROM customers;

SELECT MAX(LENGTH(address))
FROM customers;

---- LPAD/RPAD, LTRIM/RTRIM
SELECT firstname,
       LPAD(firstname, 12, ' ') "Space Pad",        -- LPAD aligns the character string to the right
       LPAD(firstname, 12, '*') "* Pad"
FROM customers
WHERE firstname LIKE 'J%';

SELECT firstname,
       RPAD(firstname, 12, ' ') "Space Pad",
       RPAD(firstname, 12, '*') "* Pad"
FROM customers
WHERE firstname LIKE 'J%';

SELECT lastname, address, LTRIM(address, 'P.O. BOX') Trimmed   -- removes all characters in 'P.O, BOX' until it reaches a character not in 'P.O, BOX'     
FROM customers
WHERE state = 'FL';

SELECT lastname, address, LTRIM(address, 'P.O. BOx') Trimmed   -- case sensitive
FROM customers
WHERE state = 'FL';

SELECT lastname, address, LTRIM(address, 'P.O.BOX') Trimmed   -- the result is different
FROM customers
WHERE state = 'FL';

SELECT name, RTRIM(name, 'INC.')
FROM publisher;

SELECT TRIM(LEADING '*' FROM '****fifty dollars only****') "Trimmed" -- TRIM can take only one character
FROM dual;

SELECT TRIM(TRAILING '*' FROM '****fifty dollars only****') "Trimmed"
FROM dual;

SELECT TRIM(BOTH '*' FROM '****fifty dollars only****') "Trimmed"
FROM dual;

-- REPLACE, TRANSLATE
SELECT address, REPLACE(address, 'P.O.', 'POST OFFICE')
FROM customers
WHERE state = 'FL';

SELECT name, TRANSLATE(name, ',', ' ')  -- not useful
FROM contacts;

SELECT firstname, lastname, CONCAT('Customer number: ', customer#) "Number" -- quite useless function (can concatenate only two values)
FROM customers
WHERE state = 'FL';


---- NUMBER Functions ----
SELECT ROUND(28.75, 1), ROUND(28.75, 0), ROUND(28.75, -1)
FROM dual;

SELECT ROUND(28.7555, 3), ROUND(2555.755, -2)
FROM dual;

SELECT title, retail, ROUND(retail, 1) one_tenth, ROUND(retail, 0) ones, ROUND(retail, -1) tens
FROM books;

SELECT title, retail, TRUNC(retail, 1), TRUNC(retail, 0), TRUNC(retail, -1)
FROM books;

SELECT retail, FLOOR(retail), CEIL(retail)
FROM books;

SELECT retail, TRUNC(retail, 0), TRUNC(retail), FLOOR(retail), CEIL(retail)
FROM books;

SELECT 235/16, TRUNC(235/16) LBS, MOD(235, 16) OZ   -- MOD returns the remainder from division calculation
FROM dual;

SELECT title, cost-retail, ABS(cost-retail)
FROM books;


---- DATE Functions ----
SELECT order#, shipdate, orderdate, shipdate-orderdate "Shipping Days"
FROM orders
WHERE shipdate IS NOT NULL;

desc orders;

SELECT b.title, MONTHS_BETWEEN(o.orderdate, b.pubdate) "Months since Published"
FROM books b JOIN orderitems oi ON b.isbn = oi.isbn
             JOIN orders o ON oi.order# = o.order#;    

SELECT MONTHS_BETWEEN('03-FEB-2024','03-DEC-2023')  -- same days of the month
FROM dual;

SELECT MONTHS_BETWEEN('29-FEB-2024','31-DEC-2023')  -- last days of the month
FROM dual;

SELECT MONTHS_BETWEEN('29-FEB-2024','30-JAN-2024'), 30/31
FROM dual;

SELECT MONTHS_BETWEEN('29-FEB-2024','28-NOV-2023'), 1/31
FROM dual;

SELECT b.title, TRUNC(MONTHS_BETWEEN(o.orderdate, b.pubdate),0) "Months since Published"
FROM books b JOIN orderitems oi ON b.isbn = oi.isbn
             JOIN orders o ON oi.order# = o.order#
WHERE o.order# = 1012;    

SELECT title, pubdate, 
       ADD_MONTHS('01-DEC-22', 18) "Renegotiation Date",
       ADD_MONTHS(pubdate, 12*17) "Drop Date"
FROM books
WHERE category = 'COMPUTER'
ORDER BY "Renegotiation Date";

SELECT order#, orderdate, NEXT_DAY(orderdate, 'MONDAY') -- returns the nearest Monday after orderdate
FROM orders
WHERE order# = 1018;

SELECT SYSDATE, NEXT_DAY(sysdate, 'sunday')
FROM dual;

SELECT pubdate, ROUND(pubdate, 'MONTH'), ROUND(pubdate, 'YEAR') -- can use month, mm, year, yy, yyyy
FROM books
WHERE category = 'CHILDREN';


---- TYPE/FORMAT CONVERSION
SELECT order#, customer#, orderdate, shipdate
FROM orders
WHERE orderdate = TO_DATE('March 31, 2019', 'Month DD, YYYY');  -- instruct the system to convert this date data with this format to default format

SELECT order#, customer#, orderdate, shipdate
FROM orders
WHERE orderdate = TO_DATE('March 31, 2019', 'mm dd, yyyy');  -- month, mm, MM, all works

SELECT title, 
       TO_CHAR(pubdate, 'MON DD, YY') "Publication Date1",
       TO_CHAR(pubdate, 'mm/dd/yyyy') "Publication Date2",
       TO_CHAR(retail, '$99.99') "Retail Price"
FROM books
WHERE category = 'COMPUTER';

SELECT INITCAP(amfirst) "First Name", INITCAP(amlast) "Last Name", 
        TO_CHAR(amedate, 'MON DD, YYYY') "Employment Date",
        TO_CHAR(amsal, '$999,999.99') "Salary"
FROM acctmanager;

SELECT TO_CHAR(sysdate, 'Mon DD, yyyy, HH:MI:SS')
FROM dual;

SELECT title, pubdate,
       TO_NUMBER(TO_CHAR(sysdate,'YYYY')) - TO_NUMBER(TO_CHAR(pubdate,'yyyy')) "Years"
FROM books
WHERE category = 'COMPUTER';

---- Other Functions -----
SELECT title, retail, discount, retail-discount,
       retail - NVL(discount, 0) "Sales Prices"
FROM books;

SELECT order#, orderdate, NVL2(shipdate, 'Shipped', 'Not Shipped') "Status"
FROM orders
WHERE shipstate = 'FL';

SELECT customer#, state,
       DECODE (state, 'CA', .0725,
                      'FL', .06,
                      'GA', .04,
                            0) "Sales Tax Rate"
FROM customers
WHERE state IN ('CA', 'FL', 'GA');

DESC employees;
SELECT *
FROM employees;

SELECT empno, lname, fname,
       ROUND(MONTHS_BETWEEN(sysdate, hiredate)/12, 2) "Years",
       CASE WHEN MONTHS_BETWEEN(sysdate, hiredate)/12 < 5 THEN 'Level 1'
            WHEN MONTHS_BETWEEN(sysdate, hiredate)/12 < 9 THEN 'Level 2'
            WHEN MONTHS_BETWEEN(sysdate, hiredate)/12 < 13 THEN 'Level 3'
            WHEN MONTHS_BETWEEN(sysdate, hiredate)/12 < 17 THEN 'Level 4'
            ELSE 'Level 5'
       END "Retirement Level"     
FROM employees;

SELECT customer#, state,
       CASE WHEN state = 'CA' THEN 0.0725
            WHEN state = 'FL' THEN 0.06
            WHEN state = 'GA' THEN .04
            ELSE 0
        END "Sales Tax Rate"
FROM customers
WHERE state IN ('CA', 'FL', 'GA');


