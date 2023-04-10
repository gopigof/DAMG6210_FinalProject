-------------------------------------------------------------------------------------------
-- Sequence Cleanup
DECLARE
    sequence_names SYS.DBMS_DEBUG_VC2COLL := SYS.DBMS_DEBUG_VC2COLL('CUSTOMER_ID_SEQ', 'BRANCH_ID_SEQ', 'LOAN_TYPE_SEQ', 'LOAN_ID_SEQ',
        'ACCOUNT_TYPE_SEQ', 'ACCOUNT_ID_SEQ', 'ROLE_ID_SEQ', 'EMPLOYEE_ID_SEQ', 'TRANSACTION_TYPE_SEQ', 'TRANSACTION_ID_SEQ');
    sequence_not_exist EXCEPTION;
    PRAGMA EXCEPTION_INIT (sequence_not_exist , -02289);
BEGIN
    DBMS_OUTPUT.ENABLE;
    FOR i IN sequence_names.FIRST..sequence_names.LAST LOOP
        BEGIN
            DBMS_OUTPUT.PUT_LINE('Dropping Sequence: ' || sequence_names(i));
            EXECUTE IMMEDIATE('DROP SEQUENCE ' || sequence_names(i));
        EXCEPTION
            WHEN sequence_not_exist THEN DBMS_OUTPUT.PUT_LINE('Sequence ' || sequence_names(i) || ' doesnt exist');
        END;
    END LOOP;
END;
/
-------------------------------------------------------------------------------------------
CREATE SEQUENCE CUSTOMER_ID_SEQ      -- creating sequences for customer table 

  MINVALUE 1800 

  MAXVALUE 2500 

  START WITH 1800 

  INCREMENT BY 5 

  CACHE 20;

CREATE SEQUENCE BRANCH_ID_SEQ      -- creating sequences for branch table 

  MINVALUE 3600 

  MAXVALUE 4000 

  START WITH 3600

  INCREMENT BY 1 

  CACHE 20;
  
CREATE SEQUENCE LOAN_TYPE_SEQ      -- creating sequences for loan_type table 

  MINVALUE 1 

  MAXVALUE 10 

  START WITH 1 

  INCREMENT BY 1 

  CACHE 20;
  
CREATE SEQUENCE LOAN_ID_SEQ      -- creating sequences for loan table 

  MINVALUE 500 

  MAXVALUE 1000 

  START WITH 500 

  INCREMENT BY 1 

  CACHE 20; 
  
CREATE SEQUENCE ACCOUNT_TYPE_SEQ      -- creating sequences for  account type table 

  MINVALUE 1 

  MAXVALUE 10 

  START WITH 1 

  INCREMENT BY 1 

  CACHE 20;  

CREATE SEQUENCE ACCOUNT_ID_SEQ      -- creating sequences for  account table 

  MINVALUE 100 

  MAXVALUE 2000 

  START WITH 101 

  INCREMENT BY 1 

  CACHE 20;
  
CREATE SEQUENCE ROLE_ID_SEQ      -- creating sequences for role table 

  MINVALUE 1 

  MAXVALUE 10 

  START WITH 1 

  INCREMENT BY 1 

  CACHE 20;

CREATE SEQUENCE EMPLOYEE_ID_SEQ      -- creating sequences for employee table 

  MINVALUE 608 

  MAXVALUE 2000 

  START WITH 608 

  INCREMENT BY 3 

  CACHE 20;
  
CREATE SEQUENCE TRANSACTION_TYPE_SEQ      -- creating sequences for transaction type table 

  MINVALUE 1 

  MAXVALUE 20 

  START WITH 1 

  INCREMENT BY 1 

  CACHE 20;
  
CREATE SEQUENCE TRANSACTION_ID_SEQ      -- creating sequences for transaction table 

  MINVALUE 10000 

  MAXVALUE 20000 

  START WITH 10001 

  INCREMENT BY 1 

  CACHE 20;
-------------------------------------------------------------------------------------------

