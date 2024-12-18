------------------------ Week 7 Initializing Script ----------------------------
---- It is okay to see error messages from DROP TABLE at the beginning ---------
---- 14 Tables will be created as a result -------------------------------------

DROP TABLE CUSTOMERS CASCADE CONSTRAINTS;
DROP TABLE ORDERS CASCADE CONSTRAINTS;
DROP TABLE PUBLISHER CASCADE CONSTRAINTS;
DROP TABLE AUTHOR CASCADE CONSTRAINTS;
DROP TABLE BOOKS CASCADE CONSTRAINTS;
DROP TABLE ORDERITEMS CASCADE CONSTRAINTS;
DROP TABLE BOOKAUTHOR CASCADE CONSTRAINTS;
DROP TABLE PROMOTION CASCADE CONSTRAINTS;
DROP TABLE ACCTMANAGER CASCADE CONSTRAINTS;
DROP TABLE ACCTBONUS CASCADE CONSTRAINTS;
DROP TABLE CONTACTS PURGE;
DROP TABLE EMPLOYEES PURGE;
DROP TABLE books_1 PURGE;
DROP TABLE books_2 PURGE;
COMMIT;

CREATE TABLE Customers
(Customer#  NUMBER(4),
LastName VARCHAR2(10) NOT NULL,
FirstName VARCHAR2(10) NOT NULL,
Address VARCHAR2(20),
City VARCHAR2(12),
State VARCHAR2(2),
Zip VARCHAR2(5),
Referred NUMBER(4),
Region CHAR(2),
Email VARCHAR2(30),
  CONSTRAINT customers_customer#_pk PRIMARY KEY(customer#),
  CONSTRAINT customers_region_ck
                CHECK (region IN ('N', 'NW', 'NE', 'S', 'SE', 'SW', 'W', 'E')) );

