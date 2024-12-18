SELECT table_name FROM user_tables;



CREATE TABLE acctmanager (
amid CHAR(4),
amfirst varchar(12),
amlast varchar(12),
amedate date default sysdate,
amsal number(8,2),
amcomm number(7,2) default 0,
amearn as (amsal + amcomm),
region char(2)

);


desc acctmanager;


select * from user_tab_cols where table_name = 'ACCTMANAGER';


SELECT *                                -- Select all columns in the CUSTOMERS table
FROM customers;


SELECT 
    CONSTRAINT_NAME,
    CONSTRAINT_TYPE,
    SEARCH_CONDITION AS CHECK_CONDITION
FROM 
    ALL_CONSTRAINTS
WHERE 
    TABLE_NAME = 'CUSTOMER1';
    
    
create table customer1 as (select * from customers);    

alter table customer1

add constraint customer1_customer_pk primary key (customer#);

drop table CUSTOMER1;

SELECT *
FROM 
    ALL_CONSTRAINTS
WHERE 
    TABLE_NAME = 'ORDERITEMS';
    
    
    
Alter table BOOKS

Modify (TITLE varchar2(40));

DESCRIBE BOOKS;


Alter table BOOKS

Modify (TITLE varchar2(50));

DESCRIBE BOOKS;