-- Table Cleanup
DECLARE
    table_names SYS.DBMS_DEBUG_VC2COLL := SYS.DBMS_DEBUG_VC2COLL('CUSTOMER', 'BRANCH', 'LOAN_TYPE', 'LOAN',
        'ACCOUNT_TYPE', 'ACCOUNTS', 'ROLE_TABLE', 'EMPLOYEE', 'STATUS_CODE', 'TRANSACTION_TYPE', 'TRANSACTION_TABLE');
    table_not_exist EXCEPTION;
    PRAGMA EXCEPTION_INIT (table_not_exist , -00942);
BEGIN
    DBMS_OUTPUT.ENABLE;
    FOR i IN table_names.FIRST..table_names.LAST LOOP
        BEGIN
            DBMS_OUTPUT.PUT_LINE('Dropping Table: ' || table_names(i));
            EXECUTE IMMEDIATE('DROP TABLE ' || table_names(i) ||' CASCADE CONSTRAINTS');
        EXCEPTION
                WHEN table_not_exist THEN DBMS_OUTPUT.PUT_LINE('Table ' || table_names(i) || ' doesnt exist');
        END;
    END LOOP;
END;
/
-------------------------------------------------------------------------------------------
-- Table Creation
CREATE TABLE CUSTOMER
(
    CUSTOMER_ID     NUMBER DEFAULT CUSTOMER_ID_SEQ.NEXTVAL PRIMARY KEY,
    FIRST_NAME      VARCHAR(20)  NOT NULL,
    LAST_NAME       VARCHAR(20)  NOT NULL,
    DATE_OF_BIRTH   DATE         NOT NULL,
    EMAIL_ID        VARCHAR(30)  NOT NULL UNIQUE,
    PHONE_NUMBER    VARCHAR(10)  NOT NULL UNIQUE,
    DATE_REGISTERED DATE         NOT NULL,
    ANNUAL_INCOME   NUMBER,
    LOGIN           VARCHAR(10)  NOT NULL,
    PASSWORD_HASH   VARCHAR(300) NOT NULL,
    ADDRESS         VARCHAR(50),
    CITY            VARCHAR(20),
    STATE_NAME      VARCHAR(20)
);

CREATE TABLE BRANCH
(
    BRANCH_ID    NUMBER DEFAULT BRANCH_ID_SEQ.NEXTVAL PRIMARY KEY,
    BRANCH_NAME  VARCHAR(25) NOT NULL,
    BRANCH_CODE  VARCHAR(10) NOT NULL UNIQUE,
    ADDRESS      VARCHAR(50) NOT NULL,
    CITY         VARCHAR(20) NOT NULL,
    STATE_NAME   VARCHAR(20) NOT NULL,
    PHONE_NUMBER VARCHAR(10),
    EMAIL_ID     VARCHAR(30)
);

CREATE TABLE LOAN_TYPE
(
    LOAN_TYPE_ID     NUMBER DEFAULT LOAN_TYPE_SEQ.NEXTVAL PRIMARY KEY,
    LOAN_TYPE        VARCHAR(20) NOT NULL UNIQUE,
    LOAN_DESCRIPTION VARCHAR(80)
);

CREATE TABLE LOAN
(
    LOAN_ID           NUMBER DEFAULT LOAN_ID_SEQ.NEXTVAL PRIMARY KEY,
    CUSTOMER_ID       NUMBER REFERENCES CUSTOMER (CUSTOMER_ID),
    LOAN_TYPE         NUMBER REFERENCES LOAN_TYPE (LOAN_TYPE_ID),
    BRANCH_ID         NUMBER REFERENCES BRANCH (BRANCH_ID),
    AMOUNT            VARCHAR(50) NOT NULL,
    INTEREST_RATE     FLOAT       NOT NULL,
    TERM_IN_MONTHS    INTEGER     NOT NULL,
    COMMENCEMENT_DATE DATE        NOT NULL
);