INSERT INTO CUSTOMERS
VALUES (1001, 'MORALES', 'BONITA', 'P.O. BOX 651', 'EASTPOINT', 'FL', '32328', NULL, 'SE', 'bm225@sat.net');
INSERT INTO CUSTOMERS
VALUES (1002, 'THOMPSON', 'RYAN', 'P.O. BOX 9835', 'SANTA MONICA', 'CA', '90404', NULL, 'W', NULL);
INSERT INTO CUSTOMERS 
VALUES (1003, 'SMITH', 'LEILA', 'P.O. BOX 66', 'TALLAHASSEE', 'FL', '32306', NULL, 'SE', NULL); 
INSERT INTO CUSTOMERS 
VALUES (1004, 'PIERSON', 'THOMAS', '69821 SOUTH AVENUE', 'BOISE', 'ID', '83707', NULL, 'NW', 'tpier55@sat.net'); 
INSERT INTO CUSTOMERS 
VALUES (1005, 'GIRARD', 'CINDY', 'P.O. BOX 851', 'SEATTLE', 'WA', '98115', NULL, 'NW', 'cing101@zep.net'); 
INSERT INTO CUSTOMERS 
VALUES (1006, 'CRUZ', 'MESHIA', '82 DIRT ROAD', 'ALBANY', 'NY', '12211', NULL, 'NE', 'cruztop@axe.com'); 
INSERT INTO CUSTOMERS 
VALUES (1007, 'GIANA', 'TAMMY', '9153 MAIN STREET', 'AUSTIN', 'TX', '78710', 1003, 'SW', 'treetop@zep.net'); 
INSERT INTO CUSTOMERS 
VALUES (1008, 'JONES', 'KENNETH', 'P.O. BOX 137', 'CHEYENNE', 'WY', '82003', NULL, 'N', 'kenask@sat.net'); 
INSERT INTO CUSTOMERS 
VALUES (1009, 'PEREZ', 'JORGE', 'P.O. BOX 8564', 'BURBANK', 'CA', '91510', 1003, 'W', 'jperez@canet.com'); 
INSERT INTO CUSTOMERS 
VALUES (1010, 'LUCAS', 'JAKE', '114 EAST SAVANNAH', 'ATLANTA', 'GA', '30314', NULL, 'SE', NULL); 
INSERT INTO CUSTOMERS 
VALUES (1011, 'MCGOVERN', 'REESE', 'P.O. BOX 18', 'CHICAGO', 'IL', '60606', NULL, 'N', 'reesemc@sat.net');  
INSERT INTO CUSTOMERS 
VALUES (1012, 'MCKENZIE', 'WILLIAM', 'P.O. BOX 971', 'BOSTON', 'MA', '02110', NULL, 'NE', 'will2244@axe.net'); 
INSERT INTO CUSTOMERS 
VALUES (1013, 'NGUYEN', 'NICHOLAS', '357 WHITE EAGLE AVE.', 'CLERMONT', 'FL', '34711', 1006, 'SE', 'nguy33@sat.net'); 
INSERT INTO CUSTOMERS 
VALUES (1014, 'LEE', 'JASMINE', 'P.O. BOX 2947', 'CODY', 'WY', '82414', NULL, 'N', 'jaslee@sat.net'); 
INSERT INTO CUSTOMERS 
VALUES (1015, 'SCHELL', 'STEVE', 'P.O. BOX 677', 'MIAMI', 'FL', '33111', NULL, 'SE', 'sschell3@sat.net'); 
INSERT INTO CUSTOMERS 
VALUES (1016, 'DAUM', 'MICHELL', '9851231 LONG ROAD', 'BURBANK', 'CA', '91508', 1010, 'W', NULL); 
INSERT INTO CUSTOMERS 
VALUES (1017, 'NELSON', 'BECCA', 'P.O. BOX 563', 'KALMAZOO', 'MI', '49006', NULL, 'N', 'becca88@digs.com'); 
INSERT INTO CUSTOMERS 
VALUES (1018, 'MONTIASA', 'GREG', '1008 GRAND AVENUE', 'MACON', 'GA', '31206', NULL, 'SE', 'greg336@sat.net'); 
INSERT INTO CUSTOMERS 
VALUES (1019, 'SMITH', 'JENNIFER', 'P.O. BOX 1151', 'MORRISTOWN', 'NJ', '07962', 1003, 'NE', NULL); 
INSERT INTO CUSTOMERS 
VALUES (1020, 'FALAH', 'KENNETH', 'P.O. BOX 335', 'TRENTON', 'NJ', '08607', NULL, 'NE', 'Kfalah@sat.net'); 
 
