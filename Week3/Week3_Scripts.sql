-------------------- Week 3 Scripts -------------------
------ We learn about Constraints (DDL) this week -----
-------------------------------------------------------

--- Create Constratins at the Column Level: define the Constraint with column definition
CREATE TABLE test1
(column1 NUMBER(3) CONSTRAINT test1_column1_pk PRIMARY KEY,     -- setting column1 as a primary key for table 1
 column2 VARCHAR2(12) NOT NULL,
 column3 NUMBER(5,2)
 );

CREATE TABLE test1_1
(column1 NUMBER(3) PRIMARY KEY,     -- we can omit 'CONSTRAINT constraint_name', but it's not a good practice
 column2 VARCHAR2(12) NOT NULL,
 column3 NUMBER(5,2)
 );
 
 -- now let's check if we have two constraints on table 1
 DESC test1;            -- Both column1 and 2 are set to 'NOT NULL'
 DESC test1_1;
 
 --- Create Constraints at the Table Level: define the constraint at the end of Table creationg command
 CREATE TABLE test2
 (column1 NUMBER(3),
  column2 VARCHAR2(12) NOT NULL,        -- NOT NULL constraint must be set at the column level
  column3 NUMBER(5),
  column4 VARCHAR2(6),
   CONSTRAINT test2_column1_pk PRIMARY KEY (column1),       -- column1 will be a primary key
   CONSTRAINT test2_column3_4_uk UNIQUE (column3, column4)  -- column 3 and 4 will have UNIQUE constraints (when setting a constraint for multiple columns, it must be done at the table level)
);   

DESC test2;             -- unique constraints won't show here

--- Composite primary key
CREATE TABLE test3
 (column1 NUMBER(3),
  column2 NUMBER(4),
  column3 VARCHAR2(12) NOT NULL,
  column4 VARCHAR2(6),
   CONSTRAINT test3_column1_2_pk PRIMARY KEY (column1, column2),  -- column11 and 2 will be a composite primary key
   CONSTRAINT test3_column4_uk UNIQUE (column4)
);


----- Adding Constraints to Existing Tables 
CREATE TABLE customers1         -- let's create a test table CUSTOMERS1 by using subquery
AS (SELECT *                    -- do you think all constratins will be copied to CUSTOMERS1 from CUSTOMERS?
    FROM customers);

SELECT * FROM customers1; 

SELECT constraint_name, constraint_type, search_condition
FROM user_constraints
WHERE table_name = 'CUSTOMERS';             -- you will see 4 constraints in CUSTOMERS

SELECT constraint_name, constraint_type, search_condition
FROM user_constraints
WHERE table_name = 'CUSTOMERS1';            -- only 2 constraints in CUSTOMERS1: only NOT NULL constraints are copied

-- so, let's add Priamry key constraitn to CUSTOMERS1
ALTER TABLE customers1
ADD CONSTRAINT customers1_customer#_pk PRIMARY KEY (customer#); -- CONSTRAINT constraint_name is optional, but it's a good habit to name it all the time

SELECT constraint_name, constraint_type, search_condition
FROM user_constraints
WHERE table_name = 'CUSTOMERS1';            -- now it has Primary key constraitn too!


