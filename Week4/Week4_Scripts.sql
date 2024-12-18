------------------------ Week 4 SQL Pracitce in Class --------------------------
---------------------- DML (Data Manipulation Language) ------------------------
DESC BOOKS;  

DESC acctmanager;   

INSERT INTO acctmanager
VALUES ('T500', 'NICK', 'TAYLOR', '05-SEP-20', 42000, 3500, 'NE');  -- the number & order of values must match the columns'

SELECT *
FROM acctmanager;       -- check Nick Taylor's record is inserted

INSERT INTO acctmanager (amid, amfirst, amlast, amsal, amcomm, region)  -- omitted the 'amedate' column
VALUES ('J500', 'Sammie', 'Jones', 39500, 2000, 'NW');      -- the mixed case in names will remain


SELECT *
FROM acctmanager;       -- Sammie Jones's names are in mixed case, and amedate is today (we didn't assign any value!)

---- Activating the DEFAULT option: we already practice one above (omitting value for a column with default option)
DELETE FROM acctmanager
WHERE amid = 'J500';

INSERT INTO acctmanager(amid, amfirst, amlast, amedate, amsal, amcomm, region)
VALUES ('J500', 'SAMMIE', 'JONES', DEFAULT, 39500, 2000, 'NW');     -- assign 'DEFAULT' keyword ensure the amedate's default value is inserted

DELETE FROM acctmanager
WHERE amid = 'J500';

INSERT INTO acctmanager(amid, amfirst, amlast, amedate, amsal, amcomm, region)
VALUES ('J500', 'SAMMIE', 'JONES', SYSDATE, 39500, 2000, 'NW');     -- or we can just type in the amedate's default value

SELECT * 
FROM acctmanager;


---- Inserting NULL Value -----
-- Option1 (omit column name)
INSERT INTO acctmanager (amid, amfirst, amlast, amedate, amsal, amcomm) -- region column is omitted
VALUES ('L500', 'MANDY', 'LOPEZ', '01-OCT-20', 47000, 1500);

-- Option2 (substitute two single quotes in VALUE clause)
INSERT INTO acctmanager             -- no column list: need to provide values for all columns
VALUES ('L501', 'MANDY', 'LOPEZ', '01-OCT-20', 47000, 1500, ''); -- place two single quotes where we want NULL

-- Option3 (use NULL keyword where the value for region column should be)
INSERT INTO acctmanager
VALUES ('L502', 'MANDY', 'LOPEZ', '01-OCT-20', 47000, 1500, NULL);

SELECT *
FROM acctmanager;

INSERT INTO acctmanager
VALUES ('L503', 'MANDY', '', '01-OCT-20', 47000, 1500, NULL);  -- error: can't enforce NULL to a column with NOT NULL constraint


---- ON NULL (Prevent overriding default value) ---------
SELECT column_name, data_default
FROM user_tab_columns
WHERE table_name = 'ACCTMANAGER';    -- amedate and amcomm have default settting (SYSDATE, 0)

ALTER TABLE acctmanager
MODIFY amsal DEFAULT ON NULL 0;     -- when NULL is deliberately inserted, amsal still takes Default value

INSERT INTO acctmanager (amid, amfirst, amlast, amedate, amsal, amcomm, region)
VALUES ('B500', 'CHARLIE', 'BROWN', '', NULL, 0, 'SW');

SELECT *
FROM acctmanager;           -- Charlie Brown's amedate is null, but amsal is 0 (NULL didn't override default value)

ALTER TABLE acctmanager
MODIFY amedate DEFAULT ON NULL SYSDATE;   -- when NULL already exists in the data, we can't set this.

SELECT column_name, data_default, default_on_null
FROM user_tab_columns
WHERE table_name = 'ACCTMANAGER';


---- Manage Virtual Column Input
DESC acctmanager;

ALTER TABLE acctmanager
ADD amearn AS (amsal + amcomm);

DESC acctmanager;