CREATE TABLE Orders 
(Order# NUMBER(4), 
Customer# NUMBER(4), 
OrderDate DATE NOT NULL, 
ShipDate DATE, 
ShipStreet VARCHAR2(18), 
ShipCity VARCHAR2(15), 
ShipState VARCHAR2(2), 
ShipZip VARCHAR2(5),
ShipCost NUMBER(4,2),
  CONSTRAINT orders_order#_pk PRIMARY KEY(order#),
  CONSTRAINT orders_customer#_fk FOREIGN KEY (customer#)
    REFERENCES customers(customer#)); 
 
INSERT INTO ORDERS 
VALUES (1000,1005,TO_DATE('31-MAR-19','DD-MON-YY'),TO_DATE('02-APR-19','DD-MON-YY'),'1201 ORANGE AVE', 'SEATTLE', 'WA', '98114' , 2.00); 
INSERT INTO ORDERS 
VALUES (1001,1010,TO_DATE('31-MAR-19','DD-MON-YY'),TO_DATE('01-APR-19','DD-MON-YY'), '114 EAST SAVANNAH', 'ATLANTA', 'GA', '30314', 3.00); 
INSERT INTO ORDERS 
VALUES (1002,1011,TO_DATE('31-MAR-19','DD-MON-YY'),TO_DATE('01-APR-19','DD-MON-YY'),'58 TILA CIRCLE', 'CHICAGO', 'IL', '60605', 3.00); 
INSERT INTO ORDERS 
VALUES (1003,1001,TO_DATE('01-APR-19','DD-MON-YY'),TO_DATE('01-APR-19','DD-MON-YY'),'958 MAGNOLIA LANE', 'EASTPOINT', 'FL', '32328', 4.00); 
INSERT INTO ORDERS 
VALUES (1004,1020,TO_DATE('01-APR-19','DD-MON-YY'),TO_DATE('05-APR-19','DD-MON-YY'),'561 ROUNDABOUT WAY', 'TRENTON', 'NJ', '08601', NULL); 
INSERT INTO ORDERS 
VALUES (1005,1018,TO_DATE('01-APR-19','DD-MON-YY'),TO_DATE('02-APR-19','DD-MON-YY'), '1008 GRAND AVENUE', 'MACON', 'GA', '31206', 2.00); 
INSERT INTO ORDERS 
VALUES (1006,1003,TO_DATE('01-APR-19','DD-MON-YY'),TO_DATE('02-APR-19','DD-MON-YY'),'558A CAPITOL HWY.', 'TALLAHASSEE', 'FL', '32307', 2.00); 
INSERT INTO ORDERS 
VALUES (1007,1007,TO_DATE('02-APR-19','DD-MON-YY'),TO_DATE('04-APR-19','DD-MON-YY'), '9153 MAIN STREET', 'AUSTIN', 'TX', '78710', 7.00); 
INSERT INTO ORDERS 
VALUES (1008,1004,TO_DATE('02-APR-19','DD-MON-YY'),TO_DATE('03-APR-19','DD-MON-YY'), '69821 SOUTH AVENUE', 'BOISE', 'ID', '83707', 3.00); 
INSERT INTO ORDERS 
VALUES (1009,1005,TO_DATE('03-APR-19','DD-MON-YY'),TO_DATE('05-APR-19','DD-MON-YY'),'9 LIGHTENING RD.', 'SEATTLE', 'WA', '98110', NULL); 
INSERT INTO ORDERS 
VALUES (1010,1019,TO_DATE('03-APR-19','DD-MON-YY'),TO_DATE('04-APR-19','DD-MON-YY'),'384 WRONG WAY HOME', 'MORRISTOWN', 'NJ', '07960', 2.00); 
INSERT INTO ORDERS 
VALUES (1011,1010,TO_DATE('03-APR-19','DD-MON-YY'),TO_DATE('05-APR-19','DD-MON-YY'), '102 WEST LAFAYETTE', 'ATLANTA', 'GA', '30311', 2.00); 
INSERT INTO ORDERS 
VALUES (1012,1017,TO_DATE('03-APR-19','DD-MON-YY'),NULL,'1295 WINDY AVENUE', 'KALMAZOO', 'MI', '49002', 6.00); 
INSERT INTO ORDERS 
VALUES (1013,1014,TO_DATE('03-APR-19','DD-MON-YY'),TO_DATE('04-APR-19','DD-MON-YY'),'7618 MOUNTAIN RD.', 'CODY', 'WY', '82414', 2.00); 
INSERT INTO ORDERS 
VALUES (1014,1007,TO_DATE('04-APR-19','DD-MON-YY'),TO_DATE('05-APR-19','DD-MON-YY'), '9153 MAIN STREET', 'AUSTIN', 'TX', '78710', 3.00); 
INSERT INTO ORDERS 
VALUES (1015,1020,TO_DATE('04-APR-19','DD-MON-YY'),NULL,'557 GLITTER ST.', 'TRENTON', 'NJ', '08606', 2.00); 
INSERT INTO ORDERS 
VALUES (1016,1003,TO_DATE('04-APR-19','DD-MON-YY'),NULL,'9901 SEMINOLE WAY', 'TALLAHASSEE', 'FL', '32307', 2.00); 
INSERT INTO ORDERS 
VALUES (1017,1015,TO_DATE('04-APR-19','DD-MON-YY'),TO_DATE('05-APR-19','DD-MON-YY'),'887 HOT ASPHALT ST', 'MIAMI', 'FL', '33112', 3.00); 
INSERT INTO ORDERS 
VALUES (1018,1001,TO_DATE('05-APR-19','DD-MON-YY'),NULL,'95812 HIGHWAY 98', 'EASTPOINT', 'FL', '32328', NULL); 
INSERT INTO ORDERS 
VALUES (1019,1018,TO_DATE('05-APR-19','DD-MON-YY'),NULL, '1008 GRAND AVENUE', 'MACON', 'GA', '31206', 2.00); 
INSERT INTO ORDERS 
VALUES (1020,1008,TO_DATE('05-APR-19','DD-MON-YY'),NULL,'195 JAMISON LANE', 'CHEYENNE', 'WY', '82003', 2.00); 


CREATE TABLE Publisher 
(PubID NUMBER(2), 
Name VARCHAR2(23), 
Contact VARCHAR2(15), 
Phone VARCHAR2(12),
  CONSTRAINT publisher_pubid_pk PRIMARY KEY(pubid)); 
 
INSERT INTO PUBLISHER 
VALUES(1,'PRINTING IS US','TOMMIE SEYMOUR','000-714-8321'); 
INSERT INTO PUBLISHER 
VALUES(2,'PUBLISH OUR WAY','JANE TOMLIN','010-410-0010'); 
INSERT INTO PUBLISHER 
VALUES(3,'AMERICAN PUBLISHING','DAVID DAVIDSON','800-555-1211'); 
INSERT INTO PUBLISHER 
VALUES(4,'READING MATERIALS INC.','RENEE SMITH','800-555-9743'); 
INSERT INTO PUBLISHER 
VALUES(5,'REED-N-RITE','SEBASTIAN JONES','800-555-8284'); 
 
CREATE TABLE Author 
(AuthorID VARCHAR2(4), 
Lname VARCHAR2(10), 
Fname VARCHAR2(10),
  CONSTRAINT author_authorid_pk PRIMARY KEY(authorid)); 
 
INSERT INTO AUTHOR 
VALUES ('S100','SMITH', 'SAM'); 
INSERT INTO AUTHOR 
VALUES ('J100','JONES','JANICE'); 
INSERT INTO AUTHOR 
VALUES ('A100','AUSTIN','JAMES'); 
INSERT INTO AUTHOR 
VALUES ('M100','MARTINEZ','SHEILA'); 
INSERT INTO AUTHOR 
VALUES ('K100','KZOCHSKY','TAMARA'); 
INSERT INTO AUTHOR 
VALUES ('P100','PORTER','LISA'); 
INSERT INTO AUTHOR 
VALUES ('A105','ADAMS','JUAN'); 
INSERT INTO AUTHOR 
VALUES ('B100','BAKER','JACK');  
INSERT INTO AUTHOR 
VALUES ('P105','PETERSON','TINA'); 
INSERT INTO AUTHOR 
VALUES ('W100','WHITE','WILLIAM'); 
INSERT INTO AUTHOR 
VALUES ('W105','WHITE','LISA'); 
INSERT INTO AUTHOR 
VALUES ('R100','ROBINSON','ROBERT'); 
INSERT INTO AUTHOR 
VALUES ('F100','FIELDS','OSCAR'); 
INSERT INTO AUTHOR 
VALUES ('W110','WILKINSON','ANTHONY'); 
 
CREATE TABLE Books 
(ISBN VARCHAR2(10), 
Title VARCHAR2(30), 
PubDate DATE, 
PubID NUMBER (2), 
Cost NUMBER (5,2), 
Retail NUMBER (5,2), 
Discount NUMBER (4,2),
Category VARCHAR2(12),
  CONSTRAINT books_isbn_pk PRIMARY KEY(isbn),
  CONSTRAINT books_pubid_fk FOREIGN KEY (pubid)
    REFERENCES publisher (pubid)); 
 
INSERT INTO BOOKS 
VALUES ('1059831198','BODYBUILD IN 10 MINUTES A DAY',TO_DATE('21-JAN-15','DD-MON-YY'),4,18.75,30.95, NULL, 'FITNESS'); 
INSERT INTO BOOKS 
VALUES ('0401140733','REVENGE OF MICKEY',TO_DATE('14-DEC-15','DD-MON-YY'),1,14.20,22.00, NULL, 'FAMILY LIFE'); 
INSERT INTO BOOKS 
VALUES ('4981341710','BUILDING A CAR WITH TOOTHPICKS',TO_DATE('18-MAR-16','DD-MON-YY'),2,37.80,59.95, 3.00, 'CHILDREN'); 
INSERT INTO BOOKS 
VALUES ('8843172113','DATABASE IMPLEMENTATION',TO_DATE('04-JUN-13','DD-MON-YY'),3,31.40,55.95, NULL, 'COMPUTER'); 
INSERT INTO BOOKS 
VALUES ('3437212490','COOKING WITH MUSHROOMS',TO_DATE('28-FEB-14','DD-MON-YY'),4,12.50,19.95, NULL, 'COOKING'); 
INSERT INTO BOOKS 
VALUES ('3957136468','HOLY GRAIL OF ORACLE',TO_DATE('31-DEC-15','DD-MON-YY'),3,47.25,75.95, 3.80, 'COMPUTER'); 
INSERT INTO BOOKS 
VALUES ('1915762492','HANDCRANKED COMPUTERS',TO_DATE('21-JAN-15','DD-MON-YY'),3,21.80,25.00, NULL, 'COMPUTER'); 
INSERT INTO BOOKS 
VALUES ('9959789321','E-BUSINESS THE EASY WAY',TO_DATE('01-MAR-16','DD-MON-YY'),2,37.90,54.50, NULL, 'COMPUTER'); 
INSERT INTO BOOKS 
VALUES ('2491748320','PAINLESS CHILD-REARING',TO_DATE('17-JUL-14','DD-MON-YY'),5,48.00,89.95, 4.50, 'FAMILY LIFE'); 
INSERT INTO BOOKS 
VALUES ('0299282519','THE WOK WAY TO COOK',TO_DATE('11-SEP-14','DD-MON-YY'),4,19.00,28.75, NULL, 'COOKING'); 
INSERT INTO BOOKS 
VALUES ('8117949391','BIG BEAR AND LITTLE DOVE',TO_DATE('08-NOV-15','DD-MON-YY'),5,5.32,8.95, NULL, 'CHILDREN'); 
INSERT INTO BOOKS 
VALUES ('0132149871','HOW TO GET FASTER PIZZA',TO_DATE('11-NOV-16','DD-MON-YY'),4,17.85,29.95, 1.50, 'SELF HELP'); 
INSERT INTO BOOKS 
VALUES ('9247381001','HOW TO MANAGE THE MANAGER',TO_DATE('09-MAY-13','DD-MON-YY'),1,15.40,31.95, NULL,  'BUSINESS'); 
INSERT INTO BOOKS 
VALUES ('2147428890','SHORTEST POEMS',TO_DATE('01-MAY-15','DD-MON-YY'),5,21.85,39.95, NULL, 'LITERATURE'); 
 
CREATE TABLE ORDERITEMS 
     ( Order# NUMBER(4),
       Item# NUMBER(2),
       ISBN VARCHAR2(10),
       Quantity NUMBER(3) NOT NULL, 
       PaidEach NUMBER(5,2) NOT NULL,
      CONSTRAINT orderitems_pk PRIMARY KEY (order#, item#),
       CONSTRAINT orderitems_order#_fk FOREIGN KEY (order#)
             REFERENCES orders (order#) ,
       CONSTRAINT orderitems_isbn_fk FOREIGN KEY (isbn)
             REFERENCES books (isbn) ,
       CONSTRAINT oderitems_quantity_ck CHECK (quantity > 0) );
 
INSERT INTO ORDERITEMS 
VALUES (1000,1,'3437212490',1,19.95);  
INSERT INTO ORDERITEMS 
VALUES (1001,1,'9247381001',1,31.95);  
INSERT INTO ORDERITEMS 
VALUES (1001,2,'2491748320',1,85.45);  
INSERT INTO ORDERITEMS 
VALUES (1002,1,'8843172113',2,55.95);  
INSERT INTO ORDERITEMS 
VALUES (1003,1,'8843172113',1,55.95);  
INSERT INTO ORDERITEMS 
VALUES (1003,2,'1059831198',1,30.95); 
INSERT INTO ORDERITEMS 
VALUES (1003,3,'3437212490',1,19.95); 
INSERT INTO ORDERITEMS 
VALUES (1004,1,'2491748320',2,85.45); 
INSERT INTO ORDERITEMS 
VALUES (1005,1,'2147428890',1,39.95); 
INSERT INTO ORDERITEMS 
VALUES (1006,1,'9959789321',1,54.50); 
INSERT INTO ORDERITEMS 
VALUES (1007,1,'3957136468',3,72.15); 
INSERT INTO ORDERITEMS 
VALUES (1007,2,'9959789321',1,54.50); 
INSERT INTO ORDERITEMS 
VALUES (1007,3,'8117949391',1,8.95); 
INSERT INTO ORDERITEMS 
VALUES (1007,4,'8843172113',1,55.95); 
INSERT INTO ORDERITEMS 
VALUES (1008,1,'3437212490',2,19.95); 
INSERT INTO ORDERITEMS 
VALUES (1009,1,'3437212490',1,19.95); 
INSERT INTO ORDERITEMS 
VALUES (1009,2,'0401140733',1,22.00); 
INSERT INTO ORDERITEMS 
VALUES (1010,1,'8843172113',1,55.95); 
INSERT INTO ORDERITEMS 
VALUES (1011,1,'2491748320',1,85.45); 
INSERT INTO ORDERITEMS 
VALUES (1012,1,'8117949391',1,8.95); 
INSERT INTO ORDERITEMS 
VALUES (1012,2,'1915762492',2,25.00); 
INSERT INTO ORDERITEMS 
VALUES (1012,3,'2491748320',1,85.45); 
INSERT INTO ORDERITEMS 
VALUES (1012,4,'0401140733',1,22.00); 
INSERT INTO ORDERITEMS 
VALUES (1013,1,'8843172113',1,55.95); 
INSERT INTO ORDERITEMS 
VALUES (1014,1,'0401140733',2,22.00); 
INSERT INTO ORDERITEMS 
VALUES (1015,1,'3437212490',1,19.95); 
INSERT INTO ORDERITEMS 
VALUES (1016,1,'2491748320',1,85.45); 
INSERT INTO ORDERITEMS 
VALUES (1017,1,'8117949391',2,8.95); 
INSERT INTO ORDERITEMS 
VALUES (1018,1,'3437212490',1,19.95); 
INSERT INTO ORDERITEMS 
VALUES (1018,2,'8843172113',1,55.95); 
INSERT INTO ORDERITEMS 
VALUES (1019,1,'0401140733',1,22.00); 
INSERT INTO ORDERITEMS 
VALUES (1020,1,'3437212490',1,19.95); 
 
CREATE TABLE BOOKAUTHOR 
(ISBN VARCHAR2(10), 
 AuthorID VARCHAR2(4),
  CONSTRAINT bookauthor_pk PRIMARY KEY (isbn, authorid),
  CONSTRAINT bookauthor_isbn_fk FOREIGN KEY (isbn)
             REFERENCES books (isbn),
  CONSTRAINT bookauthor_authorid_fk FOREIGN KEY (authorid)
             REFERENCES author (authorid)); 
 
INSERT INTO BOOKAUTHOR 
VALUES ('1059831198','S100'); 
INSERT INTO BOOKAUTHOR 
VALUES ('1059831198','P100'); 
INSERT INTO BOOKAUTHOR 
VALUES ('0401140733','J100'); 
INSERT INTO BOOKAUTHOR 
VALUES ('4981341710','K100'); 
INSERT INTO BOOKAUTHOR 
VALUES ('8843172113','P105'); 
INSERT INTO BOOKAUTHOR 
VALUES ('8843172113','A100'); 
INSERT INTO BOOKAUTHOR 
VALUES ('8843172113','A105'); 
INSERT INTO BOOKAUTHOR 
VALUES ('3437212490','B100'); 
INSERT INTO BOOKAUTHOR 
VALUES ('3957136468','A100'); 
INSERT INTO BOOKAUTHOR 
VALUES ('1915762492','W100'); 
INSERT INTO BOOKAUTHOR 
VALUES ('1915762492','W105'); 
INSERT INTO BOOKAUTHOR 
VALUES ('9959789321','J100'); 
INSERT INTO BOOKAUTHOR 
VALUES ('2491748320','R100'); 
INSERT INTO BOOKAUTHOR 
VALUES ('2491748320','F100'); 
INSERT INTO BOOKAUTHOR 
VALUES ('2491748320','B100'); 
INSERT INTO BOOKAUTHOR 
VALUES ('0299282519','S100'); 
INSERT INTO BOOKAUTHOR 
VALUES ('8117949391','R100'); 
INSERT INTO BOOKAUTHOR 
VALUES ('0132149871','S100'); 
INSERT INTO BOOKAUTHOR 
VALUES ('9247381001','W100'); 
INSERT INTO BOOKAUTHOR 
VALUES ('2147428890','W105'); 
 
CREATE TABLE promotion 
(Gift  varchar2(15), 
 Minretail number(5,2), 
 Maxretail number(5,2)); 
 
INSERT into promotion 
 VALUES ('BOOKMARKER', 0, 12); 
INSERT into promotion 
 VALUES ('BOOK LABELS', 12.01, 25); 
INSERT into promotion 
 VALUES ('BOOK COVER', 25.01, 56); 
INSERT into promotion 
 VALUES ('FREE SHIPPING', 56.01, 999.99); 

CREATE TABLE acctmanager
(amid CHAR(4),
 amfirst VARCHAR2(12)  NOT NULL,
 amlast VARCHAR2(12)  NOT NULL,
 amedate DATE DEFAULT SYSDATE,
 amsal NUMBER(8,2),
 amcomm NUMBER(7,2) DEFAULT 0,
 region CHAR(2),
  CONSTRAINT acctmanager_amid_pk PRIMARY KEY (amid),
  CONSTRAINT acctmanager_region_ck
     CHECK (region IN ('N', 'NW', 'NE', 'S', 'SE', 'SW', 'W', 'E')));

INSERT INTO acctmanager                         
VALUES ('T500', 'NICK', 'TAYLOR', '05-SEP-20', 42000, 3500, 'NE');

INSERT INTO acctmanager 
VALUES ('J500', 'SAMMIE', 'JONES', DEFAULT, 39500, 2000, 'NW');

INSERT INTO acctmanager
VALUES ('L502', 'MANDY', 'LOPEZ', '15-OCT-20', 47000, 1500, 'S');

INSERT INTO acctmanager (amid, amfirst, amlast, amedate, amsal, amcomm, region)
VALUES ('B500', 'CHARLIE', 'BROWN', '01-AUG-20', 58000, 0, 'SW');

INSERT INTO acctmanager 
VALUES ('O500', 'PEG', 'O''HARA', DEFAULT, 46000, 2000, 'SW');

CREATE TABLE acctbonus
(amid CHAR(4),
 amsal NUMBER(8,2),
 region CHAR(2),
  CONSTRAINT acctbonus_amid_pk PRIMARY KEY (amid));

INSERT INTO acctbonus
SELECT amid, amsal, region
FROM acctmanager;  


CREATE TABLE contacts
  (name VARCHAR2(40));
INSERT INTO contacts
  VALUES('LaFodant,Mike,934-555-3493');
INSERT INTO contacts
  VALUES('Harris,Annette,727-555-2739');
INSERT INTO contacts
  VALUES('Crew,Ben,352-555-3638');
COMMIT;

CREATE TABLE Employees (
 EMPNO               NUMBER(4),
 LNAME               VARCHAR2(20),
 FNAME               VARCHAR2(15),
 JOB                 VARCHAR2(9),
 HIREDATE            DATE,
 DEPTNO              NUMBER(2) NOT NULL,
 MTHSAL              NUMBER(7,2),
 BONUS               NUMBER(6,2),
 MGR                 NUMBER(4),
 CONSTRAINT employees_empno_PK PRIMARY KEY (EMPNO));

INSERT INTO employees VALUES (7839,'KING','BEN', 'GTECH2',TO_DATE('10-NOV-06','DD-MON-YY'),10,6000,3000,NULL);
INSERT INTO employees VALUES (8888,'JONES','LARRY','MTech2',TO_DATE('15-MAR-09','DD-MON-YY'),10,4200,1200,7839);
INSERT INTO employees VALUES (7344,'SMITH','SAM','GTech1',TO_DATE('01-MAY-20','DD-MON-YY'),20,4900,1500,7839);
INSERT INTO employees VALUES (7355,'POTTS','JIM','GTech1',TO_DATE('15-OCT-15','DD-MON-YY'),20,4900,1900,7839);
INSERT INTO employees VALUES (8844,'STUART','SUE','MTech1',TO_DATE('01-MAY-12','DD-MON-YY'),10,3700,NULL,8888);
COMMIT;

Create table Books_1
(ISBN VARCHAR2(10), 
Title VARCHAR2(30), 
PubDate DATE, 
Retail NUMBER (5,2), 
Category VARCHAR2(12),
  CONSTRAINT books_1_isbn_pk PRIMARY KEY(isbn)); 
 INSERT INTO BOOKS_1
VALUES ('8843172113','DATABASE IMPLEMENTATION',TO_DATE('04-JUN-15','DD-MON-YY'),55.95, 'COMPUTER'); 
INSERT INTO BOOKS_1
VALUES ('3437212490','COOKING WITH MUSHROOMS',TO_DATE('28-FEB-16','DD-MON-YY'),19.95, 'COOKING'); 
INSERT INTO BOOKS_1 
VALUES ('3957136468','HOLY GRAIL OF ORACLE',TO_DATE('31-DEC-15','DD-MON-YY'),65.95, 'BUSINESS'); 
COMMIT;

Create table Books_2
(ISBN VARCHAR2(10), 
Title VARCHAR2(30), 
PubDate DATE, 
Retail NUMBER (5,2), 
Category VARCHAR2(12),
  CONSTRAINT books_2_isbn_pk PRIMARY KEY(isbn)); 
INSERT INTO BOOKS_2
VALUES ('8843172113','DATABASE IMPLEMENTATION',TO_DATE('04-JUN-15','DD-MON-YY'),55.95, 'COMPUTER'); 
INSERT INTO BOOKS_2 
VALUES ('3437212490','COOKING WITH MUSHROOMS',TO_DATE('28-FEB-16','DD-MON-YY'),29.95, 'COOKING'); 
INSERT INTO BOOKS_2 
VALUES ('3957136468','HOLY GRAIL OF ORACLE',TO_DATE('31-DEC-15','DD-MON-YY'),75.95, 'COMPUTER'); 
INSERT INTO BOOKS_2
VALUES ('1915762492','HANDCRANKED COMPUTERS',TO_DATE('21-JAN-15','DD-MON-YY'),25.00, 'COMPUTER'); 
INSERT INTO BOOKS_2
VALUES ('0299282519','THE WOK WAY TO COOK',TO_DATE('11-SEP-10','DD-MON-YY'),28.75, 'COOKING'); 
COMMIT;