CREATE TABLE ACCOUNT_TYPE
(
    ACCOUNT_TYPE_ID NUMBER DEFAULT ACCOUNT_TYPE_SEQ.NEXTVAL PRIMARY KEY,
    ACCOUNT_TYPE    VARCHAR(50) NOT NULL UNIQUE,
    INTEREST_RATE   FLOAT       NOT NULL
);

CREATE TABLE ACCOUNTS
(
    ACCOUNT_ID   NUMBER DEFAULT ACCOUNT_ID_SEQ.NEXTVAL PRIMARY KEY,
    CUSTOMER_ID  NUMBER REFERENCES CUSTOMER (CUSTOMER_ID),
    ACCOUNT_TYPE NUMBER REFERENCES ACCOUNT_TYPE (ACCOUNT_TYPE_ID),
    BRANCH_ID    NUMBER REFERENCES BRANCH (BRANCH_ID),
    CREATED_DATE DATE        NOT NULL,
    BALANCE      INTEGER     NOT NULL,
    CARD_DETAILS NUMBER      NOT NULL,
    PROOF        VARCHAR(30) NOT NULL
);

CREATE TABLE ROLE_TABLE
(
    ROLE_ID       NUMBER DEFAULT ROLE_ID_SEQ.NEXTVAL PRIMARY KEY,
    POSITION_NAME VARCHAR(20) NOT NULL UNIQUE,
    SALARY        FLOAT       NOT NULL
);

CREATE TABLE EMPLOYEE
(
    EMPLOYEE_ID     NUMBER DEFAULT EMPLOYEE_ID_SEQ.NEXTVAL PRIMARY KEY,
    BRANCH_ID       NUMBER REFERENCES BRANCH (BRANCH_ID),
    ROLE_ID         NUMBER REFERENCES ROLE_TABLE (ROLE_ID),
    FIRST_NAME      VARCHAR(20)  NOT NULL,
    LAST_NAME       VARCHAR(20)  NOT NULL,
    DATE_OF_BIRTH   DATE         NOT NULL,
    EMAIL_ID        VARCHAR(30)  NOT NULL UNIQUE,
    PHONE_NUMBER    VARCHAR(10)  NOT NULL UNIQUE,
    DATE_REGISTERED DATE         NOT NULL,
    LOGIN           VARCHAR(10)  NOT NULL,
    PASSWORD_HASH   VARCHAR(300) NOT NULL,
    ADDRESS         VARCHAR(50),
    CITY            VARCHAR(20),
    STATE_NAME      VARCHAR(20),
    MANAGER_ID      NUMBER       NOT NULL
);

CREATE TABLE STATUS_CODE
(
    STATUS_CODE             VARCHAR(20) PRIMARY KEY,
    STATUS_CODE_DESCRIPTION VARCHAR(50)
);

CREATE TABLE TRANSACTION_TYPE
(
    TRANSACTION_TYPE_ID          NUMBER DEFAULT TRANSACTION_TYPE_SEQ.NEXTVAL PRIMARY KEY,
    TRANSACTION_TYPE             VARCHAR(20) NOT NULL UNIQUE,
    TRANSACTION_TYPE_DESCRIPTION VARCHAR(50)
);

CREATE TABLE TRANSACTION_TABLE
(
    TRANSACTION_ID      NUMBER DEFAULT TRANSACTION_ID_SEQ.NEXTVAL PRIMARY KEY,
    ACCOUNT_ID          NUMBER REFERENCES ACCOUNTS (ACCOUNT_ID),
    STATUS_CODE         VARCHAR(20) REFERENCES STATUS_CODE (STATUS_CODE),
    TRANSACTION_TYPE    NUMBER REFERENCES TRANSACTION_TYPE (TRANSACTION_TYPE_ID),
    AMOUNT              INTEGER     NOT NULL,
    TIME_STAMP          TIMESTAMP   NOT NULL,
    TRANSACTION_DETAILS CLOB        NOT NULL,
    STATUS              VARCHAR(30) NOT NULL
);
-------------------------------------------------------------------------------------------