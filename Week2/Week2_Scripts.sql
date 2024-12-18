----------------- Week 2 Class -----------------------
-- or /*  */ are used to make comments on SQL Scripts
-- is for this line only. Two hiphens make sure anything come after that in the same line are comments, not command
/* must be closed with */ -- everything enclosed in /* */ is comment (runs multiple lines)

------------ Part I ---------------------------------
SELECT table_name
FROM user_tables;                       -- user_tables is a part of data dictionary for your database, managed by DBMS (not by the users)

SELECT *                                -- Select all columns in the CUSTOMERS table
FROM customers;

SELECT *
FROM customers
WHERE rownum <= 2;                      -- Select top 2 records

SELECT title                            -- Select one column from the BOOKS table
FROM books;

SELECT isbn, title, pubdate             -- Select multiple columns
FROM books;

---- Column Alias (using AS is optional)
SELECT title AS Book_Title              -- Displayed query result has now Book_Title as the column heading 
FROM books;

SELECT title "Title of Book"            -- Now, the case (lower/upper) and space of the alias are kept in the query result
FROM books;

SELECT title "Title of Book? Yes!"      -- Space, Symbol, Case retained
FROM books;

---- Aristhmetic Operation
SELECT 1+4
FROM dual;                              -- DUAL is a fake table name we use when there's no table needed to perform the SELECT clause

SELECT title, retail, cost, retail-cost as profit       -- profit is used as the column heading for retail - cost
FROM books;

---- NULL values
SELECT title, retail, discount, retail - discount       -- operation result will be null if a component in the operation is null
FROM books;

