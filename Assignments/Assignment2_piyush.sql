
-- PART I: SQL Queries
-- 1. Create EMPLOYEES table
CREATE TABLE EMPLOYEES (
    Emp# NUMERIC(5),
    Lastname VARCHAR2(12),
    Firstname VARCHAR2(12),
    Job_class VARCHAR2(4)
);

-- 2. Add EmpDate and EndDate columns
ALTER TABLE EMPLOYEES
ADD (
    EmpDate DATE DEFAULT SYSDATE,
    EndDate DATE
);

-- 3. Modify Job_class column
ALTER TABLE EMPLOYEES
MODIFY Job_class VARCHAR2(6);

-- 4. Delete EndDate column
ALTER TABLE EMPLOYEES
DROP COLUMN EndDate;

-- 5. Create JL_EMPS table
CREATE TABLE JL_EMPS AS
SELECT Emp#, Lastname, Firstname
FROM EMPLOYEES;

-- 6. Truncate JL_EMPS table
TRUNCATE TABLE JL_EMPS;

-- 7. Delete JL_EMPS table permanently
DROP TABLE JL_EMPS PURGE;

-- 8. Delete EMPLOYEES table (can be restored)
DROP TABLE EMPLOYEES;

-- 9. Restore EMPLOYEES table
-- Note: Specific restore command depends on the database system
FLASHBACK TABLE EMPLOYEES TO BEFORE DROP;

-- PART II: SQL Queries
-- 1. Create CATEGORY table and populate it
CREATE TABLE CATEGORY (
    CatCode CHAR(3) PRIMARY KEY,
    CatDesc VARCHAR2(14) NOT NULL
);

INSERT INTO CATEGORY (CatCode, CatDesc) VALUES ('BUS', 'BUSINESS');
INSERT INTO CATEGORY (CatCode, CatDesc) VALUES ('CHN', 'CHILDREN');
INSERT INTO CATEGORY (CatCode, CatDesc) VALUES ('COK', 'COOKING');
INSERT INTO CATEGORY (CatCode, CatDesc) VALUES ('COM', 'COMPUTER');
INSERT INTO CATEGORY (CatCode, CatDesc) VALUES ('FAL', 'FAMILY LIFE');
INSERT INTO CATEGORY (CatCode, CatDesc) VALUES ('FIT', 'FITNESS');
INSERT INTO CATEGORY (CatCode, CatDesc) VALUES ('SEH', 'SELF HELP');
INSERT INTO CATEGORY (CatCode, CatDesc) VALUES ('LIT', 'LITERATURE');

-- 2. Add CatCode column to BOOKS table
ALTER TABLE BOOKS
ADD CatCode CHAR(3);

-- 3. Add foreign key constraint and set CatCode values
ALTER TABLE BOOKS
ADD CONSTRAINT books_catcode_fk FOREIGN KEY (CatCode)
REFERENCES CATEGORY(CatCode);

UPDATE BOOKS b
SET CatCode = (
    SELECT c.CatCode
    FROM CATEGORY c
    WHERE c.CatDesc = b.Category
);

-- 4. Verify categories in BOOKS table
SELECT * FROM BOOKS;

-- 5. Save changes
COMMIT;

-- 6. Delete Category column from BOOKS table
ALTER TABLE BOOKS
DROP COLUMN Category;

-- 7. Create CATEGORY1 table and drop CATEGORY
CREATE TABLE CATEGORY1 AS
SELECT * FROM CATEGORY;

DROP TABLE CATEGORY CASCADE CONSTRAINTS;