---- Let's check if Constraitns are working well 
INSERT INTO customers1 (customer#, lastname, firstname, region)
VALUES(1020, 'PADDY', 'JACK', 'NE');           -- get error message because customer# 1020 already exists in the table

INSERT INTO customers1 (customer#, lastname, firstname, region)
VALUES(1021, 'PADDY', 'JACK', 'NE');           -- this works as we don't have customer# 1021 in CUSTOMERS1

SELECT *
FROM customers1;

---- Adding a Composite Primary Key
CREATE TABLE orderitems1
AS (SELECT *
    FROM orderitems);
    
SELECT constraint_name, constraint_type, search_condition
FROM user_constraints
WHERE table_name = 'ORDERITEMS1';       -- as expected, PK constraint is not copied, so let's add next

ALTER TABLE orderitems1
ADD CONSTRAINT orderitems1_order#_item#_pk PRIMARY KEY (order#, item#);  -- must add them at once since a table can have only one PK constraint

---- Can I add multiple constraints to an existing table?
SELECT constraint_name, constraint_type, search_condition
FROM user_constraints
WHERE table_name = 'ACCTMANAGER';

ALTER TABLE acctmanager
ADD (CONSTRAINT acctmanager_amid_pk PRIMARY KEY (amid),         -- Yes, you can
     CONSTRAINT acctmanager_amedate_uk UNIQUE (amedate)
);


---- Addding Foreign Key Constraint
SELECT constraint_name, constraint_type, search_condition
FROM user_constraints
WHERE table_name = 'ORDERITEMS1';       -- no foreign key constraint yet

ALTER TABLE orderitems1
ADD (CONSTRAINT orderitems1_order#_fk FOREIGN KEY (order#)
        REFERENCES orders (order#),
     CONSTRAINT orderitems1_isbn_fk FOREIGN KEY (isbn)
        REFERENCES books (isbn));        

SELECT constraint_name, constraint_type, search_condition, r_constraint_name
FROM user_constraints
WHERE table_name = 'ORDERITEMS1';       -- Two 'R' Constraint_type: R represents Foreign Key constraint

--XXXXX (checking user_constraints for foreign key's reference)
-- testing if Foreign key is working as expcted
INSERT INTO orderitems1
VALUES (1030, 1, 1059831198, 2, 30.00);    -- get error: integrity constraint violated because there's no order# 1030 in ORDERS table


--- Deletion of Foreign Key Values
SELECT constraint_name, constraint_type, search_condition, r_constraint_name
FROM user_constraints
WHERE table_name = 'BOOKAUTHOR';       -- one of the foreign key constraints referencing ORDERS

SELECT * FROM author;

DELETE FROM author
WHERE authorid = 'S100';            -- can't delete due to BOOKAUTHOR' foriegn key set on authorid

SELECT *
FROM bookauthor
WHERE authorid = 'S100';        -- 3 records are referencing authorid S100

ALTER TABLE bookauthor
DROP CONSTRAINT bookauthor_authorid_fk;   -- let's drop the FK constraint and reset

ALTER TABLE bookauthor
ADD CONSTRAINT bookauthor_authorid_fk FOREIGN KEY(authorid)
        REFERENCES author(authorid) ON DELETE CASCADE;
        
DELETE FROM author
WHERE authorid = 'S100';        -- now we can delete

SELECT * 
FROM bookauthor
WHERE authorid = 'S100';           -- 3 records (referencing authorid S100) are gone


----- Deletion of Parent Table -----
DROP TABLE author;          -- can't drop the parent table because it has a child (BOOKAUTHOR)

SELECT constraint_name, constraint_type
FROM user_constraints
WHERE table_name = 'BOOKAUTHOR';        -- AUTHORID# FK references AUTHOR's authorid

DROP TABLE author CASCADE CONSTRAINTS;  -- drops FK constraint in BOOKAUTHOR, then drops AUTHOR

SELECT constraint_name, constraint_type
FROM user_constraints
WHERE table_name = 'BOOKAUTHOR';        -- Now, AUTHORID# FK is gone


------ UNIQUE Constraint -----
SELECT constraint_name, constraint_type
FROM user_constraints
WHERE table_name = 'BOOKS'; 

ALTER TABLE books
ADD CONSTRAINT books_title_uk UNIQUE (title);

SELECT *
FROM books;

INSERT INTO books (isbn, title)
VALUES ('1111111111', 'SHORTEST POEMS');    -- error due to Unique constraint on title


----- CHECK Constraint -----
SELECT constraint_name, constraint_type, search_condition
FROM user_constraints
WHERE table_name = 'ORDERS';

ALTER TABLE orders
ADD CONSTRAINT orders_shipdate_ck CHECK (shipdate >= orderdate);

ALTER TABLE orders
ADD CONSTRAINT orders_shipdate_ck1 CHECK (shipdate <= orderdate);  -- error: constraint violates existing data

ALTER TABLE acctmanager
ADD CONSTRAINT acctmanager_region_ck CHECK (region IN ('NE','SE','NW','SW'));

SELECT constraint_name, constraint_type, search_condition
FROM user_constraints
WHERE table_name = 'ACCTMANAGER';


----- NOT NULL Constraint -----

SELECT constraint_name, constraint_type, search_condition
FROM user_constraints
WHERE table_name = 'ORDERS';

ALTER TABLE orders
MODIFY customer# CONSTRAINT orders_customer#_nn NOT NULL;


ALTER TABLE acctmanager
MODIFY (amfirst NOT NULL,
        amlast NOT NULL);
        
        

----- Class Practice -----
--CREATE TABLE dept                 -- this is column-level approach
--(deptid NUMBER(2) CONSTRAINT dept_deptid_pk PRIMARY KEY,
-- dname VARCHAR2(20) CONSTRAINT dept_dname_uk UNIQUE NOT NULL,
-- fax VARCHAR2(12)
-- );
 
CREATE TABLE dept                       -- always create parent table first!!!
(deptid NUMBER(2),
 dname VARCHAR2(20) NOT NULL,
 fax VARCHAR2(12),
 CONSTRAINT dept_deptid_pk PRIMARY KEY (deptid),        -- PK constraint on deptid
 CONSTRAINT dept_dname_uk UNIQUE (dname)                -- UNIQUE constraint on dname
 );

CREATE TABLE etypes
(etypeid NUMBER(3),
 etypename VARCHAR2(20) NOT NULL,
 CONSTRAINT etypes_etypeid_pk PRIMARY KEY (etypeid),    -- PK constraint on etypeid
 CONSTRAINT etypes_etypename_uk UNIQUE (etypename)      -- UNIQUE constraint on etypename
 );
 
CREATE TABLE equip
(equipid NUMBER(3),
 edesc VARCHAR2(30),
 purchdate DATE,
 rating CHAR(1),
 deptid NUMBER(2) NOT NULL,
 etypeid NUMBER(3),
 CONSTRAINT equip_equipid_pk PRIMARY KEY (equipid),     -- PK constraint on equipid
 CONSTRAINT equip_deptid_fk FOREIGN KEY (deptid)        -- FK constraint on deptid
    REFERENCES dept (deptid),
 CONSTRAINT equip_etypeid_fk FOREIGN KEY (etypeid)      -- FK constraint on etypeid
    REFERENCES etypes (etypeid),
 CONSTRAINT equip_rating_ck CHECK (rating IN ('A', 'B', 'C'))   -- CHECK constraint on rating
 );
 

----- Viewing Constraints using USER_CONSTRAINTS
SELECT constraint_name, constraint_type, search_condition, r_constraint_name, status
FROM user_constraints                   -- great for specifics about constraints
WHERE table_name = 'EQUIP';

SELECT constraint_name, column_name
FROM user_cons_columns                  -- includes specific column name asspciated with the constraint
WHERE table_name = 'EQUIP';

----- Disable / Enable Constraints -----
ALTER TABLE equip
DISABLE CONSTRAINT equip_rating_ck;     -- Disable the CHECK constraint on the raiting column

SELECT constraint_name, constraint_type, search_condition, status   -- status shows whether the constraint is enabled/disabled
FROM user_constraints
WHERE table_name = 'EQUIP';

ALTER TABLE equip
ENABLE CONSTRAINT equip_rating_ck;     -- Disable the CHECK constraint on the raiting column


----- Dropping Constraints -----
SELECT constraint_name, constraint_type, search_condition
FROM user_constraints
WHERE table_name = 'TEST1';

ALTER TABLE test1
DROP PRIMARY KEY;

SELECT constraint_name, constraint_type, search_condition
FROM user_constraints
WHERE table_name = 'TEST2';

SELECT constraint_name, column_name
FROM user_cons_columns
WHERE table_name = 'TEST2';

SELECT constraint_name, column_name
FROM user_cons_columns
WHERE table_name = 'TEST2';

ALTER TABLE test2
DROP UNIQUE (column3);          -- shouldn't work because column 3 and 4 are considered as a set in its UNIQUE constraint

ALTER TABLE test2
DROP UNIQUE (column3, column4); -- now it should work since all columns involved in the same UNIQUE constraint are listed

SELECT constraint_name, constraint_type, search_condition
FROM user_constraints
WHERE table_name = 'TEST3';

ALTER TABLE test3
DROP UNIQUE (column4);

ALTER TABLE test3
DROP CONSTRAINT sys_c0031601;

ALTER TABLE test3                   
DROP CONSTRAINT test3_column1_pk;   -- this syntax applies to all constraints

-------------------------
ALTER TABLE equip
DROP CONSTRAINT equip_rating_ck;

SELECT constraint_name, constraint_type, search_condition, r_constraint_name
FROM user_constraints
WHERE table_name = 'EQUIP';

ALTER TABLE dept
DROP PRIMARY KEY;       -- error: child table EQUIP is referencing this primary key

ALTER TABLE dept
DROP PRIMARY KEY CASCADE;   -- removes EQUIP's FK, then drops DEPT's PK


------------------------------------------------------------------------------
---- If you want to initialize all, run the following and run JLDB_Build_w3.sql
DROP TABLE customers1 PURGE;
DROP TABLE orderitems1 PURGE;
DROP TABLE test1 PURGE;
DROP TABLE test2 PURGE;
DROP TABLE test3 PURGE;
DROP TABLE test1_1 PURGE;
DROP TABLE dept CASCADE CONSTRAINTS PURGE;
DROP TABLE etypes CASCADE CONSTRAINTS PURGE;
DROP TABLE equip PURGE;