---- DISTINCT or UNIQUE (they're the same): supress duplicates in the query result
SELECT DISTINCT state
FROM customers;

SELECT UNIQUE category
FROM books;

---- Concatenation
DESC customers;

SELECT firstname, lastname
FROM customers;

SELECT firstname || lastname
FROM customers;

SELECT firstname || ' ' || lastname         -- let's add space between first and last name: the resulting column heading is horrible
FROM customers;

SELECT firstname || ' ' || lastname "Customer Name"    -- let's give a new name to the concatenated result
FROM customers;



-------------- Part II -----------------------------
CREATE TABLE acctmanager
(amid CHAR(4),
 amfirst VARCHAR(12),
 amlast VARCHAR(12),
 amedate DATE DEFAULT SYSDATE,
 amsal NUMBER(8,2),
 amcomm NUMBER(7,2) DEFAULT 0,
 amearn AS (amsal + amcomm),            -- virtual columns do not exist physically
 region CHAR(2)
 );

SELECT table_name
FROM user_tables;                       -- data dictionary that contains all table information

DESCRIBE acctmanager;

SELECT *
FROM acctmanager;                       -- nothings in the table yet since we didn't insert any data

SELECT column_name, data_type, data_default
FROM user_tab_columns                   -- this data dictionary provides column informatoin of a table
WHERE table_name = 'ACCTMANAGER';

CREATE TABLE test_invis
(col1 CHAR(1),
 col2 NUMBER(4) INVISIBLE);
 
DESC test_invis;                       -- the result doesn't display col2 because it is set invisible 
 
SELECT *
FROM test_invis;                       -- displays only col1
 
SELECT col1, col2                      -- if you give a direct column reference, it will show
FROM test_invis;

SELECT column_name, hidden_column
FROM user_tab_cols                      -- data dictionary containing info of whether a column is hidden or not
WHERE table_name = 'TEST_INVIS';        -- "YES' for the hidden column

SELECT *
FROM user_tab_cols
WHERE table_name = 'TEST_INVIS';

---- Create TAble by using Subquery
CREATE TABLE cust_mkt
AS (SELECT customer#, city, state, zip, referred, region    -- mandatory to use AS
    FROM customers);
    
DESC cust_mkt;

SELECT *
FROM cust_mkt;

---- Modifying existing tables
DESC publisher;

ALTER TABLE publisher
ADD (ext NUMBER(4));                  -- parenthesis is optional when adding just one column

ALTER TABLE publisher
DROP COLUMN ext;

ALTER TABLE publisher
ADD (ext1 NUMBER(4), 
     ext2 NUMBER(3));                  -- must use parentheses when adding two or more columns

ALTER TABLE publisher
DROP COLUMN ext2;

ALTER TABLE publisher
RENAME COLUMN ext1 TO ext;              -- renaming column is easy, but not recommended in many practices

ALTER TABLE publisher
DROP COLUMN ext;

ALTER TABLE publisher
DROP COLUMN pubid;                      -- get an error: can't remove primary key column

---- ALTER the column configuration from an existing table
SELECT title
FROM books;

SELECT max(length(title))
FROM books;

DESC books;

ALTER TABLE books
MODIFY title VARCHAR2(30);

ALTER TABLE books
MODIFY title VARCHAR2(20);              -- get error when trying to reduce the size

ALTER TABLE books
MODIFY title VARCHAR2(40);              -- increasing works

ALTER TABLE books
MODIFY title VARCHAR2(30);              -- dcreasing the size works this time becuase the max length of the existing data is 30

ALTER TABLE books
MODIFY retail NUMBER(5,1);              -- decreasing the size doesn't work if numeric column already conatins any data

ALTER TABLE books
MODIFY retail NUMBER(6,2);              -- increasing the size works though for numeric data

ALTER TABLE books
MODIFY retail NUMBER(5,2);              -- decreasing the size doesn't work if numeric column already conatins any data

ALTER TABLE books
ADD test_col NUMBER(5,2);

ALTER TABLE books
MODIFY test_col NUMBER(4,2);            -- now, reducing the number size works because test_col doesn't contain any data value yet

---- Setting Default value doesn't change existing data
ALTER TABLE publisher
ADD rating CHAR(1);

SELECT *
FROM publisher;

ALTER TABLE publisher
MODIFY rating DEFAULT 'N';

SELECT column_name, data_type, data_default
FROM user_tab_columns
WHERE table_name = 'PUBLISHER';

DESC publisher;

DESC test_invis;

ALTER TABLE test_invis
MODIFY col2 VISIBLE;                        -- change the column to be visible

SELECT column_name, data_type, hidden_column
FROM user_tab_cols
WHERE table_name = 'TEST_INVIS';


---- Rename a Table
RENAME cust_mkt TO cust_mkt_2023;

SELECT table_name
FROM user_tables;

---- Truncate a Table
SELECT * 
FROM cust_mkt_2023;

TRUNCATE TABLE cust_mkt_2023;

SELECT * 
FROM cust_mkt_2023;                             -- no data records since all are truncated

---- Drop and Recover a Table
DROP TABLE cust_mkt_2023;

SELECT *
FROM cust_mkt_2023;                             -- eerror because the table no longer exists

SELECT table_name                               -- now the table cust_mkt_2023 is gone
FROM user_tables;

SELECT object_name,original_name                
FROM recyclebin;                                -- dropped table is placed in a recycle bin and can be restored - both table structure and data - if PURGE is not used when dropping the table

FLASHBACK TABLE cust_mkt_2023                   -- this command recoveres the table and data from recycle bin
TO BEFORE DROP;

DESC cust_mkt_2023;                             -- the table is restored

PURGE TABLE "BIN$EAUNueKT+8bgY6UWAAqpUw==$0";   -- this command permanantly eliminates the object in the recyclebin. Must use object name, not the table name.

PURGE recyclebin;                               -- empty the recyclebin

SELECT object_name, original_name
FROM recyclebin;                                -- after PURGE recyclebin, nothing left in the recyclebin

DROP TABLE test_invis PURGE;                    -- permanantly deletes the table without any trace in recyclebin if PURGE option is used

SELECT table_name
FROM user_tables;                               -- TEST_INVIS gone

SELECT object_name, original_name
FROM recyclebin;                                -- nothing in the recycle bin

DROP TABLE acctmanager;

PURGE TABLE acctmanager;                   -- we can use table's original name instead of its object_name

SELECT object_name, original_name
FROM recyclebin;                    

---------------------------------------------- Eliminating All We Have for Clean Start -------
DROP TABLE acctmanager PURGE;   -- we created this in class
DROP TABLE orderitems PURGE;
DROP TABLE bookauthor PURGE;
DROP TABLE author PURGE;
DROP TABLE books PURGE;
DROP TABLE orders PURGE;
DROP TABLE publisher PURGE;
DROP TABLE customers PURGE;