INSERT INTO acctmanager
VALUES ('D500', 'SCOTT', 'DAVIS', DEFAULT, 53000, 6000, 'SE', 59000);       -- error due to the virtual column value

INSERT INTO acctmanager
VALUES ('D500', 'SCOTT', 'DAVIS', DEFAULT, 53000, 6000, 'SE');  -- error due to the mismatch in the column and value counts

INSERT INTO acctmanager (amid, amfirst, amlast, amedate, amsal, amcomm, region)
VALUES ('D500', 'SCOTT', 'DAVIS', DEFAULT, 53000, 6000, 'SE');  -- now, it works

SELECT *
FROM acctmanager;

ALTER TABLE acctmanager
DROP COLUMN amearn;

---- Single Quote Value in Data: Peg O'Hara ----
--INSERT INTO acctmanager (amid, amfirst, amlast, amsal, amcomm, region)
--VALUES ('O500', 'PEG', 'O'Hara', 46000, 2000, 'SW');    -- error due to one single quote in O'Hara

INSERT INTO acctmanager (amid, amfirst, amlast, amsal, amcomm, region)
VALUES ('O500', 'PEG', 'O''Hara', 46000, 2000, 'SW');    -- now, it works with 2 single quotes


---- Inserting Data from an Existing Table -----
INSERT INTO acctbonus (amid, amsal, region)
(SELECT amid, amsal, region         -- parentheses are optional
 FROM acctmanager);

SELECT *
FROM acctbonus;

---- Modifying Existing Rows: UPDATE ----
SELECT *
FROM acctmanager;       -- Charlie Brown's amedate is Null and amsal is 0. Let's update.

UPDATE acctmanager
SET amedate = '01-AUG-20',
    amsal = 58000
WHERE amid = 'B500';

SELECT *
FROM acctmanager
WHERE amid = 'B500';

UPDATE acctmanager
SET amedate = '15-OCT-20',
    region = 'S'
WHERE amid = 'L500';    

SELECT *
FROM acctmanager
WHERE amid = 'L500';


----- Substitution Variable -------
DESC customers;

ALTER TABLE customers
ADD region CHAR(2);

UPDATE customers
SET region = '&Customer_Region'
WHERE state = '&Customer_State';
    
describe customers;

select * from user_cons_columns where table_name = 'CUSTOMERS';

select * from user_constraints where table_name = 'CUSTOMERS';



---- Deleting Rows ---------------
DELETE FROM acctmanager
WHERE amid = 'J500';

SELECT *
FROM acctmanager;

DELETE FROM acctmanager
WHERE amid IN ('L501', 'L502'); 


---- Transaction Control Statements --------
COMMIT;


---- DDL vs. DML ----
insert into bookauthor1 (SELECT *
    FROM bookauthor);

SELECT *
FROM bookauthor;

SELECT *
FROM bookauthor1;

TRUNCATE TABLE bookauthor1;

DELETE FROM bookauthor;

ROLLBACK;

---- Transaction Control Practice -----
SELECT *
FROM acctmanager;

UPDATE acctmanager
SET amcomm = 0;

SELECT *
FROM acctmanager;

COMMIT;         -- amcomm = 0 updates become permanant (can't be undone any more)
-------------------------------
UPDATE acctmanager
SET amcomm = 1000
WHERE amid = 'J500';

COMMIT;

UPDATE acctmanager
SET amcomm = 2000
WHERE amid = 'L500';

SAVEPOINT one;

UPDATE acctmanager
SET amcomm = 3000
WHERE amid = 'B500';

SAVEPOINT two;

UPDATE acctmanager
SET amcomm = 4000
WHERE amid = 'D500';

SELECT *
FROM acctmanager;

ROLLBACK;         -- reset all updates except for the first one before COMMIT  
ROLLBACK to one;  -- SAVEPOINTS need to be re-established: must rerun the above UPDATE and SAVEPOINTS commands before this 
ROLLBACK to two;  -- SAVEPOINTS need to be re-established: must rerun the above UPDATE and SAVEPOINTS commands before this       

