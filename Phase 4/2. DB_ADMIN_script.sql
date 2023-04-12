SET SERVEROUTPUT ON;
---------------------------------------------------------------------------------------------
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
---------------------------------------------------------------------------------------------

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
---------------------------------------------------------------------------------------------
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
---------------------------------------------------------------------------------------------
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
---------------------------------------------------------------------------------------------
-- Create Triggers
CREATE OR REPLACE TRIGGER transaction_success_debit
AFTER INSERT ON transaction_table
FOR EACH ROW
BEGIN

   IF (:new.transaction_type in (2, 4)) AND (:new.status = 'Completed') AND (:new.status_code = '00') THEN
      UPDATE accounts
      SET balance = balance - :new.amount
      WHERE account_id = :new.account_id;  
      
      DBMS_OUTPUT.PUT_LINE('Transaction ' || :new.transaction_id || ' was successful.');
      
   END IF;
END;
/

CREATE OR REPLACE TRIGGER transaction_success_receive
AFTER INSERT ON transaction_table
FOR EACH ROW 
DECLARE
   transfer_type CHAR(30);
BEGIN
   transfer_type := SUBSTR(:new.transaction_details, 1,13);
   IF (transfer_type = 'Transfer from') AND (:new.status = 'Completed') AND (:new.status_code = '00') AND (:new.transaction_type = 3) THEN
      UPDATE accounts
      SET balance = balance + :new.amount
      WHERE account_id = :new.account_id;
      
      DBMS_OUTPUT.PUT_LINE('Transaction ' || :new.transaction_id || ' was successful.');

   END IF;
END;
/

CREATE OR REPLACE TRIGGER transaction_success_transfer
AFTER INSERT ON transaction_table
FOR EACH ROW 
DECLARE
   transfer_type_suc CHAR(30);
BEGIN
   transfer_type_suc := SUBSTR(:new.transaction_details, 1,13);
   IF (transfer_type_suc != 'Transfer from') AND (:new.status = 'Completed') AND (:new.status_code = '00') AND (:new.transaction_type = 3) THEN
      UPDATE accounts
      SET balance = balance - :new.amount
      WHERE account_id = :new.account_id;
      
      DBMS_OUTPUT.PUT_LINE('Transaction ' || :new.transaction_id || ' was successful.');
      
   END IF;
END;
/

CREATE OR REPLACE TRIGGER transaction_success_credit
AFTER INSERT ON transaction_table
FOR EACH ROW
BEGIN
   IF (:new.status = 'Completed') AND (:new.status_code = '00') AND (:new.transaction_type = 1) THEN
      UPDATE accounts
      SET balance = balance + :new.amount
      WHERE account_id = :new.account_id;  
      
      DBMS_OUTPUT.PUT_LINE('Transaction ' || :new.transaction_id || ' was successful.');
      
   END IF;  
END;
/

CREATE OR REPLACE TRIGGER transaction_failure
AFTER INSERT ON transaction_table
FOR EACH ROW
BEGIN  
   IF (:new.status = 'Failed') THEN
      IF (:new.status_code = '06') THEN
         DBMS_OUTPUT.PUT_LINE('Transaction ' || :new.transaction_id || ' was unsuccessful due to some error.');
      END IF;
   
      IF (:new.status_code = '12') THEN
         DBMS_OUTPUT.PUT_LINE('Transaction ' || :new.transaction_id || ' was unsuccessful as it is an invalid transaction.');
      END IF;
   
      IF (:new.status_code = '13') THEN
         DBMS_OUTPUT.PUT_LINE('Transaction ' || :new.transaction_id || ' was unsuccessful because an invalid amount was entered.');
      END IF;
   
      IF (:new.status_code = '14') THEN
        DBMS_OUTPUT.PUT_LINE('Transaction ' || :new.transaction_id || ' was unsuccessful because of invalid card number.');
      END IF;
   
      IF (:new.status_code = '51') THEN
         DBMS_OUTPUT.PUT_LINE('Transaction ' || :new.transaction_id || ' was unsuccessful because of insufficient funds.');
      END IF;
   
      IF (:new.status_code = '54') THEN
         DBMS_OUTPUT.PUT_LINE('Transaction ' || :new.transaction_id || ' was unsuccessful because of expired card.');
      END IF;
      
   END IF;
END;
/
---------------------------------------------------------------------------------------------
-- Procedure to insert branch
CREATE OR REPLACE PROCEDURE ADD_NEW_BRANCH (
    p_branch_name  IN BRANCH.BRANCH_NAME%TYPE,
    p_branch_code  IN BRANCH.BRANCH_CODE%TYPE,
    p_address      IN BRANCH.ADDRESS%TYPE,
    p_city         IN BRANCH.CITY%TYPE,
    p_state_name   IN BRANCH.STATE_NAME%TYPE,
    p_phone_number IN BRANCH.PHONE_NUMBER%TYPE,
    p_email_id     IN BRANCH.EMAIL_ID%TYPE
)
IS
    v_branch_count NUMBER;
    branch_exists EXCEPTION;
BEGIN
    SELECT COUNT(*)
    INTO v_branch_count
    FROM BRANCH
    WHERE BRANCH_CODE = p_branch_code
    OR EMAIL_ID = p_email_id
    OR BRANCH_NAME = p_branch_name;

    IF v_branch_count > 0 THEN
        RAISE branch_exists;
    ELSE
        INSERT INTO BRANCH (BRANCH_NAME, BRANCH_CODE, ADDRESS, CITY, STATE_NAME, PHONE_NUMBER, EMAIL_ID)
        VALUES (p_branch_name, p_branch_code, p_address, p_city, p_state_name, p_phone_number, p_email_id);
    END IF;

EXCEPTION
    WHEN branch_exists THEN
        DBMS_OUTPUT.PUT_LINE('Branch already exists.');
END ADD_NEW_BRANCH;
/

-- Procedure to insert loan_type
CREATE OR REPLACE PROCEDURE ADD_NEW_LOAN_TYPE (
    p_loan_type        IN LOAN_TYPE.LOAN_TYPE%TYPE,
    p_loan_description IN LOAN_TYPE.LOAN_DESCRIPTION%TYPE
)
IS
    v_loan_type_count NUMBER;
    loan_type_exists EXCEPTION;
BEGIN
    SELECT COUNT(*)
    INTO v_loan_type_count
    FROM LOAN_TYPE
    WHERE LOAN_TYPE = p_loan_type;

    IF v_loan_type_count > 0 THEN
        RAISE loan_type_exists;
    ELSE
        INSERT INTO LOAN_TYPE (LOAN_TYPE, LOAN_DESCRIPTION)
        VALUES (p_loan_type, p_loan_description);
    END IF;

EXCEPTION
    WHEN loan_type_exists THEN
        DBMS_OUTPUT.PUT_LINE('Loan type already exists.');
END ADD_NEW_LOAN_TYPE;
/

-- Procedure to insert Account_Type
CREATE OR REPLACE PROCEDURE ADD_NEW_ACCOUNT_TYPE (
    p_account_type  IN ACCOUNT_TYPE.ACCOUNT_TYPE%TYPE,
    p_interest_rate IN ACCOUNT_TYPE.INTEREST_RATE%TYPE
)
IS
    v_account_type_count NUMBER;
    account_type_exists EXCEPTION;
BEGIN
    SELECT COUNT(*)
    INTO v_account_type_count
    FROM ACCOUNT_TYPE
    WHERE ACCOUNT_TYPE = p_account_type;

    IF v_account_type_count > 0 THEN
        RAISE account_type_exists;
    ELSE
        INSERT INTO ACCOUNT_TYPE (ACCOUNT_TYPE, INTEREST_RATE)
        VALUES (p_account_type, p_interest_rate);
    END IF;

    EXCEPTION
        WHEN account_type_exists THEN
            DBMS_OUTPUT.PUT_LINE('Account type already exists.');
END ADD_NEW_ACCOUNT_TYPE;
/

-- Procedure to insert Roles
CREATE OR REPLACE PROCEDURE ADD_NEW_ROLE (
    p_position_name IN ROLE_TABLE.POSITION_NAME%TYPE,
    p_salary        IN ROLE_TABLE.SALARY%TYPE
)
IS
    v_role_count NUMBER;
    role_exists EXCEPTION;
BEGIN
    SELECT COUNT(*)
    INTO v_role_count
    FROM ROLE_TABLE
    WHERE POSITION_NAME = p_position_name;

    IF v_role_count > 0 THEN
        RAISE role_exists;
    ELSE
        INSERT INTO ROLE_TABLE (POSITION_NAME, SALARY)
        VALUES (p_position_name, p_salary);
    END IF;

    EXCEPTION
        WHEN role_exists THEN
            DBMS_OUTPUT.PUT_LINE('Role already exists.');
END ADD_NEW_ROLE;
/

-- Procedure to insert Status_Code
CREATE OR REPLACE PROCEDURE ADD_NEW_STATUS_CODE (
    p_status_code             IN STATUS_CODE.STATUS_CODE%TYPE,
    p_status_code_description IN STATUS_CODE.STATUS_CODE_DESCRIPTION%TYPE
)
IS
    v_status_code_count NUMBER;
    status_code_exists EXCEPTION;
BEGIN
    SELECT COUNT(*)
    INTO v_status_code_count
    FROM STATUS_CODE
    WHERE STATUS_CODE = p_status_code;

    IF v_status_code_count > 0 THEN
        RAISE status_code_exists;
    ELSE
        INSERT INTO STATUS_CODE (STATUS_CODE, STATUS_CODE_DESCRIPTION)
        VALUES (p_status_code, p_status_code_description);
    END IF;

    EXCEPTION
        WHEN status_code_exists THEN
            DBMS_OUTPUT.PUT_LINE('Status code already exists.');
END ADD_NEW_STATUS_CODE;
/

-- Procedure to Insert transaction_type
CREATE OR REPLACE PROCEDURE ADD_NEW_TRANSACTION_TYPE (
    p_transaction_type             IN TRANSACTION_TYPE.TRANSACTION_TYPE%TYPE,
    p_transaction_type_description IN TRANSACTION_TYPE.TRANSACTION_TYPE_DESCRIPTION%TYPE
)
IS
    v_transaction_type_count NUMBER;
    transaction_type_exists EXCEPTION;
BEGIN
    SELECT COUNT(*)
    INTO v_transaction_type_count
    FROM TRANSACTION_TYPE
    WHERE TRANSACTION_TYPE = p_transaction_type;

    IF v_transaction_type_count > 0 THEN
        RAISE transaction_type_exists;
    ELSE
        INSERT INTO TRANSACTION_TYPE (TRANSACTION_TYPE, TRANSACTION_TYPE_DESCRIPTION)
        VALUES (p_transaction_type, p_transaction_type_description);
    END IF;

    EXCEPTION
        WHEN transaction_type_exists THEN
            DBMS_OUTPUT.PUT_LINE('Transaction type already exists.');
END ADD_NEW_TRANSACTION_TYPE;
/
------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE CUSTOMER_MGMT_PKG AS

    PROCEDURE ADD_NEW_CUSTOMER (
        p_first_name      IN CUSTOMER.FIRST_NAME%TYPE,
        p_last_name       IN CUSTOMER.LAST_NAME%TYPE,
        p_date_of_birth   IN CUSTOMER.DATE_OF_BIRTH%TYPE,
        p_email_id        IN CUSTOMER.EMAIL_ID%TYPE,
        p_phone_number    IN CUSTOMER.PHONE_NUMBER%TYPE,
        p_date_registered IN CUSTOMER.DATE_REGISTERED%TYPE,
        p_annual_income   IN CUSTOMER.ANNUAL_INCOME%TYPE,
        p_login           IN CUSTOMER.LOGIN%TYPE,
        p_password_hash   IN CUSTOMER.PASSWORD_HASH%TYPE,
        p_address         IN CUSTOMER.ADDRESS%TYPE,
        p_city            IN CUSTOMER.CITY%TYPE,
        p_state_name      IN CUSTOMER.STATE_NAME%TYPE
    );

    PROCEDURE UPDATE_CUSTOMER_DETAILS (
        p_customer_id     IN CUSTOMER.CUSTOMER_ID%TYPE,
        p_first_name      IN CUSTOMER.FIRST_NAME%TYPE DEFAULT NULL,
        p_last_name       IN CUSTOMER.LAST_NAME%TYPE DEFAULT NULL,
        p_date_of_birth   IN CUSTOMER.DATE_OF_BIRTH%TYPE DEFAULT NULL,
        p_email_id        IN CUSTOMER.EMAIL_ID%TYPE DEFAULT NULL,
        p_phone_number    IN CUSTOMER.PHONE_NUMBER%TYPE DEFAULT NULL,
        p_address         IN CUSTOMER.ADDRESS%TYPE DEFAULT NULL,
        p_city            IN CUSTOMER.CITY%TYPE DEFAULT NULL,
        p_state_name      IN CUSTOMER.STATE_NAME%TYPE DEFAULT NULL
    );

    FUNCTION GET_CUSTOMER_ACCOUNTS (
        p_customer_id IN ACCOUNTS.CUSTOMER_ID%TYPE
    ) RETURN SYS_REFCURSOR;

    FUNCTION GET_CUSTOMER_LOANS (
        p_customer_id IN LOAN.CUSTOMER_ID%TYPE
    ) RETURN SYS_REFCURSOR;
    
     FUNCTION GET_LIKELIEST_5_TRANSACTIONS (
        p_customer_id IN ACCOUNTS.CUSTOMER_ID%TYPE
    ) RETURN SYS_REFCURSOR;

    FUNCTION GET_LATEST_TRANSACTION (
        p_customer_id IN ACCOUNTS.CUSTOMER_ID%TYPE
    ) RETURN SYS_REFCURSOR;

END CUSTOMER_MGMT_PKG;
/

CREATE OR REPLACE PACKAGE BODY CUSTOMER_MGMT_PKG AS

    PROCEDURE ADD_NEW_CUSTOMER (
        p_first_name      IN CUSTOMER.FIRST_NAME%TYPE,
        p_last_name       IN CUSTOMER.LAST_NAME%TYPE,
        p_date_of_birth   IN CUSTOMER.DATE_OF_BIRTH%TYPE,
        p_email_id        IN CUSTOMER.EMAIL_ID%TYPE,
        p_phone_number    IN CUSTOMER.PHONE_NUMBER%TYPE,
        p_date_registered IN CUSTOMER.DATE_REGISTERED%TYPE,
        p_annual_income   IN CUSTOMER.ANNUAL_INCOME%TYPE,
        p_login           IN CUSTOMER.LOGIN%TYPE,
        p_password_hash   IN CUSTOMER.PASSWORD_HASH%TYPE,
        p_address         IN CUSTOMER.ADDRESS%TYPE,
        p_city            IN CUSTOMER.CITY%TYPE,
        p_state_name      IN CUSTOMER.STATE_NAME%TYPE
    ) IS
        v_customer_count NUMBER;
        customer_exists EXCEPTION;
    BEGIN
        SELECT COUNT(*)
        INTO v_customer_count
        FROM CUSTOMER
        WHERE EMAIL_ID = p_email_id
        OR LOGIN = p_login;

        IF v_customer_count > 0 THEN
            RAISE customer_exists;
        ELSE
            INSERT INTO CUSTOMER (FIRST_NAME, LAST_NAME, DATE_OF_BIRTH, EMAIL_ID, PHONE_NUMBER, DATE_REGISTERED, ANNUAL_INCOME, LOGIN, PASSWORD_HASH, ADDRESS, CITY, STATE_NAME)
            VALUES (p_first_name, p_last_name, p_date_of_birth, p_email_id, p_phone_number, p_date_registered, p_annual_income, p_login, p_password_hash, p_address, p_city, p_state_name);
        END IF;
    EXCEPTION
        WHEN customer_exists THEN
            DBMS_OUTPUT.PUT_LINE('Customer already exists.');
    END ADD_NEW_CUSTOMER;

    PROCEDURE UPDATE_CUSTOMER_DETAILS (
        p_customer_id     IN CUSTOMER.CUSTOMER_ID%TYPE,
        p_first_name      IN CUSTOMER.FIRST_NAME%TYPE DEFAULT NULL,
        p_last_name       IN CUSTOMER.LAST_NAME%TYPE DEFAULT NULL,
        p_date_of_birth   IN CUSTOMER.DATE_OF_BIRTH%TYPE DEFAULT NULL,
        p_email_id        IN CUSTOMER.EMAIL_ID%TYPE DEFAULT NULL,
        p_phone_number    IN CUSTOMER.PHONE_NUMBER%TYPE DEFAULT NULL,
        p_address         IN CUSTOMER.ADDRESS%TYPE DEFAULT NULL,
        p_city            IN CUSTOMER.CITY%TYPE DEFAULT NULL,
        p_state_name      IN CUSTOMER.STATE_NAME%TYPE DEFAULT NULL
    ) IS
    BEGIN
        UPDATE CUSTOMER
        SET FIRST_NAME = COALESCE(p_first_name, FIRST_NAME),
            LAST_NAME = COALESCE(p_last_name, LAST_NAME),
            DATE_OF_BIRTH = COALESCE(p_date_of_birth, DATE_OF_BIRTH),
            EMAIL_ID = COALESCE(p_email_id, EMAIL_ID),
            PHONE_NUMBER = COALESCE(p_phone_number, PHONE_NUMBER),
            ADDRESS = COALESCE(p_address, ADDRESS),
            CITY = COALESCE(p_city, CITY),
            STATE_NAME = COALESCE(p_state_name, STATE_NAME)
        WHERE CUSTOMER_ID = p_customer_id;
    END UPDATE_CUSTOMER_DETAILS;

    FUNCTION GET_CUSTOMER_ACCOUNTS (
        p_customer_id IN ACCOUNTS.CUSTOMER_ID%TYPE
    ) RETURN SYS_REFCURSOR IS
        v_accounts SYS_REFCURSOR;
    BEGIN
        OPEN v_accounts FOR
        SELECT ACCOUNT_ID, BALANCE FROM ACCOUNTS
        WHERE CUSTOMER_ID = p_customer_id;
        RETURN v_accounts;
    END GET_CUSTOMER_ACCOUNTS;
    
    FUNCTION GET_CUSTOMER_LOANS (
        p_customer_id IN LOAN.CUSTOMER_ID%TYPE
    ) RETURN SYS_REFCURSOR IS
        v_loans SYS_REFCURSOR;
    BEGIN
        OPEN v_loans FOR
            SELECT l.LOAN_ID, lt.LOAN_TYPE, l.AMOUNT
            FROM LOAN l
            INNER JOIN LOAN_TYPE lt
            ON l.LOAN_TYPE = lt.LOAN_TYPE_ID
            WHERE l.CUSTOMER_ID = p_customer_id;
        RETURN v_loans;
    END GET_CUSTOMER_LOANS;
    
    FUNCTION GET_LIKELIEST_5_TRANSACTIONS (
        p_customer_id IN ACCOUNTS.CUSTOMER_ID%TYPE
    ) RETURN SYS_REFCURSOR IS
        v_transactions SYS_REFCURSOR;
    BEGIN
        OPEN v_transactions FOR
        SELECT tt.TRANSACTION_ID, tt.TIME_STAMP, tt.AMOUNT, tt.TRANSACTION_DETAILS, tt.STATUS, tt.ACCOUNT_ID
        FROM TRANSACTION_TABLE tt
        INNER JOIN ACCOUNTS a ON tt.ACCOUNT_ID = a.ACCOUNT_ID
        WHERE a.CUSTOMER_ID = p_customer_id
        ORDER BY tt.TIME_STAMP DESC
        FETCH NEXT 5 ROWS ONLY;
        RETURN v_transactions;
    END GET_LIKELIEST_5_TRANSACTIONS;

    FUNCTION GET_LATEST_TRANSACTION (
        p_customer_id IN ACCOUNTS.CUSTOMER_ID%TYPE
    ) RETURN SYS_REFCURSOR IS
        v_latest_transaction SYS_REFCURSOR;
    BEGIN
        OPEN v_latest_transaction FOR
        SELECT tt.TRANSACTION_ID, tt.ACCOUNT_ID, tt.STATUS, tt.TIME_STAMP, tt.AMOUNT, tt.TRANSACTION_DETAILS
        FROM TRANSACTION_TABLE tt
        INNER JOIN ACCOUNTS a ON tt.ACCOUNT_ID = a.ACCOUNT_ID
        WHERE a.CUSTOMER_ID = p_customer_id
        ORDER BY tt.TIME_STAMP DESC
        FETCH NEXT 1 ROWS ONLY;
        
        RETURN v_latest_transaction;
    END GET_LATEST_TRANSACTION;

END CUSTOMER_MGMT_PKG;
/
---------------------------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE EMPLOYEE_MGMT_PKG IS

    PROCEDURE ADD_NEW_EMPLOYEE (
        p_branch_id       IN EMPLOYEE.BRANCH_ID%TYPE,
        p_role_id         IN EMPLOYEE.ROLE_ID%TYPE,
        p_first_name      IN EMPLOYEE.FIRST_NAME%TYPE,
        p_last_name       IN EMPLOYEE.LAST_NAME%TYPE,
        p_date_of_birth   IN EMPLOYEE.DATE_OF_BIRTH%TYPE,
        p_email_id        IN EMPLOYEE.EMAIL_ID%TYPE,
        p_phone_number    IN EMPLOYEE.PHONE_NUMBER%TYPE,
        p_date_registered IN EMPLOYEE.DATE_REGISTERED%TYPE,
        p_login           IN EMPLOYEE.LOGIN%TYPE,
        p_password_hash   IN EMPLOYEE.PASSWORD_HASH%TYPE,
        p_address         IN EMPLOYEE.ADDRESS%TYPE,
        p_city            IN EMPLOYEE.CITY%TYPE,
        p_state_name      IN EMPLOYEE.STATE_NAME%TYPE,
        p_manager_id      IN EMPLOYEE.MANAGER_ID%TYPE
    );

    PROCEDURE UPDATE_EMPLOYEE_DETAILS (
        p_employee_id    IN EMPLOYEE.EMPLOYEE_ID%TYPE,
        p_branch_id      IN EMPLOYEE.BRANCH_ID%TYPE DEFAULT NULL,
        p_role_id        IN EMPLOYEE.ROLE_ID%TYPE DEFAULT NULL,
        p_first_name     IN EMPLOYEE.FIRST_NAME%TYPE DEFAULT NULL,
        p_last_name      IN EMPLOYEE.LAST_NAME%TYPE DEFAULT NULL,
        p_date_of_birth  IN EMPLOYEE.DATE_OF_BIRTH%TYPE DEFAULT NULL,
        p_email_id       IN EMPLOYEE.EMAIL_ID%TYPE DEFAULT NULL,
        p_phone_number   IN EMPLOYEE.PHONE_NUMBER%TYPE DEFAULT NULL,
        p_address        IN EMPLOYEE.ADDRESS%TYPE DEFAULT NULL,
        p_city           IN EMPLOYEE.CITY%TYPE DEFAULT NULL,
        p_state_name     IN EMPLOYEE.STATE_NAME%TYPE DEFAULT NULL,
        p_manager_id     IN EMPLOYEE.MANAGER_ID%TYPE DEFAULT NULL
    );

    FUNCTION GET_EMPLOYEE_BY_ID (
        p_employee_id IN EMPLOYEE.EMPLOYEE_ID%TYPE
    ) RETURN EMPLOYEE%ROWTYPE;

    FUNCTION GET_EMPLOYEES_BY_ROLE (
        p_role_id IN EMPLOYEE.ROLE_ID%TYPE
    ) RETURN SYS_REFCURSOR;    

END EMPLOYEE_MGMT_PKG;
/

CREATE OR REPLACE PACKAGE BODY EMPLOYEE_MGMT_PKG IS

    PROCEDURE ADD_NEW_EMPLOYEE (
        p_branch_id       IN EMPLOYEE.BRANCH_ID%TYPE,
        p_role_id         IN EMPLOYEE.ROLE_ID%TYPE,
        p_first_name      IN EMPLOYEE.FIRST_NAME%TYPE,
        p_last_name       IN EMPLOYEE.LAST_NAME%TYPE,
        p_date_of_birth   IN EMPLOYEE.DATE_OF_BIRTH%TYPE,
        p_email_id        IN EMPLOYEE.EMAIL_ID%TYPE,
        p_phone_number    IN EMPLOYEE.PHONE_NUMBER%TYPE,
        p_date_registered IN EMPLOYEE.DATE_REGISTERED%TYPE,
        p_login           IN EMPLOYEE.LOGIN%TYPE,
        p_password_hash   IN EMPLOYEE.PASSWORD_HASH%TYPE,
        p_address         IN EMPLOYEE.ADDRESS%TYPE,
        p_city            IN EMPLOYEE.CITY%TYPE,
        p_state_name      IN EMPLOYEE.STATE_NAME%TYPE,
        p_manager_id      IN EMPLOYEE.MANAGER_ID%TYPE
    ) IS
        v_employee_count NUMBER;
        employee_exists EXCEPTION;
    BEGIN
        SELECT COUNT(*)
        INTO v_employee_count
        FROM EMPLOYEE
        WHERE EMAIL_ID = p_email_id
        OR LOGIN = p_login;

        IF v_employee_count > 0 THEN
            RAISE employee_exists;
        ELSE
            INSERT INTO EMPLOYEE (BRANCH_ID, ROLE_ID, FIRST_NAME, LAST_NAME, DATE_OF_BIRTH, EMAIL_ID, PHONE_NUMBER, DATE_REGISTERED, LOGIN, PASSWORD_HASH, ADDRESS, CITY, STATE_NAME, MANAGER_ID)
            VALUES (p_branch_id, p_role_id, p_first_name, p_last_name, p_date_of_birth, p_email_id, p_phone_number, p_date_registered, p_login, p_password_hash, p_address, p_city, p_state_name, p_manager_id);
        END IF;

        EXCEPTION
            WHEN employee_exists THEN
                RAISE_APPLICATION_ERROR(-20001, 'Employee already exists.');
    END ADD_NEW_EMPLOYEE;

    PROCEDURE UPDATE_EMPLOYEE_DETAILS (
        p_employee_id    IN EMPLOYEE.EMPLOYEE_ID%TYPE,
        p_branch_id      IN EMPLOYEE.BRANCH_ID%TYPE DEFAULT NULL,
        p_role_id        IN EMPLOYEE.ROLE_ID%TYPE DEFAULT NULL,
        p_first_name     IN EMPLOYEE.FIRST_NAME%TYPE DEFAULT NULL,
        p_last_name      IN EMPLOYEE.LAST_NAME%TYPE DEFAULT NULL,
        p_date_of_birth  IN EMPLOYEE.DATE_OF_BIRTH%TYPE DEFAULT NULL,
        p_email_id       IN EMPLOYEE.EMAIL_ID%TYPE DEFAULT NULL,
        p_phone_number   IN EMPLOYEE.PHONE_NUMBER%TYPE DEFAULT NULL,
        p_address        IN EMPLOYEE.ADDRESS%TYPE DEFAULT NULL,
        p_city           IN EMPLOYEE.CITY%TYPE DEFAULT NULL,
        p_state_name     IN EMPLOYEE.STATE_NAME%TYPE DEFAULT NULL,
        p_manager_id     IN EMPLOYEE.MANAGER_ID%TYPE DEFAULT NULL
    ) IS
    BEGIN
        UPDATE EMPLOYEE
        SET BRANCH_ID      = COALESCE(p_branch_id, BRANCH_ID),
            ROLE_ID        = COALESCE(p_role_id, ROLE_ID),
            FIRST_NAME     = COALESCE(p_first_name, FIRST_NAME),
            LAST_NAME      = COALESCE(p_last_name, LAST_NAME),
            DATE_OF_BIRTH  = COALESCE(p_date_of_birth, DATE_OF_BIRTH),
            EMAIL_ID       = COALESCE(p_email_id, EMAIL_ID),
            PHONE_NUMBER   = COALESCE(p_phone_number, PHONE_NUMBER),
            ADDRESS        = COALESCE(p_address, ADDRESS),
            CITY           = COALESCE(p_city, CITY),
            STATE_NAME     = COALESCE(p_state_name, STATE_NAME),
            MANAGER_ID     = COALESCE(p_manager_id, MANAGER_ID)
        WHERE EMPLOYEE_ID = p_employee_id;
    END UPDATE_EMPLOYEE_DETAILS;
    
    FUNCTION GET_EMPLOYEE_BY_ID (
        p_employee_id IN EMPLOYEE.EMPLOYEE_ID%TYPE
    ) RETURN EMPLOYEE%ROWTYPE IS
        v_employee EMPLOYEE%ROWTYPE;
    BEGIN
        SELECT *
        INTO v_employee
        FROM EMPLOYEE
        WHERE EMPLOYEE_ID = p_employee_id;

        RETURN v_employee;
    END GET_EMPLOYEE_BY_ID;

    FUNCTION GET_EMPLOYEES_BY_ROLE (
        p_role_id IN EMPLOYEE.ROLE_ID%TYPE
    ) RETURN SYS_REFCURSOR IS
        v_employees SYS_REFCURSOR;
    BEGIN
        OPEN v_employees FOR
            SELECT E.EMPLOYEE_ID, E.FIRST_NAME, E.LAST_NAME, B.BRANCH_NAME
            FROM EMPLOYEE E
            JOIN BRANCH B ON E.BRANCH_ID=B.BRANCH_ID
            WHERE E.ROLE_ID = p_role_id;
        RETURN v_employees;
    END GET_EMPLOYEES_BY_ROLE;
    
END EMPLOYEE_MGMT_PKG;
/
--------------------------------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE ACCOUNT_MGMT_PKG AS

    -- Add a new account if it doesn't already exist
    PROCEDURE ADD_NEW_ACCOUNT (
        p_customer_id      IN ACCOUNTS.CUSTOMER_ID%TYPE,
        p_account_type     IN ACCOUNTS.ACCOUNT_TYPE%TYPE,
        p_branch_id        IN ACCOUNTS.BRANCH_ID%TYPE,
        p_created_date     IN ACCOUNTS.CREATED_DATE%TYPE,
        p_balance          IN ACCOUNTS.BALANCE%TYPE,
        p_card_details     IN ACCOUNTS.CARD_DETAILS%TYPE,
        p_proof            IN ACCOUNTS.PROOF%TYPE
    );
    
    -- Check if an account exists by account ID
    FUNCTION ACCOUNT_EXISTS (
        p_account_id IN ACCOUNTS.ACCOUNT_ID%TYPE
    ) RETURN NUMBER;
    
    -- Get account balance for a specific account
    FUNCTION GET_ACCOUNT_BALANCE (
        p_account_id IN ACCOUNTS.ACCOUNT_ID%TYPE
    ) RETURN NUMBER;  
    
    FUNCTION GET_BANK_STATEMENT (
        p_account_id IN TRANSACTION_TABLE.ACCOUNT_ID%TYPE
    ) RETURN SYS_REFCURSOR;
    
    -- Get the latest transaction for a specific account
    FUNCTION GET_LATEST_TRANSACTION (
        p_account_id IN ACCOUNTS.ACCOUNT_ID%TYPE
    ) RETURN SYS_REFCURSOR;

    -- Get the last 5 transactions for a specific account
    FUNCTION GET_LIKELIEST_5_TRANSACTIONS (
        p_account_id IN ACCOUNTS.ACCOUNT_ID%TYPE
    ) RETURN SYS_REFCURSOR;

END ACCOUNT_MGMT_PKG;
/

CREATE OR REPLACE PACKAGE BODY ACCOUNT_MGMT_PKG AS

    PROCEDURE ADD_NEW_ACCOUNT (
        p_customer_id      IN ACCOUNTS.CUSTOMER_ID%TYPE,
        p_account_type     IN ACCOUNTS.ACCOUNT_TYPE%TYPE,
        p_branch_id        IN ACCOUNTS.BRANCH_ID%TYPE,
        p_created_date     IN ACCOUNTS.CREATED_DATE%TYPE,
        p_balance          IN ACCOUNTS.BALANCE%TYPE,
        p_card_details     IN ACCOUNTS.CARD_DETAILS%TYPE,
        p_proof            IN ACCOUNTS.PROOF%TYPE
    ) IS
        v_account_count NUMBER;
        account_exists EXCEPTION;
    BEGIN
        SELECT COUNT(*)
        INTO v_account_count
        FROM ACCOUNTS
        WHERE CUSTOMER_ID = p_customer_id AND ACCOUNT_TYPE = p_account_type;

        IF v_account_count > 0 THEN
            RAISE account_exists;
        ELSE
            INSERT INTO ACCOUNTS (
                CUSTOMER_ID, ACCOUNT_TYPE, BRANCH_ID, CREATED_DATE, BALANCE, CARD_DETAILS, PROOF
            )
            VALUES (
                p_customer_id, p_account_type, p_branch_id, p_created_date, p_balance, p_card_details, p_proof
            );
        END IF;

        EXCEPTION
            WHEN account_exists THEN
                RAISE_APPLICATION_ERROR(-20002, 'An account with the same customer ID and account type already exists.');
    END ADD_NEW_ACCOUNT;

    FUNCTION ACCOUNT_EXISTS (
        p_account_id IN ACCOUNTS.ACCOUNT_ID%TYPE
    ) RETURN NUMBER IS
        v_account_count NUMBER;
    BEGIN
        SELECT COUNT(*)
        INTO v_account_count
        FROM ACCOUNTS
        WHERE ACCOUNT_ID = p_account_id;

        IF v_account_count > 0 THEN
            RETURN 1;
        ELSE
            RETURN 0;
        END IF;
    END ACCOUNT_EXISTS;

    FUNCTION GET_ACCOUNT_BALANCE (
        p_account_id IN ACCOUNTS.ACCOUNT_ID%TYPE
    ) RETURN NUMBER IS
        v_balance NUMBER;
    BEGIN
        SELECT BALANCE
        INTO v_balance
        FROM ACCOUNTS
        WHERE ACCOUNT_ID = p_account_id;

        RETURN v_balance;
    END GET_ACCOUNT_BALANCE;
    
    FUNCTION GET_BANK_STATEMENT (
        p_account_id IN TRANSACTION_TABLE.ACCOUNT_ID%TYPE
    ) RETURN SYS_REFCURSOR IS
        v_statement SYS_REFCURSOR;
        v_start_date TIMESTAMP := TRUNC(SYSDATE, 'MONTH') - INTERVAL '1' MONTH;
        v_end_date TIMESTAMP := TRUNC(SYSDATE);
    BEGIN
        OPEN v_statement FOR
        SELECT tt.TRANSACTION_ID, tt.ACCOUNT_ID, tt.TIME_STAMP, tt.AMOUNT, tt.TRANSACTION_DETAILS, tt.STATUS
        FROM TRANSACTION_TABLE tt
        WHERE tt.ACCOUNT_ID = p_account_id
          AND tt.TIME_STAMP BETWEEN v_start_date AND v_end_date;

        RETURN v_statement;
    END GET_BANK_STATEMENT;
    
    FUNCTION GET_LATEST_TRANSACTION (
        p_account_id IN ACCOUNTS.ACCOUNT_ID%TYPE
    ) RETURN SYS_REFCURSOR IS
        v_latest_transaction SYS_REFCURSOR;
    BEGIN
        OPEN v_latest_transaction FOR
        SELECT *
        FROM TRANSACTION_TABLE
        WHERE ACCOUNT_ID = p_account_id
        ORDER BY TIME_STAMP DESC
        FETCH NEXT 1 ROWS ONLY;

        RETURN v_latest_transaction;
    END GET_LATEST_TRANSACTION;

    FUNCTION GET_LIKELIEST_5_TRANSACTIONS (
        p_account_id IN ACCOUNTS.ACCOUNT_ID%TYPE
    ) RETURN SYS_REFCURSOR IS
        v_last_5_transactions SYS_REFCURSOR;
    BEGIN
        OPEN v_last_5_transactions FOR
        SELECT *
        FROM TRANSACTION_TABLE
        WHERE ACCOUNT_ID = p_account_id
        ORDER BY TIME_STAMP DESC
        FETCH NEXT 5 ROWS ONLY;

        RETURN v_last_5_transactions;
    END GET_LIKELIEST_5_TRANSACTIONS;

END ACCOUNT_MGMT_PKG;
/
------------------------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE LOAN_MGMT_PKG AS
    -- Check if a loan exists
    FUNCTION LOAN_EXISTS (
        p_loan_id IN LOAN.LOAN_ID%TYPE
    ) RETURN NUMBER;
    
    -- Get loan details for a specific loan
    FUNCTION GET_LOAN_DETAILS (
        p_loan_id IN LOAN.LOAN_ID%TYPE
    ) RETURN SYS_REFCURSOR;

    -- Add a new loan
    PROCEDURE ADD_NEW_LOAN (
        p_customer_id IN LOAN.CUSTOMER_ID%TYPE,
        p_loan_type IN LOAN.LOAN_TYPE%TYPE,
        p_branch_id IN LOAN.BRANCH_ID%TYPE,
        p_amount IN LOAN.AMOUNT%TYPE,
        p_interest_rate IN LOAN.INTEREST_RATE%TYPE,
        p_term_in_months IN LOAN.TERM_IN_MONTHS%TYPE,
        p_commencement_date IN LOAN.COMMENCEMENT_DATE%TYPE
    );
    
    -- Update loan details
    PROCEDURE UPDATE_LOAN_DETAILS (
        p_loan_id IN LOAN.LOAN_ID%TYPE,
        p_amount IN LOAN.AMOUNT%TYPE DEFAULT NULL,
        p_interest_rate IN LOAN.INTEREST_RATE%TYPE DEFAULT NULL,
        p_term_in_months IN LOAN.TERM_IN_MONTHS%TYPE DEFAULT NULL,
        p_commencement_date IN LOAN.COMMENCEMENT_DATE%TYPE DEFAULT NULL
    );
    
END LOAN_MGMT_PKG;
/

CREATE OR REPLACE PACKAGE BODY LOAN_MGMT_PKG AS
    -- Check if a loan exists
    FUNCTION LOAN_EXISTS (
        p_loan_id IN LOAN.LOAN_ID%TYPE
    ) RETURN NUMBER IS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*)
        INTO v_count
        FROM LOAN
        WHERE LOAN_ID = p_loan_id;

        IF v_count > 0 THEN
            RETURN 1;
        ELSE
            RETURN 0;
        END IF;
    END LOAN_EXISTS;

    -- Get loan details for a specific loan
    FUNCTION GET_LOAN_DETAILS (
        p_loan_id IN LOAN.LOAN_ID%TYPE
    ) RETURN SYS_REFCURSOR IS
        v_loan_details SYS_REFCURSOR;
    BEGIN
        OPEN v_loan_details FOR
        SELECT *
        FROM LOAN
        WHERE LOAN_ID = p_loan_id;
        
        RETURN v_loan_details;
    END GET_LOAN_DETAILS;
    
    FUNCTION LOAN_WITH_PARAMS_EXISTS (
        p_customer_id IN LOAN.CUSTOMER_ID%TYPE,
        p_loan_type IN LOAN.LOAN_TYPE%TYPE,
        p_amount IN LOAN.AMOUNT%TYPE,
        p_commencement_date IN LOAN.COMMENCEMENT_DATE%TYPE
    ) RETURN NUMBER IS
        v_count NUMBER;
    BEGIN
        SELECT COUNT(*)
        INTO v_count
        FROM LOAN
        WHERE CUSTOMER_ID = p_customer_id
        AND LOAN_TYPE = p_loan_type
        AND AMOUNT = p_amount
        AND COMMENCEMENT_DATE = p_commencement_date;

        IF v_count > 0 THEN
            RETURN 1;
        ELSE
            RETURN 0;
        END IF;
    END LOAN_WITH_PARAMS_EXISTS;
    
    -- add loan
    PROCEDURE ADD_NEW_LOAN (
        p_customer_id IN LOAN.CUSTOMER_ID%TYPE,
        p_loan_type IN LOAN.LOAN_TYPE%TYPE,
        p_branch_id IN LOAN.BRANCH_ID%TYPE,
        p_amount IN LOAN.AMOUNT%TYPE,
        p_interest_rate IN LOAN.INTEREST_RATE%TYPE,
        p_term_in_months IN LOAN.TERM_IN_MONTHS%TYPE,
        p_commencement_date IN LOAN.COMMENCEMENT_DATE%TYPE
    ) IS
        v_loan_exists NUMBER;
    BEGIN
        v_loan_exists := LOAN_WITH_PARAMS_EXISTS(
            p_customer_id => p_customer_id,
            p_loan_type => p_loan_type,
            p_amount => p_amount,
            p_commencement_date => p_commencement_date
        );

        IF v_loan_exists = 0 THEN
            INSERT INTO LOAN (
                CUSTOMER_ID, LOAN_TYPE, BRANCH_ID, AMOUNT, INTEREST_RATE, TERM_IN_MONTHS, COMMENCEMENT_DATE
            ) VALUES (
                p_customer_id, p_loan_type, p_branch_id, p_amount, p_interest_rate, p_term_in_months, p_commencement_date
            );
        ELSE
            RAISE_APPLICATION_ERROR(-20001, 'Loan already exists for the given customer, loan type, amount, and commencement date.');
        END IF;
    END ADD_NEW_LOAN;
    
    PROCEDURE UPDATE_LOAN_DETAILS (
        p_loan_id IN LOAN.LOAN_ID%TYPE,
        p_amount IN LOAN.AMOUNT%TYPE DEFAULT NULL,
        p_interest_rate IN LOAN.INTEREST_RATE%TYPE DEFAULT NULL,
        p_term_in_months IN LOAN.TERM_IN_MONTHS%TYPE DEFAULT NULL,
        p_commencement_date IN LOAN.COMMENCEMENT_DATE%TYPE DEFAULT NULL
    ) IS
    BEGIN
        UPDATE LOAN
        SET AMOUNT = COALESCE(p_amount, AMOUNT),
            INTEREST_RATE = COALESCE(p_interest_rate, INTEREST_RATE),
            TERM_IN_MONTHS = COALESCE(p_term_in_months, TERM_IN_MONTHS),
            COMMENCEMENT_DATE = COALESCE(p_commencement_date, COMMENCEMENT_DATE) 
        WHERE LOAN_ID = p_loan_id;
        
        IF SQL%ROWCOUNT = 0 THEN
            RAISE_APPLICATION_ERROR(-20002, 'Loan not found with the provided Loan ID.');
        END IF;
    END UPDATE_LOAN_DETAILS;
    
END LOAN_MGMT_PKG;
/
----------------------------------------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE TRANSACTION_MGMT_PKG AS
    -- Add a new transaction
    PROCEDURE ADD_TRANSACTION (
        p_account_id IN TRANSACTION_TABLE.ACCOUNT_ID%TYPE,
        p_status_code IN TRANSACTION_TABLE.STATUS_CODE%TYPE,
        p_transaction_type IN TRANSACTION_TABLE.TRANSACTION_TYPE%TYPE,
        p_amount IN TRANSACTION_TABLE.AMOUNT%TYPE,
        p_time_stamp IN TRANSACTION_TABLE.TIME_STAMP%TYPE,
        p_transaction_details IN TRANSACTION_TABLE.TRANSACTION_DETAILS%TYPE,
        p_status IN TRANSACTION_TABLE.STATUS%TYPE
    );
    
    -- Get transaction details for a specific transaction
    FUNCTION GET_TRANSACTION_DETAILS (
        p_transaction_id IN TRANSACTION_TABLE.TRANSACTION_ID%TYPE
    ) RETURN SYS_REFCURSOR;
    
END TRANSACTION_MGMT_PKG;
/

CREATE OR REPLACE PACKAGE BODY TRANSACTION_MGMT_PKG AS
    -- Add a new transaction
    PROCEDURE ADD_TRANSACTION (
        p_account_id IN TRANSACTION_TABLE.ACCOUNT_ID%TYPE,
        p_status_code IN TRANSACTION_TABLE.STATUS_CODE%TYPE,
        p_transaction_type IN TRANSACTION_TABLE.TRANSACTION_TYPE%TYPE,
        p_amount IN TRANSACTION_TABLE.AMOUNT%TYPE,
        p_time_stamp IN TRANSACTION_TABLE.TIME_STAMP%TYPE,
        p_transaction_details IN TRANSACTION_TABLE.TRANSACTION_DETAILS%TYPE,
        p_status IN TRANSACTION_TABLE.STATUS%TYPE
    ) IS
    BEGIN
        INSERT INTO TRANSACTION_TABLE (
            ACCOUNT_ID, STATUS_CODE, TRANSACTION_TYPE, AMOUNT, TIME_STAMP, TRANSACTION_DETAILS, STATUS
        ) VALUES (
            p_account_id, p_status_code, p_transaction_type, p_amount, p_time_stamp, p_transaction_details, p_status
        );
    END ADD_TRANSACTION;
    
    -- Get transaction details for a specific transaction
    FUNCTION GET_TRANSACTION_DETAILS (
        p_transaction_id IN TRANSACTION_TABLE.TRANSACTION_ID%TYPE
    ) RETURN SYS_REFCURSOR IS
        v_transaction_details SYS_REFCURSOR;
    BEGIN
        OPEN v_transaction_details FOR
        SELECT *
        FROM TRANSACTION_TABLE
        WHERE TRANSACTION_ID = p_transaction_id;
        
        RETURN v_transaction_details;
    END GET_TRANSACTION_DETAILS;
    
END TRANSACTION_MGMT_PKG;
/
------------------------------------------------------------------------------------------------------------

--Insert Customer Records using CUSTOMER_MGMT_PKG
BEGIN
    CUSTOMER_MGMT_PKG.ADD_NEW_CUSTOMER(
        'John', 'Doe', TO_DATE('1985-06-15', 'YYYY-MM-DD'), 'john.doe@email.com', '1234567890',
        TO_DATE('2023-01-01', 'YYYY-MM-DD'), 50000, 'johndoe', 'abc123xyz456', '123 Main St', 'Springfield',
        'Massachusetts'
    );

    CUSTOMER_MGMT_PKG.ADD_NEW_CUSTOMER(
        'Jane', 'Doe', TO_DATE('1990-09-20', 'YYYY-MM-DD'), 'jane.doe@email.com', '1234567891',
        TO_DATE('2023-01-05', 'YYYY-MM-DD'), 55000, 'janedoe', 'def123xyz456', '234 Elm St', 'Boston', 'Massachusetts'
    );

    -- Repeat this pattern for the rest of the customers:

    CUSTOMER_MGMT_PKG.ADD_NEW_CUSTOMER(
        'Bob', 'Smith', TO_DATE('1978-03-12', 'YYYY-MM-DD'), 'bob.smith@email.com', '1234567892',
        TO_DATE('2023-01-10', 'YYYY-MM-DD'), 65000, 'bobsmith', 'ghi123xyz456', '345 Oak St', 'Springfield',
        'Massachusetts'
    );
    
    CUSTOMER_MGMT_PKG.ADD_NEW_CUSTOMER(
        'Alice', 'Johnson', TO_DATE('1993-12-01', 'YYYY-MM-DD'), 'alice.johnson@email.com', '1234567893',
        TO_DATE('2023-01-15', 'YYYY-MM-DD'), 58000, 'alicejohn', 'jkl123xyz456', '456 Maple St', 'Cambridge',
        'Massachusetts'
    );
    
    CUSTOMER_MGMT_PKG.ADD_NEW_CUSTOMER(
        'Charlie', 'Brown', TO_DATE('1988-05-25', 'YYYY-MM-DD'), 'charlie.brown@email.com', '1234567894',
        TO_DATE('2023-01-20', 'YYYY-MM-DD'), 100000, 'charliebr', 'mno123xyz456', '567 Pine St', 'Springfield',
        'Massachusetts'
    );
    
    CUSTOMER_MGMT_PKG.ADD_NEW_CUSTOMER(
        'Olivia', 'Miller', TO_DATE('1995-10-10', 'YYYY-MM-DD'), 'olivia.miller@email.com', '1234567895',
        TO_DATE('2023-01-25', 'YYYY-MM-DD'), 75000, 'oliviamill', 'pqr123xyz456', '678 Birch St', 'Boston',
        'Massachusetts'
    );
    
    CUSTOMER_MGMT_PKG.ADD_NEW_CUSTOMER(
        'William', 'Davis', TO_DATE('1982-07-18', 'YYYY-MM-DD'), 'william.davis@email.com', '1234567896',
        TO_DATE('2023-01-30', 'YYYY-MM-DD'), 66000, 'williamdav', 'stu123xyz456', '789 Cedar St', 'Springfield',
        'Massachusetts'
    );
    
    CUSTOMER_MGMT_PKG.ADD_NEW_CUSTOMER(
        'Emily', 'Garcia', TO_DATE('1987-01-30', 'YYYY-MM-DD'), 'emily.garcia@email.com', '1234567897',
        TO_DATE('2023-02-02', 'YYYY-MM-DD'), 98000, 'emilyga', 'vwx123xyz456', '890 Willow St', 'Lowell',
        'Massachusetts'
    );
    
    CUSTOMER_MGMT_PKG.ADD_NEW_CUSTOMER(
        'Daniel', 'Anderson', TO_DATE('1992-04-08', 'YYYY-MM-DD'), 'daniel.anderson@email.com', '1234567898',
        TO_DATE('2023-02-07', 'YYYY-MM-DD'), 80000, 'danieland', 'yzA123xyz456', '901 Aspen St', 'Boston',
        'Massachusetts'
    );
    
    CUSTOMER_MGMT_PKG.ADD_NEW_CUSTOMER(
        'Emma', 'Taylor', TO_DATE('1997-02-15', 'YYYY-MM-DD'), 'emma.taylor@email.com', '1234567899',
        TO_DATE('2023-02-12', 'YYYY-MM-DD'), 130000, 'emmataylor', 'zAB123xyz456', '1002 Oak Grove St', 'Cambridge',
        'Massachusetts'
    );
    
END;
/

-- Insert Branch records using ADD_NEW_BRANCH Procedure
BEGIN
    ADD_NEW_BRANCH('Central Branch', 'CENBR01', '123 Central St', 'Boston', 'Massachusetts', '9876543210', 'central.branch@email.com');
    ADD_NEW_BRANCH('Westside Branch', 'WESBR01', '456 Westside Ave', 'Springfield', 'Massachusetts', '9876543211', 'westside.branch@email.com');
END;
/

-- Insert Loan_Type records using ADD_NEW_LOAN_TYPE Procedure
BEGIN
    ADD_NEW_LOAN_TYPE('Personal Loan', 'Unsecured loan for personal expenses');
    ADD_NEW_LOAN_TYPE('Mortgage Loan', 'Loan for home purchase, secured by the property');
    ADD_NEW_LOAN_TYPE('Auto Loan', 'Loan for vehicle purchase, secured by the vehicle');
    ADD_NEW_LOAN_TYPE('Student Loan', 'Loan for educational expenses, often with lower interest rates');
    ADD_NEW_LOAN_TYPE('Business Loan', 'Loan for business expenses, often secured by business assets');
    ADD_NEW_LOAN_TYPE('Home Equity Loan', 'Loan based on the equity in the borrower''s home, secured by the property');
END;
/

-- Insert Loan records using LOAN_MGMT_PKG 
BEGIN
    LOAN_MGMT_PKG.ADD_NEW_LOAN(1810, 1, 3600, 15000, 6.0, 48, TO_DATE('2023-01-15', 'YYYY-MM-DD'));
    LOAN_MGMT_PKG.ADD_NEW_LOAN(1835, 2, 3601, 250000, 3.75, 360, TO_DATE('2023-02-10', 'YYYY-MM-DD'));
    LOAN_MGMT_PKG.ADD_NEW_LOAN(1820, 4, 3600, 60000, 4.5, 120, TO_DATE('2023-01-25', 'YYYY-MM-DD'));
    LOAN_MGMT_PKG.ADD_NEW_LOAN(1845, 3, 3600, 18000, 5.25, 60, TO_DATE('2023-02-15', 'YYYY-MM-DD'));
    LOAN_MGMT_PKG.ADD_NEW_LOAN(1800, 1, 3600, 8000, 7.0, 36, TO_DATE('2023-01-15', 'YYYY-MM-DD'));
    LOAN_MGMT_PKG.ADD_NEW_LOAN(1805, 5, 3601, 50000, 5.5, 84, TO_DATE('2023-02-10', 'YYYY-MM-DD'));
    LOAN_MGMT_PKG.ADD_NEW_LOAN(1825, 2, 3600, 300000, 4.0, 360, TO_DATE('2023-02-28', 'YYYY-MM-DD'));
    LOAN_MGMT_PKG.ADD_NEW_LOAN(1845, 6, 3601, 70000, 4.75, 120, TO_DATE('2023-03-20', 'YYYY-MM-DD'));
    LOAN_MGMT_PKG.ADD_NEW_LOAN(1810, 3, 3600, 12000, 5.0, 48, TO_DATE('2023-02-05', 'YYYY-MM-DD'));
END;
/

-- Insert Account_type records using ADD_NEW_ACCOUNT_TYPE Procedure
BEGIN
    ADD_NEW_ACCOUNT_TYPE('Savings Account', 1.5);
    ADD_NEW_ACCOUNT_TYPE('Checking Account', 0.25);
    ADD_NEW_ACCOUNT_TYPE('High-Yield Savings Account', 3);
    ADD_NEW_ACCOUNT_TYPE('Student Account', 0);
END;
/

-- Insert Accounts
BEGIN
    -- 1. John Doe
    ACCOUNT_MGMT_PKG.ADD_NEW_ACCOUNT(1800, 1, 3600, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 0, 1111222233331111, 'Drivers License');
    ACCOUNT_MGMT_PKG.ADD_NEW_ACCOUNT(1800, 2, 3600, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 0, 1111222233331122, 'Drivers License');

    -- 2. Jane Doe
    ACCOUNT_MGMT_PKG.ADD_NEW_ACCOUNT(1805, 1, 3600, TO_DATE('2023-01-05', 'YYYY-MM-DD'), 0, 1111222233332211, 'Passport');
    ACCOUNT_MGMT_PKG.ADD_NEW_ACCOUNT(1805, 2, 3600, TO_DATE('2023-01-05', 'YYYY-MM-DD'), 0, 1111222233332222, 'Passport');

    -- 3. Bob Smith
    ACCOUNT_MGMT_PKG.ADD_NEW_ACCOUNT(1810, 1, 3601, TO_DATE('2023-01-10', 'YYYY-MM-DD'), 0, 1111222233333311, 'Drivers License');

    -- 4. Alice Johnson
    ACCOUNT_MGMT_PKG.ADD_NEW_ACCOUNT(1815, 1, 3600, TO_DATE('2023-01-15', 'YYYY-MM-DD'), 0, 1111222233334411, 'Passport');
    ACCOUNT_MGMT_PKG.ADD_NEW_ACCOUNT(1815, 2, 3600, TO_DATE('2023-01-15', 'YYYY-MM-DD'), 0, 1111222233334422, 'Passport');

    -- 5. Charlie Brown
    ACCOUNT_MGMT_PKG.ADD_NEW_ACCOUNT(1820, 3, 3601, TO_DATE('2023-01-20', 'YYYY-MM-DD'), 0, 1111222233335533, 'Drivers License');
    ACCOUNT_MGMT_PKG.ADD_NEW_ACCOUNT(1820, 4, 3601, TO_DATE('2023-01-20', 'YYYY-MM-DD'), 0, 1111222233335544, 'Drivers License');

    -- 6. Grace Smith
    ACCOUNT_MGMT_PKG.ADD_NEW_ACCOUNT(1825, 2, 3600, TO_DATE('2023-01-25', 'YYYY-MM-DD'), 0, 1111222233336611, 'Passport');
    ACCOUNT_MGMT_PKG.ADD_NEW_ACCOUNT(1825, 4, 3600, TO_DATE('2023-01-25', 'YYYY-MM-DD'), 0, 1111222233336622, 'Passport');

    -- 7. Emma Johnson
    ACCOUNT_MGMT_PKG.ADD_NEW_ACCOUNT(1830, 3, 3601, TO_DATE('2023-01-30', 'YYYY-MM-DD'), 0, 1111222233337733, 'Drivers License');

    -- 8. James Brown
    ACCOUNT_MGMT_PKG.ADD_NEW_ACCOUNT(1835, 1, 3600, TO_DATE('2023-02-02', 'YYYY-MM-DD'), 0, 1111222233338811, 'Passport');
    ACCOUNT_MGMT_PKG.ADD_NEW_ACCOUNT(1835, 2, 3600, TO_DATE('2023-02-02', 'YYYY-MM-DD'), 0, 1111222233338822, 'Passport');

    -- 9. Emily Brown
    ACCOUNT_MGMT_PKG.ADD_NEW_ACCOUNT(1840, 4, 3601, TO_DATE('2023-02-07', 'YYYY-MM-DD'), 0, 1111222233339922, 'Drivers License');

    -- 10. William Johnson
    ACCOUNT_MGMT_PKG.ADD_NEW_ACCOUNT(1845, 4, 3600, TO_DATE('2023-02-12', 'YYYY-MM-DD'), 0, 1111222233330022, 'Passport');

END;
/

-- Insert Roles using ADD_NEW_ROLE Procedure
BEGIN
    ADD_NEW_ROLE('Employee', 35000);
    ADD_NEW_ROLE('Branch Manager', 60000);
END;
/

-- Insert employees using EMPLOYEE_MGMT_PKG
BEGIN
    EMPLOYEE_MGMT_PKG.ADD_NEW_EMPLOYEE(3600, 2, 'Michael', 'Roberts', TO_DATE('1980-07-15', 'YYYY-MM-DD'), 'michael.roberts@email.com', '1234567890',
                     TO_DATE('2020-10-15', 'YYYY-MM-DD'), 'michaelr', 'a6f8c4d93479234bdf1a776121b8e8b3', '123 Main St', 'Boston',
                     'MA', 608);

    EMPLOYEE_MGMT_PKG.ADD_NEW_EMPLOYEE(3600, 1, 'Laura', 'Wilson', TO_DATE('1990-03-12', 'YYYY-MM-DD'), 'laura.wilson@email.com', '2345678901',
                     TO_DATE('2022-12-10', 'YYYY-MM-DD'), 'lauraw', '5b5ec7c5f17d7e1e76c71e7aa52f8c5d', '234 Main St', 'Powell',
                     'MA', 608);
    
    EMPLOYEE_MGMT_PKG.ADD_NEW_EMPLOYEE(3600, 1, 'Daniel', 'Green', TO_DATE('1985-06-25', 'YYYY-MM-DD'), 'daniel.green@email.com', '3456789012',
        TO_DATE('2023-02-01', 'YYYY-MM-DD'), 'danielg', 'c7d3a3c07de98b8f8525b5ee5f5e9fc9', '345 Main St',
        'Springfield', 'MA', 608);

    EMPLOYEE_MGMT_PKG.ADD_NEW_EMPLOYEE(3600, 1, 'Sophia', 'Mitchell', TO_DATE('1988-08-14', 'YYYY-MM-DD'), 'sophia.mitchell@email.com', '4567890123',
        TO_DATE('2021-05-23', 'YYYY-MM-DD'), 'sophiam', '3e1d07a3f11b1d8d83e4cd4eef581123', '456 Main St', 'New York',
        'NY', 608);

    EMPLOYEE_MGMT_PKG.ADD_NEW_EMPLOYEE(3601, 2, 'Olivia', 'Parker', TO_DATE('1978-02-27', 'YYYY-MM-DD'), 'olivia.parker@email.com', '5678901234',
        TO_DATE('2019-11-18', 'YYYY-MM-DD'), 'oliviap', '8a9c7a635bdf0cd0d1f8e4fe7cbe4aef', '567 Main St', 'Cambridge',
        'MA', 620);

    EMPLOYEE_MGMT_PKG.ADD_NEW_EMPLOYEE(3601, 1, 'Emma', 'Turner', TO_DATE('1993-11-06', 'YYYY-MM-DD'), 'emma.turner@email.com', '6789012345',
        TO_DATE('2023-01-27', 'YYYY-MM-DD'), 'emmat', 'de4e1a7ab4c0f4b8c482b5d5b0c1e2cd', '678 Main St', 'Los Angeles',
        'CA', 620);

    EMPLOYEE_MGMT_PKG.ADD_NEW_EMPLOYEE(3601, 1, 'Jacob', 'Adams', TO_DATE('1986-12-23', 'YYYY-MM-DD'), 'jacob.adams@email.com', '7890123456',
        TO_DATE('2022-11-23', 'YYYY-MM-DD'), 'jacobad', '927d6aa81d45cde1d8c0f2e68e3d3e3c', '789 Main St', 'New York',
        'NY', 620);

    EMPLOYEE_MGMT_PKG.ADD_NEW_EMPLOYEE(3601, 1, 'Ava', 'Bennett', TO_DATE('1991-04-30', 'YYYY-MM-DD'), 'ava.bennett@email.com', '8901234567',
        TO_DATE('2021-04-11', 'YYYY-MM-DD'), 'avab', '1a2b3c4d5e6f7g8h9i0j1k2l3m4n5o6p', '890 Main St', 'Cambridge',
        'MA', 620);

    EMPLOYEE_MGMT_PKG.ADD_NEW_EMPLOYEE(3600, 1, 'Oliver', 'Patterson', TO_DATE('1993-08-17', 'YYYY-MM-DD'), 'oliver.patterson@email.com', '8912345678',
        TO_DATE('2023-01-15', 'YYYY-MM-DD'), 'oliverp', '1a2b3c4d5e6f7g8h9i0j1k2l3m4n5o6p', '123 High St', 'Worcester',
        'MA', 608);

    EMPLOYEE_MGMT_PKG.ADD_NEW_EMPLOYEE(3601, 1, 'Sophia', 'Turner', TO_DATE('1994-11-05', 'YYYY-MM-DD'), 'sophia.turner@email.com', '8923456789',
        TO_DATE('2023-01-20', 'YYYY-MM-DD'), 'sophiat', '1a2b3c4d5e6f7g8h9i0j1k2l3m4n5o6p', '980 Elm St', 'Cambridge',
        'MA', 620);
    
END;
/

-- insert transaction_type using ADD_NEW_TRANSACTION_TYPE Procedure
BEGIN
    ADD_NEW_TRANSACTION_TYPE('DEPOSIT', 'Deposit funds into an account');
    ADD_NEW_TRANSACTION_TYPE('WITHDRAWAL', 'Withdraw funds from an account');
    ADD_NEW_TRANSACTION_TYPE('TRANSFER', 'Transfer funds between accounts');
    ADD_NEW_TRANSACTION_TYPE('ONLINE_RETAIL', 'Online retail purchase');
END;
/

-- insert status_codes using ADD_NEW_STATUS_CODE Procedure
BEGIN
    ADD_NEW_STATUS_CODE(LPAD('00', 2, '0'), 'Transaction Approved');
    ADD_NEW_STATUS_CODE(LPAD('06', 2, '0'), 'Error');
    ADD_NEW_STATUS_CODE(LPAD('12', 2, '0'), 'Invalid Transaction');
    ADD_NEW_STATUS_CODE(LPAD('13', 2, '0'), 'Invalid Amount');
    ADD_NEW_STATUS_CODE(LPAD('14', 2, '0'), 'Invalid Card Number');
    ADD_NEW_STATUS_CODE(LPAD('51', 2, '0'), 'Insufficient Funds');
    ADD_NEW_STATUS_CODE(LPAD('54', 2, '0'), 'Expired Card');
END;
/

BEGIN
    DBMS_OUTPUT.ENABLE(1000000);
END;
/

SELECT * FROM ACCOUNTS;
-- Insert transactions using TRANSACTION_MGMT_PKG
-- Account 1
-- Initial balance: 0
-- Final balance: 10000
-- Day 1
DECLARE
    current_time TIMESTAMP;
BEGIN
    current_time := SYSTIMESTAMP;

    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '00', 1, 12300, TO_TIMESTAMP('2023-03-09 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Deposit at Branch','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '00', 2, 1000, TO_TIMESTAMP('2023-03-09 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '00', 4, 250, TO_TIMESTAMP('2023-03-09 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Online Shopping','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '00', 3, 500, TO_TIMESTAMP('2023-03-09 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer to account_id 102','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '14', 2, 7000, TO_TIMESTAMP('2023-03-09 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '51', 2, 17000, TO_TIMESTAMP('2023-03-09 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
-- Day 2
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '00', 2, 500, TO_TIMESTAMP('2023-03-10 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '00', 4, 500, TO_TIMESTAMP('2023-03-10 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Online Subscription','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '54', 4, 200, TO_TIMESTAMP('2023-03-10 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Expired Card', 'Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '00', 1, 750, TO_TIMESTAMP('2023-03-10 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Refund from Online Shopping','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '00', 3, 1500, TO_TIMESTAMP('2023-03-10 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer to account_id 103','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '06', 3, 7000, TO_TIMESTAMP('2023-03-10 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Failed');
-- Day 3
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '00', 1, 2500, TO_TIMESTAMP('2023-03-11 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Salary Deposit','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '00', 4, 200, TO_TIMESTAMP('2023-03-11 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '00', 2, 800, TO_TIMESTAMP('2023-03-11 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '00', 4, 300, TO_TIMESTAMP('2023-03-11 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '51', 2, 12000, TO_TIMESTAMP('2023-03-11 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '14', 2, 2000, TO_TIMESTAMP('2023-03-11 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
-- Day 4, 5, 6, and 7
-- Add similar transactions to the above pattern for the remaining days.
-- Day 4
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '00', 1, 650, TO_TIMESTAMP('2023-03-12 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Refund', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '00', 4, 200, TO_TIMESTAMP('2023-03-12 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '00', 2, 300, TO_TIMESTAMP('2023-03-12 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '00', 4, 150, TO_TIMESTAMP('2023-03-12 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '51', 2, 12000, TO_TIMESTAMP('2023-03-12 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '06', 3, 5000, TO_TIMESTAMP('2023-03-12 13:40:00', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Failed');
-- Day 5
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '00', 1, 650, TO_TIMESTAMP('2023-03-13 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Deposit at Branch','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '00', 4, 200, TO_TIMESTAMP('2023-03-13 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '00', 2, 300, TO_TIMESTAMP('2023-03-13 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '00', 4, 150, TO_TIMESTAMP('2023-03-13 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '51', 2, 12000, TO_TIMESTAMP('2023-03-13 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '14', 2, 1000, TO_TIMESTAMP('2023-03-13 20:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
-- Day 6
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '00', 1, 650, TO_TIMESTAMP('2023-03-14 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Deposit at Branch','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '00', 4, 200, TO_TIMESTAMP('2023-03-14 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '00', 2, 300, TO_TIMESTAMP('2023-03-14 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '00', 4, 150, TO_TIMESTAMP('2023-03-14 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '51', 2, 12000, TO_TIMESTAMP('2023-03-14 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '06', 3, 250, TO_TIMESTAMP('2023-03-14 21:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Failed');
-- Day 7
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '00', 1, 650, current_time - INTERVAL '1' DAY + INTERVAL '9' HOUR, 'Refund', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '00', 4, 200, current_time - INTERVAL '1' DAY + INTERVAL '10' HOUR, 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '00', 2, 300, current_time - INTERVAL '1' DAY + INTERVAL '11' HOUR, 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '00', 4, 150, current_time - INTERVAL '1' DAY + INTERVAL '12' HOUR, 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '51', 2, 12000, current_time - INTERVAL '1' DAY + INTERVAL '13' HOUR, 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '14', 2, 3000, current_time - INTERVAL '1' DAY + INTERVAL '14' HOUR, 'Withdrawal from ATM','Failed');
-- Last hour transactions
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '00', 3, 650, current_time - INTERVAL '1' HOUR + INTERVAL '40' MINUTE, 'Transfer Made', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '00', 4, 200, current_time - INTERVAL '1' HOUR + INTERVAL '45' MINUTE, 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '00', 2, 300, current_time - INTERVAL '1' HOUR + INTERVAL '46' MINUTE, 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '00', 4, 150, current_time - INTERVAL '1' HOUR + INTERVAL '47' MINUTE, 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '51', 2, 12000, current_time - INTERVAL '1' HOUR + INTERVAL '48' MINUTE, 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '00', 1, 1300, current_time - INTERVAL '1' HOUR + INTERVAL '49' MINUTE, 'Deposit at Branch','Completed');

-- Account 2
-- Initial balance: 0
-- Final balance: 15000
-- Day 1
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '00', 1, 17300, TO_TIMESTAMP('2023-03-09 07:23:42', 'YYYY-MM-DD HH24:MI:SS'), 'Deposit at Branch','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '00', 2, 1000, TO_TIMESTAMP('2023-03-09 12:50:47', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '00', 4, 250, TO_TIMESTAMP('2023-03-09 12:56:56', 'YYYY-MM-DD HH24:MI:SS'), 'Online Shopping','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '00', 3, 500, TO_TIMESTAMP('2023-03-09 13:34:59', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '14', 2, 7000, TO_TIMESTAMP('2023-03-09 16:30:43', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '51', 2, 20000, TO_TIMESTAMP('2023-03-09 16:35:00', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
-- Day 2
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '00', 2, 500, TO_TIMESTAMP('2023-03-10 11:57:30', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '00', 4, 500, TO_TIMESTAMP('2023-03-10 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Online Subscription','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '54', 4, 200, TO_TIMESTAMP('2023-03-10 12:21:54', 'YYYY-MM-DD HH24:MI:SS'), 'Expired Card', 'Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '00', 1, 750, TO_TIMESTAMP('2023-03-10 13:03:21', 'YYYY-MM-DD HH24:MI:SS'), 'Refund from Online Shopping','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '00', 3, 1500, TO_TIMESTAMP('2023-03-10 14:19:29', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '06', 3, 7000, TO_TIMESTAMP('2023-03-10 16:51:33', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Failed');
-- Day 3
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '00', 1, 2500, TO_TIMESTAMP('2023-03-11 06:21:20', 'YYYY-MM-DD HH24:MI:SS'), 'Salary Deposit','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '00', 4, 200, TO_TIMESTAMP('2023-03-11 09:02:56', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '00', 2, 800, TO_TIMESTAMP('2023-03-11 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '00', 4, 300, TO_TIMESTAMP('2023-03-11 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '51', 2, 20000, TO_TIMESTAMP('2023-03-11 13:54:00', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '14', 2, 2000, TO_TIMESTAMP('2023-03-11 21:25:09', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
-- Day 4, 5, 6, and 7
-- Add similar transactions to the above pattern for the remaining days.
-- Day 4
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '00', 1, 650, TO_TIMESTAMP('2023-03-12 13:08:12', 'YYYY-MM-DD HH24:MI:SS'), 'Refund', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '00', 4, 200, TO_TIMESTAMP('2023-03-12 14:15:00', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '00', 2, 300, TO_TIMESTAMP('2023-03-12 16:09:40', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '00', 4, 150, TO_TIMESTAMP('2023-03-12 18:09:00', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '51', 2, 27800, TO_TIMESTAMP('2023-03-12 18:16:00', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '06', 3, 5000, TO_TIMESTAMP('2023-03-12 13:40:00', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Failed');
-- Day 5
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '00', 1, 650, TO_TIMESTAMP('2023-03-13 02:03:50', 'YYYY-MM-DD HH24:MI:SS'), 'Deposit at Branch','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '00', 4, 200, TO_TIMESTAMP('2023-03-13 09:45:51', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '00', 2, 300, TO_TIMESTAMP('2023-03-13 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '00', 4, 150, TO_TIMESTAMP('2023-03-13 15:54:00', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '51', 2, 19870, TO_TIMESTAMP('2023-03-13 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '14', 2, 1000, TO_TIMESTAMP('2023-03-13 20:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
-- Day 6
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '00', 1, 650, TO_TIMESTAMP('2023-03-14 13:26:00', 'YYYY-MM-DD HH24:MI:SS'), 'Deposit at Branch','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '00', 4, 200, TO_TIMESTAMP('2023-03-14 13:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '00', 2, 300, TO_TIMESTAMP('2023-03-14 16:17:00', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '00', 4, 150, TO_TIMESTAMP('2023-03-14 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '51', 2, 16590, TO_TIMESTAMP('2023-03-14 17:25:00', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '06', 3, 250, TO_TIMESTAMP('2023-03-14 21:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Failed');
-- Day 7
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '00', 1, 650, current_time - INTERVAL '1' DAY - INTERVAL '21' HOUR - INTERVAL '15' MINUTE, 'Refund', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '00', 4, 200, current_time - INTERVAL '1' DAY - INTERVAL '17' HOUR - INTERVAL '14' MINUTE, 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '00', 2, 300, current_time - INTERVAL '1' DAY - INTERVAL '12' HOUR - INTERVAL '10' MINUTE, 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '00', 4, 150, current_time - INTERVAL '1' DAY - INTERVAL '12' HOUR, 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '51', 2, 15500, current_time - INTERVAL '1' DAY - INTERVAL '8' HOUR - INTERVAL '26' MINUTE, 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '14', 2, 3000, current_time - INTERVAL '1' DAY - INTERVAL '8' HOUR - INTERVAL '58' MINUTE, 'Withdrawal from ATM','Failed');
-- Last hour transactions
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '00', 3, 650, current_time - INTERVAL '1' HOUR - INTERVAL '20' MINUTE - INTERVAL '5' SECOND, 'Transfer Made', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '00', 4, 200, current_time - INTERVAL '1' HOUR - INTERVAL '20' MINUTE, 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '00', 2, 300, current_time - INTERVAL '1' HOUR - INTERVAL '18' MINUTE - INTERVAL '30' SECOND, 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '00', 4, 150, current_time - INTERVAL '1' HOUR - INTERVAL '18' MINUTE - INTERVAL '30' SECOND, 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '51', 2, 17980, current_time - INTERVAL '1' HOUR - INTERVAL '17' MINUTE - INTERVAL '55' SECOND, 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '00', 1, 1300, current_time - INTERVAL '1' HOUR - INTERVAL '16' MINUTE - INTERVAL '30' SECOND, 'Deposit at Branch','Completed');
    
-- Account 3
-- Initial balance: 0
-- Final balance: 12000
-- Day 1
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '00', 1, 12800, TO_TIMESTAMP('2023-03-09 08:23:42', 'YYYY-MM-DD HH24:MI:SS'), 'Deposit at Branch','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '00', 2, 1000, TO_TIMESTAMP('2023-03-09 15:50:47', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '00', 4, 250, TO_TIMESTAMP('2023-03-09 17:56:56', 'YYYY-MM-DD HH24:MI:SS'), 'Online Shopping','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '00', 3, 500, TO_TIMESTAMP('2023-03-09 18:34:59', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '14', 2, 7000, TO_TIMESTAMP('2023-03-09 18:39:43', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '51', 2, 20000, TO_TIMESTAMP('2023-03-09 19:35:00', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
-- Day 2
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '00', 2, 500, TO_TIMESTAMP('2023-03-10 12:57:30', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '00', 4, 500, TO_TIMESTAMP('2023-03-10 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Online Subscription','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '54', 4, 200, TO_TIMESTAMP('2023-03-10 13:21:54', 'YYYY-MM-DD HH24:MI:SS'), 'Expired Card', 'Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '00', 1, 750, TO_TIMESTAMP('2023-03-10 13:33:21', 'YYYY-MM-DD HH24:MI:SS'), 'Refund from Online Shopping','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '00', 3, 1500, TO_TIMESTAMP('2023-03-10 14:37:29', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer from account_id 101','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '06', 3, 7000, TO_TIMESTAMP('2023-03-10 19:55:33', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Failed');
-- Day 3
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '00', 1, 2500, TO_TIMESTAMP('2023-03-11 01:24:20', 'YYYY-MM-DD HH24:MI:SS'), 'Salary Deposit','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '00', 4, 200, TO_TIMESTAMP('2023-03-11 12:02:56', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '00', 2, 800, TO_TIMESTAMP('2023-03-11 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '00', 4, 300, TO_TIMESTAMP('2023-03-11 13:29:00', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '51', 2, 20000, TO_TIMESTAMP('2023-03-11 13:54:00', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '14', 2, 2000, TO_TIMESTAMP('2023-03-11 21:25:09', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '00', 3, 1500, TO_TIMESTAMP('2023-03-11 23:19:29', 'YYYY-MM-DD HH24:MI:SS'), 'Outward Transfer','Completed');
-- Day 4, 5, 6, and 7
-- Add similar transactions to the above pattern for the remaining days.
-- Day 4
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '00', 1, 650, TO_TIMESTAMP('2023-03-12 14:08:12', 'YYYY-MM-DD HH24:MI:SS'), 'Refund', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '00', 4, 200, TO_TIMESTAMP('2023-03-12 14:15:00', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '00', 2, 300, TO_TIMESTAMP('2023-03-12 15:09:40', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '00', 4, 150, TO_TIMESTAMP('2023-03-12 20:09:00', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '51', 2, 14800, TO_TIMESTAMP('2023-03-12 20:16:00', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '06', 3, 5000, TO_TIMESTAMP('2023-03-12 21:40:00', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Failed');
-- Day 5
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '00', 1, 650, TO_TIMESTAMP('2023-03-13 05:03:50', 'YYYY-MM-DD HH24:MI:SS'), 'Deposit at Branch','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '00', 4, 200, TO_TIMESTAMP('2023-03-13 13:45:51', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '00', 2, 300, TO_TIMESTAMP('2023-03-13 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '00', 4, 150, TO_TIMESTAMP('2023-03-13 14:54:00', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '51', 2, 12270, TO_TIMESTAMP('2023-03-13 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '14', 2, 1000, TO_TIMESTAMP('2023-03-13 19:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
-- Day 6
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '00', 1, 650, TO_TIMESTAMP('2023-03-14 04:26:00', 'YYYY-MM-DD HH24:MI:SS'), 'Deposit at Branch','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '00', 4, 200, TO_TIMESTAMP('2023-03-14 11:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '00', 2, 300, TO_TIMESTAMP('2023-03-14 13:17:00', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '00', 4, 150, TO_TIMESTAMP('2023-03-14 19:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '51', 2, 13275, TO_TIMESTAMP('2023-03-14 19:25:00', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '06', 3, 250, TO_TIMESTAMP('2023-03-14 21:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Failed');
-- Day 7
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '00', 1, 650, current_time - INTERVAL '1' DAY - INTERVAL '7' HOUR - INTERVAL '59' MINUTE, 'Refund', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '00', 4, 200, current_time - INTERVAL '1' DAY - INTERVAL '7' HOUR - INTERVAL '58' MINUTE, 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '00', 2, 300, current_time - INTERVAL '1' DAY - INTERVAL '5' HOUR - INTERVAL '54' MINUTE, 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '00', 4, 150, current_time - INTERVAL '1' DAY - INTERVAL '3' HOUR - INTERVAL '44' MINUTE, 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '51', 2, 14000, current_time - INTERVAL '1' DAY - INTERVAL '3' HOUR - INTERVAL '10' MINUTE, 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '14', 2, 3000, current_time - INTERVAL '1' DAY - INTERVAL '1' HOUR - INTERVAL '42' MINUTE, 'Withdrawal from ATM','Failed');

-- Last hour transactions
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '00', 3, 650, current_time - INTERVAL '4' MINUTE, 'Transfer Made', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '00', 4, 200, current_time - INTERVAL '3' MINUTE - INTERVAL '46' SECOND, 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '00', 2, 300, current_time - INTERVAL '2' MINUTE - INTERVAL '40' SECOND, 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '00', 4, 150, current_time - INTERVAL '1' MINUTE, 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '51', 2, 15450, current_time, 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '00', 1, 1300, current_time + INTERVAL '20' SECOND, 'Deposit at Branch','Completed');
    
-- Account 4
-- Initial balance: 0
-- Final balance: 8000
-- Day 1
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '00', 1, 15000, TO_TIMESTAMP('2023-03-09 03:29:42', 'YYYY-MM-DD HH24:MI:SS'), 'Deposit at Branch','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '00', 2, 3000, TO_TIMESTAMP('2023-03-09 04:59:47', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '00', 4, 250, TO_TIMESTAMP('2023-03-09 07:59:16', 'YYYY-MM-DD HH24:MI:SS'), 'Online Shopping','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '00', 3, 500, TO_TIMESTAMP('2023-03-09 10:39:09', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '14', 2, 7000, TO_TIMESTAMP('2023-03-09 11:39:43', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '51', 2, 20000, TO_TIMESTAMP('2023-03-09 14:35:00', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
-- Day 2
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '00', 2, 500, TO_TIMESTAMP('2023-03-10 08:57:30', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '00', 4, 500, TO_TIMESTAMP('2023-03-10 10:10:23', 'YYYY-MM-DD HH24:MI:SS'), 'Online Subscription','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '54', 4, 200, TO_TIMESTAMP('2023-03-10 10:21:54', 'YYYY-MM-DD HH24:MI:SS'), 'Expired Card', 'Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '00', 1, 750, TO_TIMESTAMP('2023-03-10 12:33:21', 'YYYY-MM-DD HH24:MI:SS'), 'Refund from Online Shopping','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '06', 3, 7000, TO_TIMESTAMP('2023-03-10 23:55:33', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Failed');
-- Day 3
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '00', 1, 2500, TO_TIMESTAMP('2023-03-11 08:15:20', 'YYYY-MM-DD HH24:MI:SS'), 'Salary Deposit','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '00', 4, 200, TO_TIMESTAMP('2023-03-11 08:20:56', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '00', 2, 2800, TO_TIMESTAMP('2023-03-11 10:50:20', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '00', 4, 1000, TO_TIMESTAMP('2023-03-11 11:29:39', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '51', 2, 20000, TO_TIMESTAMP('2023-03-11 12:45:21', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '14', 2, 2000, TO_TIMESTAMP('2023-03-11 14:39:29', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '00', 3, 1500, TO_TIMESTAMP('2023-03-11 19:49:19', 'YYYY-MM-DD HH24:MI:SS'), 'Outward Transfer','Completed');
-- Day 4, 5, 6, and 7
-- Add similar transactions to the above pattern for the remaining days.
-- Day 4
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '00', 1, 800, TO_TIMESTAMP('2023-03-12 03:31:22', 'YYYY-MM-DD HH24:MI:SS'), 'Refund', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '00', 4, 200, TO_TIMESTAMP('2023-03-12 13:15:25', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '00', 2, 300, TO_TIMESTAMP('2023-03-12 13:29:40', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '00', 4, 300, TO_TIMESTAMP('2023-03-12 21:34:49', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '51', 2, 14800, TO_TIMESTAMP('2023-03-12 22:16:32', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '06', 3, 5000, TO_TIMESTAMP('2023-03-12 23:40:56', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Failed');
-- Day 5
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '00', 1, 650, TO_TIMESTAMP('2023-03-13 05:55:29', 'YYYY-MM-DD HH24:MI:SS'), 'Deposit at Branch','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '00', 4, 200, TO_TIMESTAMP('2023-03-13 08:51:02', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '00', 2, 300, TO_TIMESTAMP('2023-03-13 10:23:45', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '00', 4, 150, TO_TIMESTAMP('2023-03-13 17:54:43', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '51', 2, 12270, TO_TIMESTAMP('2023-03-13 17:59:09', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '14', 2, 1000, TO_TIMESTAMP('2023-03-13 21:41:25', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
-- Day 6
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '00', 1, 800, TO_TIMESTAMP('2023-03-14 04:26:28', 'YYYY-MM-DD HH24:MI:SS'), 'Deposit at Branch','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '00', 4, 200, TO_TIMESTAMP('2023-03-14 10:30:44', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '00', 2, 300, TO_TIMESTAMP('2023-03-14 13:19:32', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '00', 4, 300, TO_TIMESTAMP('2023-03-14 14:55:34', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '51', 2, 13275, TO_TIMESTAMP('2023-03-14 19:25:32', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '06', 3, 250, TO_TIMESTAMP('2023-03-14 21:29:11', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Failed');
-- Previous Day
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '00', 1, 650, current_time - INTERVAL '1' DAY - INTERVAL '22' HOUR - INTERVAL '15' MINUTE - INTERVAL '10' SECOND, 'Refund', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '00', 4, 200, current_time - INTERVAL '1' DAY - INTERVAL '16' HOUR - INTERVAL '14' MINUTE - INTERVAL '39' SECOND, 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '00', 2, 300, current_time - INTERVAL '1' DAY - INTERVAL '12' HOUR - INTERVAL '49' MINUTE - INTERVAL '26' SECOND, 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '00', 4, 150, current_time - INTERVAL '1' DAY - INTERVAL '8' HOUR - INTERVAL '15' MINUTE - INTERVAL '28' SECOND, 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '51', 2, 14000, current_time - INTERVAL '1' DAY - INTERVAL '6' HOUR - INTERVAL '27' MINUTE - INTERVAL '49' SECOND, 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '14', 2, 3000, current_time - INTERVAL '1' DAY - INTERVAL '3' HOUR - INTERVAL '57' MINUTE - INTERVAL '36' SECOND, 'Withdrawal from ATM','Failed');

-- Last hour transactions
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '00', 3, 800, current_time - INTERVAL '21' MINUTE - INTERVAL '48' SECOND, 'Transfer Made', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '00', 4, 200, current_time - INTERVAL '20' MINUTE - INTERVAL '41' SECOND, 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '00', 2, 300, current_time - INTERVAL '19' MINUTE - INTERVAL '59' SECOND, 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '00', 4, 300, current_time - INTERVAL '18' MINUTE - INTERVAL '1' SECOND, 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '51', 2, 15450, current_time - INTERVAL '17' MINUTE - INTERVAL '15' SECOND, 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '00', 1, 1600, current_time - INTERVAL '12' MINUTE - INTERVAL '36' SECOND, 'Deposit at Branch','Completed');
    
-- Account 5
-- Initial balance: 0
-- Final balance: 25000
-- Day 1
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '00', 1, 31000, TO_TIMESTAMP('2023-03-09 01:39:52', 'YYYY-MM-DD HH24:MI:SS'), 'Deposit at Branch','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '00', 2, 2000, TO_TIMESTAMP('2023-03-09 10:39:47', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '00', 4, 250, TO_TIMESTAMP('2023-03-09 11:29:16', 'YYYY-MM-DD HH24:MI:SS'), 'Online Shopping','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '00', 3, 500, TO_TIMESTAMP('2023-03-09 11:39:59', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '14', 2, 7000, TO_TIMESTAMP('2023-03-09 12:40:47', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '51', 2, 35000, TO_TIMESTAMP('2023-03-09 14:35:21', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
-- Day 2
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '00', 2, 500, TO_TIMESTAMP('2023-03-10 14:57:39', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '00', 4, 500, TO_TIMESTAMP('2023-03-10 15:10:53', 'YYYY-MM-DD HH24:MI:SS'), 'Online Subscription','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '54', 4, 200, TO_TIMESTAMP('2023-03-10 16:54:25', 'YYYY-MM-DD HH24:MI:SS'), 'Expired Card', 'Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '00', 1, 750, TO_TIMESTAMP('2023-03-10 16:59:31', 'YYYY-MM-DD HH24:MI:SS'), 'Refund from Online Shopping','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '06', 3, 7000, TO_TIMESTAMP('2023-03-10 19:12:35', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Failed');
-- Day 3
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '00', 1, 2500, TO_TIMESTAMP('2023-03-11 01:25:09', 'YYYY-MM-DD HH24:MI:SS'), 'Salary Deposit','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '00', 4, 200, TO_TIMESTAMP('2023-03-11 07:09:12', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '00', 2, 2800, TO_TIMESTAMP('2023-03-11 10:15:27', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '00', 4, 1000, TO_TIMESTAMP('2023-03-11 11:49:32', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '51', 2, 35000, TO_TIMESTAMP('2023-03-11 12:41:29', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '14', 2, 2000, TO_TIMESTAMP('2023-03-11 13:55:21', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '00', 3, 1500, TO_TIMESTAMP('2023-03-11 21:23:45', 'YYYY-MM-DD HH24:MI:SS'), 'Outward Transfer','Completed');
-- Day 4, 5, 6, and 7
-- Add similar transactions to the above pattern for the remaining days.
-- Day 4
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '00', 1, 900, TO_TIMESTAMP('2023-03-12 05:52:23', 'YYYY-MM-DD HH24:MI:SS'), 'Refund', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '00', 4, 200, TO_TIMESTAMP('2023-03-12 09:34:21', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '00', 2, 400, TO_TIMESTAMP('2023-03-12 10:29:23', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '00', 4, 300, TO_TIMESTAMP('2023-03-12 19:51:09', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '51', 2, 30000, TO_TIMESTAMP('2023-03-12 22:45:32', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '06', 3, 5000, TO_TIMESTAMP('2023-03-12 23:45:56', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Failed');
-- Day 5
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '00', 1, 650, TO_TIMESTAMP('2023-03-13 09:55:29', 'YYYY-MM-DD HH24:MI:SS'), 'Deposit at Branch','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '00', 4, 200, TO_TIMESTAMP('2023-03-13 11:51:13', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '00', 2, 300, TO_TIMESTAMP('2023-03-13 13:32:46', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '00', 4, 150, TO_TIMESTAMP('2023-03-13 17:45:54', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '51', 2, 56444, TO_TIMESTAMP('2023-03-13 23:01:23', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '14', 2, 1000, TO_TIMESTAMP('2023-03-13 23:34:21', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
-- Day 6
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '00', 1, 900, TO_TIMESTAMP('2023-03-14 13:35:31', 'YYYY-MM-DD HH24:MI:SS'), 'Deposit at Branch','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '00', 4, 200, TO_TIMESTAMP('2023-03-14 13:59:21', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '00', 2, 400, TO_TIMESTAMP('2023-03-14 15:34:21', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '00', 4, 300, TO_TIMESTAMP('2023-03-14 15:55:39', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '51', 2, 34100, TO_TIMESTAMP('2023-03-14 20:23:16', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '06', 3, 250, TO_TIMESTAMP('2023-03-14 21:34:11', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Failed');
-- Previous Day
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '00', 1, 650, current_time - INTERVAL '1' DAY - INTERVAL '22' HOUR - INTERVAL '38' MINUTE - INTERVAL '37' SECOND, 'Refund', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '00', 4, 200, current_time - INTERVAL '1' DAY - INTERVAL '16' HOUR - INTERVAL '10' MINUTE - INTERVAL '9' SECOND, 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '00', 2, 300, current_time - INTERVAL '1' DAY - INTERVAL '12' HOUR - INTERVAL '54' MINUTE - INTERVAL '35' SECOND, 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '00', 4, 150, current_time - INTERVAL '1' DAY - INTERVAL '8' HOUR - INTERVAL '29' MINUTE - INTERVAL '15' SECOND, 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '51', 2, 56000, current_time - INTERVAL '1' DAY - INTERVAL '6' HOUR - INTERVAL '5' MINUTE - INTERVAL '39' SECOND, 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '14', 2, 3000, current_time - INTERVAL '1' DAY - INTERVAL '3' HOUR - INTERVAL '36' MINUTE - INTERVAL '6' SECOND, 'Withdrawal from ATM','Failed');

-- Last hour transactions
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '00', 3, 900, current_time - INTERVAL '21' MINUTE - INTERVAL '49' SECOND, 'Transfer Made', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '00', 4, 200, current_time - INTERVAL '21' MINUTE - INTERVAL '1' SECOND, 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '00', 2, 400, current_time - INTERVAL '20' MINUTE - INTERVAL '19' SECOND, 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '00', 4, 300, current_time - INTERVAL '18' MINUTE - INTERVAL '48' SECOND, 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '51', 2, 32000, current_time - INTERVAL '17' MINUTE - INTERVAL '4' SECOND, 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '00', 1, 1800, current_time - INTERVAL '17' MINUTE - INTERVAL '1' SECOND, 'Deposit at Branch','Completed');
    
-- Account 6
-- Initial balance: 0
-- Final balance: 18000
-- Day 1
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '00', 1, 24000, TO_TIMESTAMP('2023-03-09 04:39:52', 'YYYY-MM-DD HH24:MI:SS'), 'Deposit at Branch','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '00', 2, 2000, TO_TIMESTAMP('2023-03-09 11:39:47', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '00', 4, 250, TO_TIMESTAMP('2023-03-09 11:59:16', 'YYYY-MM-DD HH24:MI:SS'), 'Online Shopping','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '00', 3, 500, TO_TIMESTAMP('2023-03-09 12:39:59', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '14', 2, 7000, TO_TIMESTAMP('2023-03-09 12:50:47', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '51', 2, 35000, TO_TIMESTAMP('2023-03-09 14:35:21', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
-- Day 2
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '00', 2, 500, TO_TIMESTAMP('2023-03-10 15:57:39', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '00', 4, 500, TO_TIMESTAMP('2023-03-10 16:10:53', 'YYYY-MM-DD HH24:MI:SS'), 'Online Subscription','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '54', 4, 200, TO_TIMESTAMP('2023-03-10 16:54:25', 'YYYY-MM-DD HH24:MI:SS'), 'Expired Card', 'Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '00', 1, 750, TO_TIMESTAMP('2023-03-10 17:59:31', 'YYYY-MM-DD HH24:MI:SS'), 'Refund from Online Shopping','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '06', 3, 7000, TO_TIMESTAMP('2023-03-10 20:12:35', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Failed');
-- Day 3
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '00', 1, 2500, TO_TIMESTAMP('2023-03-11 10:25:09', 'YYYY-MM-DD HH24:MI:SS'), 'Salary Deposit','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '00', 4, 200, TO_TIMESTAMP('2023-03-11 12:09:12', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '00', 2, 2800, TO_TIMESTAMP('2023-03-11 13:15:27', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '00', 4, 1000, TO_TIMESTAMP('2023-03-11 17:49:32', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '51', 2, 35000, TO_TIMESTAMP('2023-03-11 18:41:29', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '14', 2, 2000, TO_TIMESTAMP('2023-03-11 19:55:21', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '00', 3, 1500, TO_TIMESTAMP('2023-03-11 20:24:45', 'YYYY-MM-DD HH24:MI:SS'), 'Outward Transfer','Completed');
-- Day 4, 5, 6, and 7
-- Add similar transactions to the above pattern for the remaining days.
-- Day 4
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '00', 1, 900, TO_TIMESTAMP('2023-03-12 02:52:23', 'YYYY-MM-DD HH24:MI:SS'), 'Refund', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '00', 4, 200, TO_TIMESTAMP('2023-03-12 05:34:21', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '00', 2, 400, TO_TIMESTAMP('2023-03-12 09:29:23', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '00', 4, 300, TO_TIMESTAMP('2023-03-12 10:51:09', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '51', 2, 30000, TO_TIMESTAMP('2023-03-12 20:45:32', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '06', 3, 5000, TO_TIMESTAMP('2023-03-12 22:21:56', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Failed');
-- Day 5
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '00', 1, 650, TO_TIMESTAMP('2023-03-13 05:55:29', 'YYYY-MM-DD HH24:MI:SS'), 'Deposit at Branch','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '00', 4, 200, TO_TIMESTAMP('2023-03-13 10:51:13', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '00', 2, 300, TO_TIMESTAMP('2023-03-13 14:32:46', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '00', 4, 150, TO_TIMESTAMP('2023-03-13 16:45:54', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '51', 2, 56444, TO_TIMESTAMP('2023-03-13 20:01:23', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '14', 2, 1000, TO_TIMESTAMP('2023-03-13 22:34:21', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
-- Day 6
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '00', 1, 900, TO_TIMESTAMP('2023-03-14 00:35:31', 'YYYY-MM-DD HH24:MI:SS'), 'Deposit at Branch','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '00', 4, 200, TO_TIMESTAMP('2023-03-14 05:59:21', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '00', 2, 400, TO_TIMESTAMP('2023-03-14 11:34:21', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '00', 4, 300, TO_TIMESTAMP('2023-03-14 15:55:39', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '51', 2, 34100, TO_TIMESTAMP('2023-03-14 22:23:16', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '06', 3, 250, TO_TIMESTAMP('2023-03-14 23:34:11', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Failed');
-- Previous Day
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '00', 1, 650, current_time - INTERVAL '1' DAY - INTERVAL '18' HOUR - INTERVAL '38' MINUTE - INTERVAL '37' SECOND, 'Refund', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '00', 4, 200, current_time - INTERVAL '1' DAY - INTERVAL '11' HOUR - INTERVAL '10' MINUTE - INTERVAL '9' SECOND, 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '00', 2, 300, current_time - INTERVAL '1' DAY - INTERVAL '7' HOUR - INTERVAL '54' MINUTE - INTERVAL '35' SECOND, 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '00', 4, 150, current_time - INTERVAL '1' DAY - INTERVAL '5' HOUR - INTERVAL '29' MINUTE - INTERVAL '15' SECOND, 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '51', 2, 56000, current_time - INTERVAL '1' DAY - INTERVAL '6' HOUR - INTERVAL '5' MINUTE - INTERVAL '39' SECOND, 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '14', 2, 3000, current_time - INTERVAL '1' DAY - INTERVAL '1' HOUR - INTERVAL '36' MINUTE - INTERVAL '6' SECOND, 'Withdrawal from ATM','Failed');

-- Last hour transactions
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '00', 3, 900, current_time - INTERVAL '21' MINUTE - INTERVAL '59' SECOND, 'Transfer Made', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '00', 4, 200, current_time - INTERVAL '21' MINUTE - INTERVAL '5' SECOND, 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '00', 2, 400, current_time - INTERVAL '20' MINUTE - INTERVAL '49' SECOND, 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '00', 4, 300, current_time - INTERVAL '18' MINUTE - INTERVAL '48' SECOND, 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '51', 2, 32000, current_time - INTERVAL '17' MINUTE - INTERVAL '15' SECOND, 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '00', 1, 1800, current_time - INTERVAL '11' MINUTE - INTERVAL '36' SECOND, 'Deposit at Branch','Completed');
    
-- Account 7
-- Initial balance: 0
-- Final balance: 9000
-- Day 1
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '00', 1, 16000, TO_TIMESTAMP('2023-03-09 01:39:52', 'YYYY-MM-DD HH24:MI:SS'), 'Deposit at Branch','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '00', 2, 3000, TO_TIMESTAMP('2023-03-09 10:39:47', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '00', 4, 250, TO_TIMESTAMP('2023-03-09 11:29:16', 'YYYY-MM-DD HH24:MI:SS'), 'Online Shopping','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '00', 3, 500, TO_TIMESTAMP('2023-03-09 11:39:59', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '14', 2, 7000, TO_TIMESTAMP('2023-03-09 12:40:47', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '51', 2, 35000, TO_TIMESTAMP('2023-03-09 14:35:21', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
-- Day 2
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '00', 2, 500, TO_TIMESTAMP('2023-03-10 14:57:39', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '00', 4, 500, TO_TIMESTAMP('2023-03-10 15:10:53', 'YYYY-MM-DD HH24:MI:SS'), 'Online Subscription','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '54', 4, 200, TO_TIMESTAMP('2023-03-10 16:54:25', 'YYYY-MM-DD HH24:MI:SS'), 'Expired Card', 'Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '00', 1, 750, TO_TIMESTAMP('2023-03-10 16:59:31', 'YYYY-MM-DD HH24:MI:SS'), 'Refund from Online Shopping','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '06', 3, 7000, TO_TIMESTAMP('2023-03-10 19:12:35', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Failed');
-- Day 3
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '00', 1, 2500, TO_TIMESTAMP('2023-03-11 01:25:09', 'YYYY-MM-DD HH24:MI:SS'), 'Salary Deposit','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '00', 4, 200, TO_TIMESTAMP('2023-03-11 07:09:12', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '00', 2, 2800, TO_TIMESTAMP('2023-03-11 10:15:27', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '00', 4, 1000, TO_TIMESTAMP('2023-03-11 11:49:32', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '51', 2, 35000, TO_TIMESTAMP('2023-03-11 12:41:29', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '14', 2, 2000, TO_TIMESTAMP('2023-03-11 13:55:21', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '00', 3, 1500, TO_TIMESTAMP('2023-03-11 21:23:45', 'YYYY-MM-DD HH24:MI:SS'), 'Outward Transfer','Completed');
-- Day 4, 5, 6, and 7
-- Add similar transactions to the above pattern for the remaining days.
-- Day 4
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '00', 1, 900, TO_TIMESTAMP('2023-03-12 05:52:23', 'YYYY-MM-DD HH24:MI:SS'), 'Refund', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '00', 4, 200, TO_TIMESTAMP('2023-03-12 09:34:21', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '00', 2, 400, TO_TIMESTAMP('2023-03-12 10:29:23', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '00', 4, 300, TO_TIMESTAMP('2023-03-12 19:51:09', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '51', 2, 30000, TO_TIMESTAMP('2023-03-12 22:45:32', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '06', 3, 5000, TO_TIMESTAMP('2023-03-12 23:45:56', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Failed');
-- Day 5
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '00', 1, 650, TO_TIMESTAMP('2023-03-13 09:55:29', 'YYYY-MM-DD HH24:MI:SS'), 'Deposit at Branch','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '00', 4, 200, TO_TIMESTAMP('2023-03-13 11:51:13', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '00', 2, 300, TO_TIMESTAMP('2023-03-13 13:32:46', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '00', 4, 150, TO_TIMESTAMP('2023-03-13 17:45:54', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '51', 2, 56444, TO_TIMESTAMP('2023-03-13 23:01:23', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '14', 2, 1000, TO_TIMESTAMP('2023-03-13 23:34:21', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
-- Day 6
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '00', 1, 900, TO_TIMESTAMP('2023-03-14 13:35:31', 'YYYY-MM-DD HH24:MI:SS'), 'Deposit at Branch','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '00', 4, 200, TO_TIMESTAMP('2023-03-14 13:59:21', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '00', 2, 400, TO_TIMESTAMP('2023-03-14 15:34:21', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '00', 4, 300, TO_TIMESTAMP('2023-03-14 15:55:39', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '51', 2, 34100, TO_TIMESTAMP('2023-03-14 20:23:16', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '06', 3, 250, TO_TIMESTAMP('2023-03-14 21:34:11', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Failed');
-- Previous Day
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '00', 1, 650, current_time - INTERVAL '1' DAY - INTERVAL '18' HOUR - INTERVAL '38' MINUTE - INTERVAL '37' SECOND, 'Refund', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '00', 4, 200, current_time - INTERVAL '1' DAY - INTERVAL '11' HOUR - INTERVAL '10' MINUTE - INTERVAL '9' SECOND, 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '00', 2, 300, current_time - INTERVAL '1' DAY - INTERVAL '7' HOUR - INTERVAL '54' MINUTE - INTERVAL '35' SECOND, 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '00', 4, 150, current_time - INTERVAL '1' DAY - INTERVAL '5' HOUR - INTERVAL '29' MINUTE - INTERVAL '15' SECOND, 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '51', 2, 56000, current_time - INTERVAL '1' DAY - INTERVAL '6' HOUR - INTERVAL '5' MINUTE - INTERVAL '39' SECOND, 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '14', 2, 3000, current_time - INTERVAL '1' DAY - INTERVAL '1' HOUR - INTERVAL '36' MINUTE - INTERVAL '6' SECOND, 'Withdrawal from ATM','Failed');

-- Last hour transactions
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '00', 3, 1500, current_time - INTERVAL '22' MINUTE - INTERVAL '54' SECOND, 'Transfer Made', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '00', 4, 500, current_time - INTERVAL '20' MINUTE - INTERVAL '51' SECOND, 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '00', 2, 600, current_time - INTERVAL '16' MINUTE - INTERVAL '20' SECOND, 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '00', 4, 400, current_time - INTERVAL '14' MINUTE - INTERVAL '41' SECOND, 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '51', 2, 32000, current_time - INTERVAL '13' MINUTE - INTERVAL '49' SECOND, 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '00', 1, 3000, current_time - INTERVAL '11' MINUTE - INTERVAL '36' SECOND, 'Deposit at Branch','Completed');
    
-- Account 8
-- Initial balance: 0
-- Final balance: 30000
-- Day 1
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '00', 1, 36000, TO_TIMESTAMP('2023-03-09 11:39:52', 'YYYY-MM-DD HH24:MI:SS'), 'Deposit at Branch','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '00', 2, 2000, TO_TIMESTAMP('2023-03-09 14:39:47', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '00', 4, 250, TO_TIMESTAMP('2023-03-09 16:29:16', 'YYYY-MM-DD HH24:MI:SS'), 'Online Shopping','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '00', 3, 500, TO_TIMESTAMP('2023-03-09 16:39:59', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '14', 2, 7000, TO_TIMESTAMP('2023-03-09 18:40:47', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '51', 2, 40000, TO_TIMESTAMP('2023-03-09 23:35:21', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
-- Day 2
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '00', 2, 500, TO_TIMESTAMP('2023-03-10 11:57:39', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '00', 4, 500, TO_TIMESTAMP('2023-03-10 16:10:53', 'YYYY-MM-DD HH24:MI:SS'), 'Online Subscription','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '54', 4, 200, TO_TIMESTAMP('2023-03-10 16:54:25', 'YYYY-MM-DD HH24:MI:SS'), 'Expired Card', 'Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '00', 1, 750, TO_TIMESTAMP('2023-03-10 17:59:31', 'YYYY-MM-DD HH24:MI:SS'), 'Refund from Online Shopping','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '06', 3, 7000, TO_TIMESTAMP('2023-03-10 19:12:35', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Failed');
-- Day 3
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '00', 1, 2500, TO_TIMESTAMP('2023-03-11 01:25:09', 'YYYY-MM-DD HH24:MI:SS'), 'Salary Deposit','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '00', 4, 200, TO_TIMESTAMP('2023-03-11 10:09:12', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '00', 2, 2800, TO_TIMESTAMP('2023-03-11 15:15:27', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '00', 4, 1000, TO_TIMESTAMP('2023-03-11 16:49:32', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '51', 2, 45000, TO_TIMESTAMP('2023-03-11 20:41:29', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '14', 2, 2000, TO_TIMESTAMP('2023-03-11 22:55:21', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '00', 3, 1500, TO_TIMESTAMP('2023-03-11 23:23:45', 'YYYY-MM-DD HH24:MI:SS'), 'Outward Transfer','Completed');
-- Day 4, 5, 6, and 7
-- Add similar transactions to the above pattern for the remaining days.
-- Day 4
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '00', 1, 900, TO_TIMESTAMP('2023-03-12 00:52:23', 'YYYY-MM-DD HH24:MI:SS'), 'Refund', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '00', 4, 200, TO_TIMESTAMP('2023-03-12 09:34:21', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '00', 2, 400, TO_TIMESTAMP('2023-03-12 10:29:23', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '00', 4, 300, TO_TIMESTAMP('2023-03-12 20:51:09', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '51', 2, 56000, TO_TIMESTAMP('2023-03-12 21:45:32', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '06', 3, 5000, TO_TIMESTAMP('2023-03-12 23:45:56', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Failed');
-- Day 5
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '00', 1, 650, TO_TIMESTAMP('2023-03-13 11:55:29', 'YYYY-MM-DD HH24:MI:SS'), 'Deposit at Branch','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '00', 4, 200, TO_TIMESTAMP('2023-03-13 15:51:13', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '00', 2, 300, TO_TIMESTAMP('2023-03-13 17:32:46', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '00', 4, 150, TO_TIMESTAMP('2023-03-13 17:45:54', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '51', 2, 56444, TO_TIMESTAMP('2023-03-13 20:01:23', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '14', 2, 1000, TO_TIMESTAMP('2023-03-13 21:34:21', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
-- Day 6
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '00', 1, 900, TO_TIMESTAMP('2023-03-14 03:35:31', 'YYYY-MM-DD HH24:MI:SS'), 'Deposit at Branch','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '00', 4, 200, TO_TIMESTAMP('2023-03-14 09:59:21', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '00', 2, 400, TO_TIMESTAMP('2023-03-14 20:34:21', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '00', 4, 300, TO_TIMESTAMP('2023-03-14 21:55:39', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '51', 2, 43000, TO_TIMESTAMP('2023-03-14 22:23:16', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '06', 3, 250, TO_TIMESTAMP('2023-03-14 22:34:11', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Failed');
-- Previous Day
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '00', 1, 650, current_time - INTERVAL '1' DAY - INTERVAL '18' HOUR - INTERVAL '38' MINUTE - INTERVAL '37' SECOND, 'Refund', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '00', 4, 200, current_time - INTERVAL '1' DAY - INTERVAL '8' HOUR - INTERVAL '10' MINUTE - INTERVAL '9' SECOND, 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '00', 2, 300, current_time - INTERVAL '1' DAY - INTERVAL '7' HOUR - INTERVAL '54' MINUTE - INTERVAL '35' SECOND, 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '00', 4, 150, current_time - INTERVAL '1' DAY - INTERVAL '3' HOUR - INTERVAL '29' MINUTE - INTERVAL '15' SECOND, 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '51', 2, 56000, current_time - INTERVAL '1' DAY - INTERVAL '2' HOUR - INTERVAL '5' MINUTE - INTERVAL '39' SECOND, 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '14', 2, 3000, current_time - INTERVAL '1' DAY - INTERVAL '23' MINUTE - INTERVAL '6' SECOND, 'Withdrawal from ATM','Failed');

-- Last hour transactions
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '00', 3, 1200, current_time - INTERVAL '22' MINUTE - INTERVAL '49' SECOND, 'Transfer Made', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '00', 4, 600, current_time - INTERVAL '21' MINUTE - INTERVAL '1' SECOND, 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '00', 2, 400, current_time - INTERVAL '20' MINUTE - INTERVAL '18' SECOND, 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '00', 4, 200, current_time - INTERVAL '15' MINUTE - INTERVAL '48' SECOND, 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '51', 2, 32000, current_time - INTERVAL '14' MINUTE - INTERVAL '4' SECOND, 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '14', 2, 2000, current_time - INTERVAL '13' MINUTE - INTERVAL '59' SECOND, 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '00', 1, 2400, current_time - INTERVAL '11' MINUTE - INTERVAL '36' SECOND, 'Deposit at Branch','Completed');

    
-- Account 9
-- Initial balance: 0
-- Final balance: 1000
-- Day 1
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(109, '00', 1, 7000, TO_TIMESTAMP('2023-03-09 01:39:52', 'YYYY-MM-DD HH24:MI:SS'), 'Deposit at Branch','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(109, '00', 2, 2000, TO_TIMESTAMP('2023-03-09 10:39:47', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(109, '00', 4, 250, TO_TIMESTAMP('2023-03-09 11:29:16', 'YYYY-MM-DD HH24:MI:SS'), 'Online Shopping','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(109, '00', 3, 500, TO_TIMESTAMP('2023-03-09 11:39:59', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(109, '14', 2, 7000, TO_TIMESTAMP('2023-03-09 12:40:47', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(109, '51', 2, 8000, TO_TIMESTAMP('2023-03-09 14:35:21', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
-- Day 2
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(109, '00', 2, 500, TO_TIMESTAMP('2023-03-10 14:57:39', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(109, '00', 4, 500, TO_TIMESTAMP('2023-03-10 15:10:53', 'YYYY-MM-DD HH24:MI:SS'), 'Online Subscription','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(109, '54', 4, 200, TO_TIMESTAMP('2023-03-10 16:54:25', 'YYYY-MM-DD HH24:MI:SS'), 'Expired Card', 'Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(109, '00', 1, 750, TO_TIMESTAMP('2023-03-10 16:59:31', 'YYYY-MM-DD HH24:MI:SS'), 'Refund from Online Shopping','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(109, '06', 3, 7000, TO_TIMESTAMP('2023-03-10 19:12:35', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Failed');
-- Day 3
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(109, '00', 1, 2500, TO_TIMESTAMP('2023-03-11 01:25:09', 'YYYY-MM-DD HH24:MI:SS'), 'Salary Deposit','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(109, '00', 4, 200, TO_TIMESTAMP('2023-03-11 07:09:12', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(109, '00', 2, 2800, TO_TIMESTAMP('2023-03-11 10:15:27', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(109, '00', 4, 1000, TO_TIMESTAMP('2023-03-11 11:49:32', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(109, '51', 2, 8000, TO_TIMESTAMP('2023-03-11 12:41:29', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(109, '14', 2, 2000, TO_TIMESTAMP('2023-03-11 13:55:21', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(109, '00', 3, 1500, TO_TIMESTAMP('2023-03-11 21:23:45', 'YYYY-MM-DD HH24:MI:SS'), 'Outward Transfer','Completed');
-- Day 4, 5, 6, and 7
-- Add similar transactions to the above pattern for the remaining days.
-- Day 4
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(109, '00', 1, 900, TO_TIMESTAMP('2023-03-12 05:52:23', 'YYYY-MM-DD HH24:MI:SS'), 'Refund', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(109, '00', 4, 200, TO_TIMESTAMP('2023-03-12 09:34:21', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(109, '00', 2, 400, TO_TIMESTAMP('2023-03-12 10:29:23', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(109, '00', 4, 300, TO_TIMESTAMP('2023-03-12 19:51:09', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(109, '51', 2, 5000, TO_TIMESTAMP('2023-03-12 22:45:32', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(109, '06', 3, 5000, TO_TIMESTAMP('2023-03-12 23:45:56', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Failed');
-- Day 5
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(109, '00', 1, 650, TO_TIMESTAMP('2023-03-13 09:55:29', 'YYYY-MM-DD HH24:MI:SS'), 'Deposit at Branch','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(109, '00', 4, 200, TO_TIMESTAMP('2023-03-13 11:51:13', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(109, '00', 2, 300, TO_TIMESTAMP('2023-03-13 13:32:46', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(109, '00', 4, 150, TO_TIMESTAMP('2023-03-13 17:45:54', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(109, '51', 2, 3000, TO_TIMESTAMP('2023-03-13 23:01:23', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(109, '14', 2, 1000, TO_TIMESTAMP('2023-03-13 23:34:21', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
-- Day 6
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(109, '00', 1, 900, TO_TIMESTAMP('2023-03-14 13:35:31', 'YYYY-MM-DD HH24:MI:SS'), 'Deposit at Branch','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(109, '00', 4, 200, TO_TIMESTAMP('2023-03-14 13:59:21', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(109, '00', 2, 400, TO_TIMESTAMP('2023-03-14 15:34:21', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(109, '00', 4, 300, TO_TIMESTAMP('2023-03-14 15:55:39', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(109, '51', 2, 4000, TO_TIMESTAMP('2023-03-14 20:23:16', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(109, '06', 3, 250, TO_TIMESTAMP('2023-03-14 21:34:11', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Failed');
-- Previous Day
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(109, '00', 1, 650, current_time - INTERVAL '1' DAY - INTERVAL '18' HOUR - INTERVAL '38' MINUTE - INTERVAL '37' SECOND, 'Refund', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(109, '00', 4, 200, current_time - INTERVAL '1' DAY - INTERVAL '12' HOUR - INTERVAL '10' MINUTE - INTERVAL '9' SECOND, 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(109, '00', 2, 300, current_time - INTERVAL '1' DAY - INTERVAL '7' HOUR - INTERVAL '54' MINUTE - INTERVAL '35' SECOND, 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(109, '00', 4, 150, current_time - INTERVAL '1' DAY - INTERVAL '4' HOUR - INTERVAL '29' MINUTE - INTERVAL '15' SECOND, 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(109, '51', 2, 4000, current_time - INTERVAL '1' DAY - INTERVAL '2' HOUR - INTERVAL '5' MINUTE - INTERVAL '39' SECOND, 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(109, '14', 2, 3000, current_time - INTERVAL '7' DAY - INTERVAL '3' HOUR - INTERVAL '36' MINUTE - INTERVAL '6' SECOND, 'Withdrawal from ATM','Failed');

-- Last hour transactions
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(109, '00', 3, 900, current_time - INTERVAL '22' MINUTE - INTERVAL '0' SECOND, 'Transfer Made', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(109, '00', 4, 200, current_time - INTERVAL '21' MINUTE - INTERVAL '48' SECOND, 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(109, '00', 2, 400, current_time - INTERVAL '19' MINUTE - INTERVAL '1' SECOND, 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(109, '00', 4, 300, current_time - INTERVAL '17' MINUTE - INTERVAL '40' SECOND, 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(109, '51', 2, 4000, current_time - INTERVAL '16' MINUTE - INTERVAL '36' SECOND, 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(109, '00', 1, 1800, current_time - INTERVAL '11' MINUTE - INTERVAL '36' SECOND, 'Deposit at Branch','Completed');
    
-- Account 10
-- Initial balance: 0
-- Final balance: 8000
-- Day 1
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(110, '00', 1, 16000, TO_TIMESTAMP('2023-03-09 01:31:42', 'YYYY-MM-DD HH24:MI:SS'), 'Deposit at Branch','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(110, '00', 2, 4000, TO_TIMESTAMP('2023-03-09 04:23:47', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(110, '00', 4, 250, TO_TIMESTAMP('2023-03-09 07:18:16', 'YYYY-MM-DD HH24:MI:SS'), 'Online Shopping','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(110, '00', 3, 500, TO_TIMESTAMP('2023-03-09 10:12:09', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(110, '14', 2, 7000, TO_TIMESTAMP('2023-03-09 11:11:43', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(110, '51', 2, 20000, TO_TIMESTAMP('2023-03-09 14:35:00', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
-- Day 2
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(110, '00', 2, 500, TO_TIMESTAMP('2023-03-10 11:57:30', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(110, '00', 4, 500, TO_TIMESTAMP('2023-03-10 13:10:23', 'YYYY-MM-DD HH24:MI:SS'), 'Online Subscription','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(110, '54', 4, 200, TO_TIMESTAMP('2023-03-10 15:21:54', 'YYYY-MM-DD HH24:MI:SS'), 'Expired Card', 'Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(110, '00', 1, 750, TO_TIMESTAMP('2023-03-10 16:33:21', 'YYYY-MM-DD HH24:MI:SS'), 'Refund from Online Shopping','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(110, '06', 3, 7000, TO_TIMESTAMP('2023-03-10 23:55:33', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Failed');
-- Day 3
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(110, '00', 1, 2500, TO_TIMESTAMP('2023-03-11 11:15:20', 'YYYY-MM-DD HH24:MI:SS'), 'Salary Deposit','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(110, '00', 4, 200, TO_TIMESTAMP('2023-03-11 12:20:56', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(110, '00', 2, 2800, TO_TIMESTAMP('2023-03-11 12:50:20', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(110, '00', 4, 1000, TO_TIMESTAMP('2023-03-11 13:29:39', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(110, '51', 2, 15000, TO_TIMESTAMP('2023-03-11 13:45:21', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(110, '14', 2, 2000, TO_TIMESTAMP('2023-03-11 14:39:29', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(110, '00', 3, 1500, TO_TIMESTAMP('2023-03-11 19:49:19', 'YYYY-MM-DD HH24:MI:SS'), 'Outward Transfer','Completed');
-- Day 4, 5, 6, and 7
-- Add similar transactions to the above pattern for the remaining days.
-- Day 4
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(110, '00', 1, 800, TO_TIMESTAMP('2023-03-12 03:31:22', 'YYYY-MM-DD HH24:MI:SS'), 'Refund', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(110, '00', 4, 200, TO_TIMESTAMP('2023-03-12 13:24:25', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(110, '00', 2, 300, TO_TIMESTAMP('2023-03-12 13:29:40', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(110, '00', 4, 300, TO_TIMESTAMP('2023-03-12 22:34:49', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(110, '51', 2, 14800, TO_TIMESTAMP('2023-03-12 22:40:32', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(110, '06', 3, 5000, TO_TIMESTAMP('2023-03-12 23:40:56', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Failed');
-- Day 5
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(110, '00', 1, 650, TO_TIMESTAMP('2023-03-13 05:55:29', 'YYYY-MM-DD HH24:MI:SS'), 'Deposit at Branch','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(110, '00', 4, 200, TO_TIMESTAMP('2023-03-13 08:51:02', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(110, '00', 2, 300, TO_TIMESTAMP('2023-03-13 10:23:45', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(110, '00', 4, 150, TO_TIMESTAMP('2023-03-13 17:54:43', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(110, '51', 2, 12270, TO_TIMESTAMP('2023-03-13 17:59:09', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(110, '14', 2, 1000, TO_TIMESTAMP('2023-03-13 21:41:25', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
-- Day 6
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(110, '00', 1, 800, TO_TIMESTAMP('2023-03-14 04:26:28', 'YYYY-MM-DD HH24:MI:SS'), 'Deposit at Branch','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(110, '00', 4, 200, TO_TIMESTAMP('2023-03-14 10:30:44', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(110, '00', 2, 300, TO_TIMESTAMP('2023-03-14 13:19:32', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(110, '00', 4, 300, TO_TIMESTAMP('2023-03-14 14:55:34', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(110, '51', 2, 13275, TO_TIMESTAMP('2023-03-14 19:25:32', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(110, '06', 3, 250, TO_TIMESTAMP('2023-03-14 21:29:11', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Failed');
-- Previous Day
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(110, '00', 1, 650, current_time - INTERVAL '1' DAY - INTERVAL '18' HOUR - INTERVAL '15' MINUTE - INTERVAL '10' SECOND, 'Refund', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(110, '00', 4, 200, current_time - INTERVAL '1' DAY - INTERVAL '12' HOUR - INTERVAL '14' MINUTE - INTERVAL '39' SECOND, 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(110, '00', 2, 300, current_time - INTERVAL '1' DAY - INTERVAL '8' HOUR - INTERVAL '48' MINUTE - INTERVAL '26' SECOND, 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(110, '00', 4, 150, current_time - INTERVAL '1' DAY - INTERVAL '4' HOUR - INTERVAL '14' MINUTE - INTERVAL '28' SECOND, 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(110, '51', 2, 10000, current_time - INTERVAL '1' DAY - INTERVAL '2' HOUR - INTERVAL '26' MINUTE - INTERVAL '49' SECOND, 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(110, '14', 2, 3000, current_time - INTERVAL '7' DAY - INTERVAL '3' HOUR - INTERVAL '57' MINUTE - INTERVAL '36' SECOND, 'Withdrawal from ATM','Failed');

-- Last hour transactions
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(110, '00', 3, 500, current_time - INTERVAL '23' MINUTE - INTERVAL '48' SECOND, 'Transfer Made', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(110, '00', 4, 200, current_time - INTERVAL '22' MINUTE - INTERVAL '31' SECOND, 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(110, '00', 2, 200, current_time - INTERVAL '20' MINUTE - INTERVAL '59' SECOND, 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(110, '00', 4, 100, current_time - INTERVAL '18' MINUTE - INTERVAL '1' SECOND, 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(110, '51', 2, 9000, current_time - INTERVAL '17' MINUTE - INTERVAL '15' SECOND, 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(110, '00', 1, 1000, current_time - INTERVAL '11' MINUTE - INTERVAL '36' SECOND, 'Deposit at Branch','Completed');
    
-- Account 11
-- Initial balance: 0
-- Final balance: 2000
-- Day 1
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(111, '00', 1, 8000, TO_TIMESTAMP('2023-03-09 01:39:52', 'YYYY-MM-DD HH24:MI:SS'), 'Deposit at Branch','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(111, '00', 2, 2000, TO_TIMESTAMP('2023-03-09 10:39:47', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(111, '00', 4, 250, TO_TIMESTAMP('2023-03-09 11:29:16', 'YYYY-MM-DD HH24:MI:SS'), 'Online Shopping','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(111, '00', 3, 500, TO_TIMESTAMP('2023-03-09 11:39:59', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(111, '14', 2, 7000, TO_TIMESTAMP('2023-03-09 12:40:47', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(111, '51', 2, 8000, TO_TIMESTAMP('2023-03-09 14:35:21', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
-- Day 2
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(111, '00', 2, 500, TO_TIMESTAMP('2023-03-10 14:57:39', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(111, '00', 4, 500, TO_TIMESTAMP('2023-03-10 15:10:53', 'YYYY-MM-DD HH24:MI:SS'), 'Online Subscription','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(111, '54', 4, 200, TO_TIMESTAMP('2023-03-10 16:54:25', 'YYYY-MM-DD HH24:MI:SS'), 'Expired Card', 'Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(111, '00', 1, 750, TO_TIMESTAMP('2023-03-10 16:59:31', 'YYYY-MM-DD HH24:MI:SS'), 'Refund from Online Shopping','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(111, '06', 3, 7000, TO_TIMESTAMP('2023-03-10 19:12:35', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Failed');
-- Day 3
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(111, '00', 1, 2500, TO_TIMESTAMP('2023-03-11 01:25:09', 'YYYY-MM-DD HH24:MI:SS'), 'Salary Deposit','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(111, '00', 4, 200, TO_TIMESTAMP('2023-03-11 07:09:12', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(111, '00', 2, 2800, TO_TIMESTAMP('2023-03-11 10:15:27', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(111, '00', 4, 1000, TO_TIMESTAMP('2023-03-11 11:49:32', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(111, '51', 2, 8000, TO_TIMESTAMP('2023-03-11 12:41:29', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(111, '14', 2, 2000, TO_TIMESTAMP('2023-03-11 13:55:21', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(111, '00', 3, 1500, TO_TIMESTAMP('2023-03-11 21:23:45', 'YYYY-MM-DD HH24:MI:SS'), 'Outward Transfer','Completed');
-- Day 4, 5, 6, and 7
-- Add similar transactions to the above pattern for the remaining days.
-- Day 4
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(111, '00', 1, 900, TO_TIMESTAMP('2023-03-12 05:52:23', 'YYYY-MM-DD HH24:MI:SS'), 'Refund', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(111, '00', 4, 200, TO_TIMESTAMP('2023-03-12 09:34:21', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(111, '00', 2, 400, TO_TIMESTAMP('2023-03-12 10:29:23', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(111, '00', 4, 300, TO_TIMESTAMP('2023-03-12 19:51:09', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(111, '51', 2, 5000, TO_TIMESTAMP('2023-03-12 22:45:32', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(111, '06', 3, 5000, TO_TIMESTAMP('2023-03-12 23:45:56', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Failed');
-- Day 5
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(111, '00', 1, 650, TO_TIMESTAMP('2023-03-13 09:55:29', 'YYYY-MM-DD HH24:MI:SS'), 'Deposit at Branch','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(111, '00', 4, 200, TO_TIMESTAMP('2023-03-13 11:51:13', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(111, '00', 2, 300, TO_TIMESTAMP('2023-03-13 13:32:46', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(111, '00', 4, 150, TO_TIMESTAMP('2023-03-13 17:45:54', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(111, '51', 2, 3000, TO_TIMESTAMP('2023-03-13 23:01:23', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(111, '14', 2, 1000, TO_TIMESTAMP('2023-03-13 23:34:21', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
-- Day 6
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(111, '00', 1, 900, TO_TIMESTAMP('2023-03-14 13:35:31', 'YYYY-MM-DD HH24:MI:SS'), 'Deposit at Branch','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(111, '00', 4, 200, TO_TIMESTAMP('2023-03-14 13:59:21', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(111, '00', 2, 400, TO_TIMESTAMP('2023-03-14 15:34:21', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(111, '00', 4, 300, TO_TIMESTAMP('2023-03-14 15:55:39', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(111, '51', 2, 4000, TO_TIMESTAMP('2023-03-14 20:23:16', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(111, '06', 3, 250, TO_TIMESTAMP('2023-03-14 21:34:11', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Failed');
-- Previous Day
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(111, '00', 1, 650, current_time - INTERVAL '1' DAY - INTERVAL '18' HOUR - INTERVAL '37' MINUTE - INTERVAL '37' SECOND, 'Refund', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(111, '00', 4, 200, current_time - INTERVAL '1' DAY - INTERVAL '12' HOUR - INTERVAL '10' MINUTE - INTERVAL '9' SECOND, 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(111, '00', 2, 300, current_time - INTERVAL '1' DAY - INTERVAL '7' HOUR - INTERVAL '54' MINUTE - INTERVAL '35' SECOND, 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(111, '00', 4, 150, current_time - INTERVAL '1' DAY - INTERVAL '4' HOUR - INTERVAL '29' MINUTE - INTERVAL '15' SECOND, 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(111, '51', 2, 4000, current_time - INTERVAL '1' DAY - INTERVAL '2' HOUR - INTERVAL '5' MINUTE - INTERVAL '39' SECOND, 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(111, '14', 2, 3000, current_time - INTERVAL '7' DAY - INTERVAL '3' HOUR - INTERVAL '36' MINUTE - INTERVAL '6' SECOND, 'Withdrawal from ATM','Failed');

-- Last hour transactions
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(111, '00', 3, 600, current_time - INTERVAL '23' MINUTE - INTERVAL '39' SECOND, 'Transfer Made', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(111, '00', 4, 100, current_time - INTERVAL '22' MINUTE - INTERVAL '48' SECOND, 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(111, '00', 2, 250, current_time - INTERVAL '20' MINUTE - INTERVAL '1' SECOND, 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(111, '00', 4, 250, current_time - INTERVAL '16' MINUTE - INTERVAL '40' SECOND, 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(111, '51', 2, 4000, current_time - INTERVAL '16' MINUTE - INTERVAL '36' SECOND, 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(111, '00', 1, 1200, current_time - INTERVAL '11' MINUTE - INTERVAL '36' SECOND, 'Deposit at Branch','Completed');
    
-- Account 12
-- Initial balance: 0
-- Final balance: 40000
-- Day 1
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(112, '00', 1, 48000, TO_TIMESTAMP('2023-03-09 11:39:52', 'YYYY-MM-DD HH24:MI:SS'), 'Deposit at Branch','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(112, '00', 2, 4000, TO_TIMESTAMP('2023-03-09 14:39:47', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(112, '00', 4, 250, TO_TIMESTAMP('2023-03-09 16:29:16', 'YYYY-MM-DD HH24:MI:SS'), 'Online Shopping','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(112, '00', 3, 500, TO_TIMESTAMP('2023-03-09 16:39:59', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(112, '14', 2, 7000, TO_TIMESTAMP('2023-03-09 18:40:47', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(112, '51', 2, 51000, TO_TIMESTAMP('2023-03-09 23:35:21', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
-- Day 2
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(112, '00', 2, 500, TO_TIMESTAMP('2023-03-10 11:57:39', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(112, '00', 4, 500, TO_TIMESTAMP('2023-03-10 16:10:53', 'YYYY-MM-DD HH24:MI:SS'), 'Online Subscription','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(112, '54', 4, 200, TO_TIMESTAMP('2023-03-10 16:54:25', 'YYYY-MM-DD HH24:MI:SS'), 'Expired Card', 'Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(112, '00', 1, 750, TO_TIMESTAMP('2023-03-10 17:59:31', 'YYYY-MM-DD HH24:MI:SS'), 'Refund from Online Shopping','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(112, '06', 3, 7000, TO_TIMESTAMP('2023-03-10 19:12:35', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Failed');
-- Day 3
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(112, '00', 1, 2500, TO_TIMESTAMP('2023-03-11 01:25:09', 'YYYY-MM-DD HH24:MI:SS'), 'Salary Deposit','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(112, '00', 4, 200, TO_TIMESTAMP('2023-03-11 10:09:12', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(112, '00', 2, 2800, TO_TIMESTAMP('2023-03-11 15:15:27', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(112, '00', 4, 1000, TO_TIMESTAMP('2023-03-11 16:49:32', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(112, '51', 2, 49000, TO_TIMESTAMP('2023-03-11 20:41:29', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(112, '14', 2, 2000, TO_TIMESTAMP('2023-03-11 22:55:21', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(112, '00', 3, 1500, TO_TIMESTAMP('2023-03-11 23:23:45', 'YYYY-MM-DD HH24:MI:SS'), 'Outward Transfer','Completed');
-- Day 4, 5, 6, and 7
-- Add similar transactions to the above pattern for the remaining days.
-- Day 4
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(112, '00', 1, 900, TO_TIMESTAMP('2023-03-12 00:52:23', 'YYYY-MM-DD HH24:MI:SS'), 'Refund', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(112, '00', 4, 200, TO_TIMESTAMP('2023-03-12 09:34:21', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(112, '00', 2, 400, TO_TIMESTAMP('2023-03-12 10:29:23', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(112, '00', 4, 300, TO_TIMESTAMP('2023-03-12 20:51:09', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(112, '51', 2, 56000, TO_TIMESTAMP('2023-03-12 21:45:32', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(112, '06', 3, 5000, TO_TIMESTAMP('2023-03-12 23:45:56', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Failed');
-- Day 5
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(112, '00', 1, 650, TO_TIMESTAMP('2023-03-13 11:55:29', 'YYYY-MM-DD HH24:MI:SS'), 'Deposit at Branch','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(112, '00', 4, 200, TO_TIMESTAMP('2023-03-13 15:51:13', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(112, '00', 2, 300, TO_TIMESTAMP('2023-03-13 17:32:46', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(112, '00', 4, 150, TO_TIMESTAMP('2023-03-13 17:45:54', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(112, '51', 2, 56444, TO_TIMESTAMP('2023-03-13 20:01:23', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(112, '14', 2, 1000, TO_TIMESTAMP('2023-03-13 21:34:21', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
-- Day 6
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(112, '00', 1, 900, TO_TIMESTAMP('2023-03-14 03:35:31', 'YYYY-MM-DD HH24:MI:SS'), 'Deposit at Branch','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(112, '00', 4, 200, TO_TIMESTAMP('2023-03-14 09:59:21', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(112, '00', 2, 400, TO_TIMESTAMP('2023-03-14 20:34:21', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(112, '00', 4, 300, TO_TIMESTAMP('2023-03-14 21:55:39', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(112, '51', 2, 50000, TO_TIMESTAMP('2023-03-14 22:23:16', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(112, '06', 3, 250, TO_TIMESTAMP('2023-03-14 22:34:11', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Failed');
-- Previous Day
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(112, '00', 1, 650, current_time - INTERVAL '1' DAY - INTERVAL '18' HOUR - INTERVAL '37' MINUTE - INTERVAL '37' SECOND, 'Refund', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(112, '00', 4, 200, current_time - INTERVAL '1' DAY - INTERVAL '8' HOUR - INTERVAL '10' MINUTE - INTERVAL '9' SECOND, 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(112, '00', 2, 300, current_time - INTERVAL '1' DAY - INTERVAL '7' HOUR - INTERVAL '54' MINUTE - INTERVAL '35' SECOND, 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(112, '00', 4, 150, current_time - INTERVAL '1' DAY - INTERVAL '3' HOUR - INTERVAL '29' MINUTE - INTERVAL '15' SECOND, 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(112, '51', 2, 56000, current_time - INTERVAL '1' DAY - INTERVAL '2' HOUR - INTERVAL '5' MINUTE - INTERVAL '39' SECOND, 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(112, '14', 2, 3000, current_time - INTERVAL '7' DAY - INTERVAL '3' HOUR - INTERVAL '36' MINUTE - INTERVAL '6' SECOND, 'Withdrawal from ATM','Failed');

-- Last hour transactions
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(112, '00', 3, 2000, current_time - INTERVAL '23' MINUTE - INTERVAL '58' SECOND, 'Transfer Made', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(112, '00', 4, 1200, current_time - INTERVAL '22' MINUTE - INTERVAL '57' SECOND, 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(112, '00', 2, 600, current_time - INTERVAL '20' MINUTE - INTERVAL '56' SECOND, 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(112, '00', 4, 200, current_time - INTERVAL '15' MINUTE - INTERVAL '49' SECOND, 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(112, '51', 2, 50000, current_time - INTERVAL '14' MINUTE - INTERVAL '26' SECOND, 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(112, '14', 2, 2000, current_time - INTERVAL '13' MINUTE - INTERVAL '38' SECOND, 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(112, '00', 1, 4000, current_time - INTERVAL '9' MINUTE - INTERVAL '16' SECOND, 'Deposit at Branch','Completed');
    
-- Account 13
-- Initial balance: 0
-- Final balance: 12000
-- Day 1
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(113, '00', 1, 12800, TO_TIMESTAMP('2023-03-09 08:23:42', 'YYYY-MM-DD HH24:MI:SS'), 'Deposit at Branch','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(113, '00', 2, 1000, TO_TIMESTAMP('2023-03-09 15:50:47', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(113, '00', 4, 250, TO_TIMESTAMP('2023-03-09 17:56:56', 'YYYY-MM-DD HH24:MI:SS'), 'Online Shopping','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(113, '00', 3, 500, TO_TIMESTAMP('2023-03-09 18:34:59', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(113, '14', 2, 7000, TO_TIMESTAMP('2023-03-09 18:39:43', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(113, '51', 2, 20000, TO_TIMESTAMP('2023-03-09 19:35:00', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
-- Day 2
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(113, '00', 2, 500, TO_TIMESTAMP('2023-03-10 12:57:30', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(113, '00', 4, 500, TO_TIMESTAMP('2023-03-10 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Online Subscription','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(113, '54', 4, 200, TO_TIMESTAMP('2023-03-10 13:21:54', 'YYYY-MM-DD HH24:MI:SS'), 'Expired Card', 'Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(113, '00', 1, 750, TO_TIMESTAMP('2023-03-10 13:33:21', 'YYYY-MM-DD HH24:MI:SS'), 'Refund from Online Shopping','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(113, '00', 3, 1500, TO_TIMESTAMP('2023-03-10 14:37:29', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer from account_id 101','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(113, '06', 3, 7000, TO_TIMESTAMP('2023-03-10 19:55:33', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Failed');
-- Day 3
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(113, '00', 1, 2500, TO_TIMESTAMP('2023-03-11 01:24:20', 'YYYY-MM-DD HH24:MI:SS'), 'Salary Deposit','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(113, '00', 4, 200, TO_TIMESTAMP('2023-03-11 12:02:56', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(113, '00', 2, 800, TO_TIMESTAMP('2023-03-11 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(113, '00', 4, 300, TO_TIMESTAMP('2023-03-11 13:29:00', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(113, '51', 2, 20000, TO_TIMESTAMP('2023-03-11 13:54:00', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(113, '14', 2, 2000, TO_TIMESTAMP('2023-03-11 21:25:09', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(113, '00', 3, 1500, TO_TIMESTAMP('2023-03-11 23:19:29', 'YYYY-MM-DD HH24:MI:SS'), 'Outward Transfer','Completed');
-- Day 4, 5, 6, and 7
-- Add similar transactions to the above pattern for the remaining days.
-- Day 4
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(113, '00', 1, 650, TO_TIMESTAMP('2023-03-12 14:08:12', 'YYYY-MM-DD HH24:MI:SS'), 'Refund', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(113, '00', 4, 200, TO_TIMESTAMP('2023-03-12 14:15:00', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(113, '00', 2, 300, TO_TIMESTAMP('2023-03-12 15:09:40', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(113, '00', 4, 150, TO_TIMESTAMP('2023-03-12 20:09:00', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(113, '51', 2, 14800, TO_TIMESTAMP('2023-03-12 20:16:00', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(113, '06', 3, 5000, TO_TIMESTAMP('2023-03-12 21:40:00', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Failed');
-- Day 5
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(113, '00', 1, 650, TO_TIMESTAMP('2023-03-13 05:03:50', 'YYYY-MM-DD HH24:MI:SS'), 'Deposit at Branch','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(113, '00', 4, 200, TO_TIMESTAMP('2023-03-13 13:45:51', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(113, '00', 2, 300, TO_TIMESTAMP('2023-03-13 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(113, '00', 4, 150, TO_TIMESTAMP('2023-03-13 14:54:00', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(113, '51', 2, 12270, TO_TIMESTAMP('2023-03-13 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(113, '14', 2, 1000, TO_TIMESTAMP('2023-03-13 19:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
-- Day 6
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(113, '00', 1, 650, TO_TIMESTAMP('2023-03-14 04:26:00', 'YYYY-MM-DD HH24:MI:SS'), 'Deposit at Branch','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(113, '00', 4, 200, TO_TIMESTAMP('2023-03-14 11:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(113, '00', 2, 300, TO_TIMESTAMP('2023-03-14 13:17:00', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(113, '00', 4, 150, TO_TIMESTAMP('2023-03-14 19:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(113, '51', 2, 13275, TO_TIMESTAMP('2023-03-14 19:25:00', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(113, '06', 3, 250, TO_TIMESTAMP('2023-03-14 21:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Failed');
-- Previous Day
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(113, '00', 1, 650, current_time - INTERVAL '1' DAY - INTERVAL '6' HOUR - INTERVAL '15' MINUTE, 'Refund', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(113, '00', 4, 200, current_time - INTERVAL '1' DAY - INTERVAL '6' HOUR - INTERVAL '14' MINUTE, 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(113, '00', 2, 300, current_time - INTERVAL '1' DAY - INTERVAL '4' HOUR - INTERVAL '10' MINUTE, 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(113, '00', 4, 150, current_time - INTERVAL '1' DAY - INTERVAL '3' HOUR, 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(113, '51', 2, 14000, current_time - INTERVAL '1' DAY - INTERVAL '2' HOUR - INTERVAL '26' MINUTE, 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(113, '14', 2, 3000, current_time - INTERVAL '7' DAY - INTERVAL '1' HOUR - INTERVAL '58' MINUTE, 'Withdrawal from ATM','Failed');

-- Last hour transactions
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(113, '00', 3, 700, current_time - INTERVAL '21' MINUTE - INTERVAL '10' SECOND, 'Transfer Made', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(113, '00', 4, 200, current_time - INTERVAL '20' MINUTE - INTERVAL '46' SECOND, 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(113, '00', 2, 300, current_time - INTERVAL '20' MINUTE - INTERVAL '10' SECOND, 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(113, '00', 4, 100, current_time - INTERVAL '18' MINUTE - INTERVAL '1' SECOND, 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(113, '51', 2, 18750, current_time - INTERVAL '10' MINUTE - INTERVAL '39' SECOND, 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(113, '00', 1, 1300, current_time - INTERVAL '4' MINUTE - INTERVAL '18' SECOND, 'Deposit at Branch','Completed');
    
-- Account 14
-- Initial balance: 0
-- Final balance: 6000
-- Day 1
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(114, '00', 1, 13000, TO_TIMESTAMP('2023-03-09 03:29:42', 'YYYY-MM-DD HH24:MI:SS'), 'Deposit at Branch','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(114, '00', 2, 3000, TO_TIMESTAMP('2023-03-09 04:59:47', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(114, '00', 4, 250, TO_TIMESTAMP('2023-03-09 07:59:16', 'YYYY-MM-DD HH24:MI:SS'), 'Online Shopping','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(114, '00', 3, 500, TO_TIMESTAMP('2023-03-09 10:39:09', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(114, '14', 2, 7000, TO_TIMESTAMP('2023-03-09 11:39:43', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(114, '51', 2, 20000, TO_TIMESTAMP('2023-03-09 14:35:00', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
-- Day 2
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(114, '00', 2, 500, TO_TIMESTAMP('2023-03-10 08:57:30', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(114, '00', 4, 500, TO_TIMESTAMP('2023-03-10 10:10:23', 'YYYY-MM-DD HH24:MI:SS'), 'Online Subscription','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(114, '54', 4, 200, TO_TIMESTAMP('2023-03-10 10:21:54', 'YYYY-MM-DD HH24:MI:SS'), 'Expired Card', 'Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(114, '00', 1, 750, TO_TIMESTAMP('2023-03-10 12:33:21', 'YYYY-MM-DD HH24:MI:SS'), 'Refund from Online Shopping','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(114, '06', 3, 7000, TO_TIMESTAMP('2023-03-10 23:55:33', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Failed');
-- Day 3
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(114, '00', 1, 2500, TO_TIMESTAMP('2023-03-11 08:15:20', 'YYYY-MM-DD HH24:MI:SS'), 'Salary Deposit','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(114, '00', 4, 200, TO_TIMESTAMP('2023-03-11 08:20:56', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(114, '00', 2, 2800, TO_TIMESTAMP('2023-03-11 10:50:20', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(114, '00', 4, 1000, TO_TIMESTAMP('2023-03-11 11:29:39', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(114, '51', 2, 20000, TO_TIMESTAMP('2023-03-11 12:45:21', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(114, '14', 2, 2000, TO_TIMESTAMP('2023-03-11 14:39:29', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(114, '00', 3, 1500, TO_TIMESTAMP('2023-03-11 19:49:19', 'YYYY-MM-DD HH24:MI:SS'), 'Outward Transfer','Completed');
-- Day 4, 5, 6, and 7
-- Add similar transactions to the above pattern for the remaining days.
-- Day 4
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(114, '00', 1, 800, TO_TIMESTAMP('2023-03-12 03:31:22', 'YYYY-MM-DD HH24:MI:SS'), 'Refund', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(114, '00', 4, 200, TO_TIMESTAMP('2023-03-12 13:15:25', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(114, '00', 2, 300, TO_TIMESTAMP('2023-03-12 13:29:40', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(114, '00', 4, 300, TO_TIMESTAMP('2023-03-12 21:34:49', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(114, '51', 2, 14800, TO_TIMESTAMP('2023-03-12 22:16:32', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(114, '06', 3, 5000, TO_TIMESTAMP('2023-03-12 23:40:56', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Failed');
-- Day 5
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(114, '00', 1, 650, TO_TIMESTAMP('2023-03-13 05:55:29', 'YYYY-MM-DD HH24:MI:SS'), 'Deposit at Branch','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(114, '00', 4, 200, TO_TIMESTAMP('2023-03-13 08:51:02', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(114, '00', 2, 300, TO_TIMESTAMP('2023-03-13 10:23:45', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(114, '00', 4, 150, TO_TIMESTAMP('2023-03-13 17:54:43', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(114, '51', 2, 12270, TO_TIMESTAMP('2023-03-13 17:59:09', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(114, '14', 2, 1000, TO_TIMESTAMP('2023-03-13 21:41:25', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
-- Day 6
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(114, '00', 1, 800, TO_TIMESTAMP('2023-03-14 04:26:28', 'YYYY-MM-DD HH24:MI:SS'), 'Deposit at Branch','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(114, '00', 4, 200, TO_TIMESTAMP('2023-03-14 10:30:44', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(114, '00', 2, 300, TO_TIMESTAMP('2023-03-14 13:19:32', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(114, '00', 4, 300, TO_TIMESTAMP('2023-03-14 14:55:34', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(114, '51', 2, 13275, TO_TIMESTAMP('2023-03-14 19:25:32', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(114, '06', 3, 250, TO_TIMESTAMP('2023-03-14 21:29:11', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Failed');
-- Previous Day
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(114, '00', 1, 650, current_time - INTERVAL '1' DAY - INTERVAL '22' HOUR - INTERVAL '14' MINUTE - INTERVAL '10' SECOND, 'Refund', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(114, '00', 4, 200, current_time - INTERVAL '1' DAY - INTERVAL '16' HOUR - INTERVAL '13' MINUTE - INTERVAL '39' SECOND, 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(114, '00', 2, 300, current_time - INTERVAL '1' DAY - INTERVAL '12' HOUR - INTERVAL '48' MINUTE - INTERVAL '26' SECOND, 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(114, '00', 4, 150, current_time - INTERVAL '1' DAY - INTERVAL '8' HOUR - INTERVAL '14' MINUTE - INTERVAL '28' SECOND, 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(114, '51', 2, 14000, current_time - INTERVAL '1' DAY - INTERVAL '6' HOUR - INTERVAL '26' MINUTE - INTERVAL '49' SECOND, 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(114, '14', 2, 3000, current_time - INTERVAL '7' DAY - INTERVAL '3' HOUR - INTERVAL '57' MINUTE - INTERVAL '36' SECOND, 'Withdrawal from ATM','Failed');

-- Last hour transactions
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(114, '00', 1, 1900, current_time - INTERVAL '24' MINUTE - INTERVAL '39' SECOND, 'Deposit at Branch','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(114, '00', 3, 1000, current_time - INTERVAL '23' MINUTE - INTERVAL '39' SECOND, 'Transfer Made', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(114, '00', 4, 400, current_time - INTERVAL '23' MINUTE - INTERVAL '35' SECOND, 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(114, '00', 2, 300, current_time - INTERVAL '20' MINUTE - INTERVAL '38' SECOND, 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(114, '00', 4, 200, current_time - INTERVAL '18' MINUTE - INTERVAL '31' SECOND, 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(114, '51', 2, 12000, current_time - INTERVAL '16' MINUTE - INTERVAL '39' SECOND, 'Withdrawal from ATM','Failed');
    
-- Account 15
-- Initial balance: 0
-- Final balance: -200 (Overdraft)
-- Day 1
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(115, '00', 1, 5800, TO_TIMESTAMP('2023-03-09 01:39:52', 'YYYY-MM-DD HH24:MI:SS'), 'Deposit at Branch','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(115, '00', 2, 2000, TO_TIMESTAMP('2023-03-09 10:39:47', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(115, '00', 4, 250, TO_TIMESTAMP('2023-03-09 11:29:16', 'YYYY-MM-DD HH24:MI:SS'), 'Online Shopping','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(115, '00', 3, 500, TO_TIMESTAMP('2023-03-09 11:39:59', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(115, '14', 2, 7000, TO_TIMESTAMP('2023-03-09 12:40:47', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(115, '51', 2, 8000, TO_TIMESTAMP('2023-03-09 14:35:21', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
-- Day 2
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(115, '00', 2, 500, TO_TIMESTAMP('2023-03-10 14:57:39', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(115, '00', 4, 500, TO_TIMESTAMP('2023-03-10 15:10:53', 'YYYY-MM-DD HH24:MI:SS'), 'Online Subscription','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(115, '54', 4, 200, TO_TIMESTAMP('2023-03-10 16:54:25', 'YYYY-MM-DD HH24:MI:SS'), 'Expired Card', 'Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(115, '00', 1, 750, TO_TIMESTAMP('2023-03-10 16:59:31', 'YYYY-MM-DD HH24:MI:SS'), 'Refund from Online Shopping','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(115, '06', 3, 7000, TO_TIMESTAMP('2023-03-10 19:12:35', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Failed');
-- Day 3
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(115, '00', 1, 2500, TO_TIMESTAMP('2023-03-11 01:25:09', 'YYYY-MM-DD HH24:MI:SS'), 'Salary Deposit','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(115, '00', 4, 200, TO_TIMESTAMP('2023-03-11 07:09:12', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(115, '00', 2, 2800, TO_TIMESTAMP('2023-03-11 10:15:27', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(115, '00', 4, 1000, TO_TIMESTAMP('2023-03-11 11:49:32', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(115, '51', 2, 8000, TO_TIMESTAMP('2023-03-11 12:41:29', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(115, '14', 2, 2000, TO_TIMESTAMP('2023-03-11 13:55:21', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(115, '00', 3, 1500, TO_TIMESTAMP('2023-03-11 21:23:45', 'YYYY-MM-DD HH24:MI:SS'), 'Outward Transfer','Completed');
-- Day 4, 5, 6, and 7
-- Add similar transactions to the above pattern for the remaining days.
-- Day 4
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(115, '00', 1, 900, TO_TIMESTAMP('2023-03-12 05:52:23', 'YYYY-MM-DD HH24:MI:SS'), 'Refund', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(115, '00', 4, 200, TO_TIMESTAMP('2023-03-12 09:34:21', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(115, '00', 2, 400, TO_TIMESTAMP('2023-03-12 10:29:23', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(115, '00', 4, 300, TO_TIMESTAMP('2023-03-12 19:51:09', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(115, '51', 2, 5000, TO_TIMESTAMP('2023-03-12 22:45:32', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(115, '06', 3, 5000, TO_TIMESTAMP('2023-03-12 23:45:56', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Failed');
-- Day 5
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(115, '00', 1, 650, TO_TIMESTAMP('2023-03-13 09:55:29', 'YYYY-MM-DD HH24:MI:SS'), 'Deposit at Branch','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(115, '00', 4, 200, TO_TIMESTAMP('2023-03-13 11:51:13', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(115, '00', 2, 300, TO_TIMESTAMP('2023-03-13 13:32:46', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(115, '00', 4, 150, TO_TIMESTAMP('2023-03-13 17:45:54', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(115, '51', 2, 3000, TO_TIMESTAMP('2023-03-13 23:01:23', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(115, '14', 2, 1000, TO_TIMESTAMP('2023-03-13 23:34:21', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
-- Day 6
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(115, '00', 1, 900, TO_TIMESTAMP('2023-03-14 13:35:31', 'YYYY-MM-DD HH24:MI:SS'), 'Deposit at Branch','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(115, '00', 4, 200, TO_TIMESTAMP('2023-03-14 13:59:21', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(115, '00', 2, 400, TO_TIMESTAMP('2023-03-14 15:34:21', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(115, '00', 4, 300, TO_TIMESTAMP('2023-03-14 15:55:39', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(115, '51', 2, 4000, TO_TIMESTAMP('2023-03-14 20:23:16', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(115, '06', 3, 250, TO_TIMESTAMP('2023-03-14 21:34:11', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Failed');
-- Previous Day
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(115, '00', 1, 650, current_time - INTERVAL '1' DAY - INTERVAL '22' HOUR - INTERVAL '37' MINUTE - INTERVAL '37' SECOND, 'Refund', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(115, '00', 4, 200, current_time - INTERVAL '1' DAY - INTERVAL '16' HOUR - INTERVAL '10' MINUTE - INTERVAL '9' SECOND, 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(115, '00', 2, 300, current_time - INTERVAL '1' DAY - INTERVAL '11' HOUR - INTERVAL '54' MINUTE - INTERVAL '35' SECOND, 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(115, '00', 4, 150, current_time - INTERVAL '1' DAY - INTERVAL '8' HOUR - INTERVAL '29' MINUTE - INTERVAL '15' SECOND, 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(115, '51', 2, 4000, current_time - INTERVAL '1' DAY - INTERVAL '6' HOUR - INTERVAL '5' MINUTE - INTERVAL '39' SECOND, 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(115, '14', 2, 3000, current_time - INTERVAL '7' DAY - INTERVAL '3' HOUR - INTERVAL '36' MINUTE - INTERVAL '6' SECOND, 'Withdrawal from ATM','Failed');

-- Last hour transactions
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(115, '00', 1, 2000, current_time - INTERVAL '25' MINUTE, 'Deposit at Branch','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(115, '00', 3, 1100, current_time - INTERVAL '22' MINUTE, 'Transfer Made', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(115, '00', 4, 200, current_time - INTERVAL '21' MINUTE - INTERVAL '48' SECOND, 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(115, '00', 2, 400, current_time - INTERVAL '19' MINUTE - INTERVAL '1' SECOND, 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(115, '00', 4, 300, current_time - INTERVAL '17' MINUTE - INTERVAL '40' SECOND, 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(115, '51', 2, 4000, current_time - INTERVAL '16' MINUTE - INTERVAL '36' SECOND, 'Withdrawal from ATM','Failed');
    
-- Account 16
-- Initial balance: 0
-- Final balance: -500 (Overdraft)
-- Day 1
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(116, '00', 1, 5500, TO_TIMESTAMP('2023-03-09 01:39:52', 'YYYY-MM-DD HH24:MI:SS'), 'Deposit at Branch','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(116, '00', 2, 2000, TO_TIMESTAMP('2023-03-09 10:39:47', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(116, '00', 4, 250, TO_TIMESTAMP('2023-03-09 11:29:16', 'YYYY-MM-DD HH24:MI:SS'), 'Online Shopping','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(116, '00', 3, 500, TO_TIMESTAMP('2023-03-09 11:39:59', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(116, '14', 2, 7000, TO_TIMESTAMP('2023-03-09 12:40:47', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(116, '51', 2, 8000, TO_TIMESTAMP('2023-03-09 14:35:21', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
-- Day 2
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(116, '00', 2, 500, TO_TIMESTAMP('2023-03-10 14:57:39', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(116, '00', 4, 500, TO_TIMESTAMP('2023-03-10 15:10:53', 'YYYY-MM-DD HH24:MI:SS'), 'Online Subscription','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(116, '54', 4, 200, TO_TIMESTAMP('2023-03-10 16:54:25', 'YYYY-MM-DD HH24:MI:SS'), 'Expired Card', 'Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(116, '00', 1, 750, TO_TIMESTAMP('2023-03-10 16:59:31', 'YYYY-MM-DD HH24:MI:SS'), 'Refund from Online Shopping','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(116, '06', 3, 7000, TO_TIMESTAMP('2023-03-10 19:12:35', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Failed');
-- Day 3
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(116, '00', 1, 2500, TO_TIMESTAMP('2023-03-11 01:25:09', 'YYYY-MM-DD HH24:MI:SS'), 'Salary Deposit','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(116, '00', 4, 200, TO_TIMESTAMP('2023-03-11 07:09:12', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(116, '00', 2, 2800, TO_TIMESTAMP('2023-03-11 10:15:27', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(116, '00', 4, 1000, TO_TIMESTAMP('2023-03-11 11:49:32', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(116, '51', 2, 8000, TO_TIMESTAMP('2023-03-11 12:41:29', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(116, '14', 2, 2000, TO_TIMESTAMP('2023-03-11 13:55:21', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(116, '00', 3, 1500, TO_TIMESTAMP('2023-03-11 21:23:45', 'YYYY-MM-DD HH24:MI:SS'), 'Outward Transfer','Completed');
-- Day 4, 5, 6, and 7
-- Add similar transactions to the above pattern for the remaining days.
-- Day 4
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(116, '00', 1, 900, TO_TIMESTAMP('2023-03-12 05:52:23', 'YYYY-MM-DD HH24:MI:SS'), 'Refund', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(116, '00', 4, 200, TO_TIMESTAMP('2023-03-12 09:34:21', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(116, '00', 2, 400, TO_TIMESTAMP('2023-03-12 10:29:23', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(116, '00', 4, 300, TO_TIMESTAMP('2023-03-12 19:51:09', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(116, '51', 2, 5000, TO_TIMESTAMP('2023-03-12 22:45:32', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(116, '06', 3, 5000, TO_TIMESTAMP('2023-03-12 23:45:56', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Failed');
-- Day 5
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(116, '00', 1, 650, TO_TIMESTAMP('2023-03-13 09:55:29', 'YYYY-MM-DD HH24:MI:SS'), 'Deposit at Branch','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(116, '00', 4, 200, TO_TIMESTAMP('2023-03-13 11:51:13', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(116, '00', 2, 300, TO_TIMESTAMP('2023-03-13 13:32:46', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(116, '00', 4, 150, TO_TIMESTAMP('2023-03-13 17:45:54', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(116, '51', 2, 3000, TO_TIMESTAMP('2023-03-13 23:01:23', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(116, '14', 2, 1000, TO_TIMESTAMP('2023-03-13 23:34:21', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
-- Day 6
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(116, '00', 1, 900, TO_TIMESTAMP('2023-03-14 13:35:31', 'YYYY-MM-DD HH24:MI:SS'), 'Deposit at Branch','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(116, '00', 4, 200, TO_TIMESTAMP('2023-03-14 13:59:21', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(116, '00', 2, 400, TO_TIMESTAMP('2023-03-14 15:34:21', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(116, '00', 4, 300, TO_TIMESTAMP('2023-03-14 15:55:39', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(116, '51', 2, 4000, TO_TIMESTAMP('2023-03-14 20:23:16', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(116, '06', 3, 250, TO_TIMESTAMP('2023-03-14 21:34:11', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Failed');
-- Previous Day
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(116, '00', 1, 650, current_time - INTERVAL '1' DAY - INTERVAL '22' HOUR - INTERVAL '37' MINUTE - INTERVAL '37' SECOND, 'Refund', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(116, '00', 4, 200, current_time - INTERVAL '1' DAY - INTERVAL '16' HOUR - INTERVAL '10' MINUTE - INTERVAL '9' SECOND, 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(116, '00', 2, 300, current_time - INTERVAL '1' DAY - INTERVAL '11' HOUR - INTERVAL '54' MINUTE - INTERVAL '35' SECOND, 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(116, '00', 4, 150, current_time - INTERVAL '1' DAY - INTERVAL '8' HOUR - INTERVAL '29' MINUTE - INTERVAL '15' SECOND, 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(116, '51', 2, 4000, current_time - INTERVAL '1' DAY - INTERVAL '6' HOUR - INTERVAL '5' MINUTE - INTERVAL '39' SECOND, 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(116, '14', 2, 3000, current_time - INTERVAL '7' DAY - INTERVAL '3' HOUR - INTERVAL '36' MINUTE - INTERVAL '6' SECOND, 'Withdrawal from ATM','Failed');

-- Last hour transactions
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(116, '00', 1, 2000, current_time - INTERVAL '25' MINUTE, 'Deposit at Branch','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(116, '00', 3, 1100, current_time - INTERVAL '22' MINUTE, 'Transfer Made', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(116, '00', 4, 200, current_time - INTERVAL '21' MINUTE - INTERVAL '48' SECOND, 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(116, '00', 2, 400, current_time - INTERVAL '19' MINUTE - INTERVAL '1' SECOND, 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(116, '00', 4, 300, current_time - INTERVAL '17' MINUTE - INTERVAL '40' SECOND, 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(116, '51', 2, 4000, current_time - INTERVAL '16' MINUTE - INTERVAL '36' SECOND, 'Withdrawal from ATM','Failed');

END;
/

-------------------------------------------------------------------------------------------------------------------------------------------
--PACKAGES FOR USERS
-------------------------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE EMPLOYEE_PKG AS
    
    PROCEDURE VIEW_EMPLOYEE_DETAILS(P_EMPLOYEE_ID NUMBER);
    
    PROCEDURE VIEW_CUSTOMERS(P_EMPLOYEE_ID NUMBER);
    
    PROCEDURE VIEW_CUSTOMER_BY_ID(P_EMPLOYEE_ID NUMBER, P_CUSTOMER_ID NUMBER);
    
    PROCEDURE EMP_INSERT_CUSTOMER (
        P_FIRST_NAME CUSTOMER.FIRST_NAME%TYPE,
        P_LAST_NAME CUSTOMER.LAST_NAME%TYPE,
        P_DATE_OF_BIRTH CUSTOMER.DATE_OF_BIRTH%TYPE,
        P_EMAIL_ID CUSTOMER.EMAIL_ID%TYPE,
        P_PHONE_NUMBER CUSTOMER.PHONE_NUMBER%TYPE,
        P_DATE_REGISTERED CUSTOMER.DATE_REGISTERED%TYPE,
        P_ANNUAL_INCOME CUSTOMER.ANNUAL_INCOME%TYPE,
        P_LOGIN CUSTOMER.LOGIN%TYPE,
        P_PASSWORD_HASH CUSTOMER.PASSWORD_HASH%TYPE,
        P_ADDRESS CUSTOMER.ADDRESS%TYPE,
        P_CITY CUSTOMER.CITY%TYPE,
        P_STATE_NAME CUSTOMER.STATE_NAME%TYPE
    );
    
    PROCEDURE UPDATE_CUSTOMER (
        P_EMPLOYEE_ID NUMBER,
        P_CUSTOMER_ID CUSTOMER.CUSTOMER_ID%TYPE,
        P_FIRST_NAME CUSTOMER.FIRST_NAME%TYPE DEFAULT NULL,
        P_LAST_NAME CUSTOMER.LAST_NAME%TYPE DEFAULT NULL,
        P_DATE_OF_BIRTH CUSTOMER.DATE_OF_BIRTH%TYPE DEFAULT NULL,
        P_EMAIL_ID CUSTOMER.EMAIL_ID%TYPE DEFAULT NULL,
        P_PHONE_NUMBER CUSTOMER.PHONE_NUMBER%TYPE DEFAULT NULL,
        P_ANNUAL_INCOME CUSTOMER.ANNUAL_INCOME%TYPE DEFAULT NULL,
        P_ADDRESS CUSTOMER.ADDRESS%TYPE DEFAULT NULL,
        P_CITY CUSTOMER.CITY%TYPE DEFAULT NULL,
        P_STATE_NAME CUSTOMER.STATE_NAME%TYPE DEFAULT NULL
    );
    
    PROCEDURE VIEW_ACCOUNTS(P_EMPLOYEE_ID NUMBER);
    
    PROCEDURE INSERT_ACCOUNT (
        P_EMPLOYEE_ID NUMBER,
        P_CUSTOMER_ID ACCOUNTS.CUSTOMER_ID%TYPE,
        P_ACCOUNT_TYPE ACCOUNTS.ACCOUNT_TYPE%TYPE,
        P_CREATED_DATE ACCOUNTS.CREATED_DATE%TYPE,
        P_BALANCE ACCOUNTS.BALANCE%TYPE,
        P_CARD_DETAILS ACCOUNTS.CARD_DETAILS%TYPE,
        P_PROOF ACCOUNTS.PROOF%TYPE
    );
    
    PROCEDURE UPDATE_ACCOUNT (
        P_EMPLOYEE_ID NUMBER,
        P_ACCOUNT_ID ACCOUNTS.ACCOUNT_ID%TYPE,
        P_ACCOUNT_TYPE ACCOUNTS.ACCOUNT_TYPE%TYPE DEFAULT NULL,
        P_BALANCE ACCOUNTS.BALANCE%TYPE DEFAULT NULL,
        P_CARD_DETAILS ACCOUNTS.CARD_DETAILS%TYPE DEFAULT NULL,
        P_PROOF ACCOUNTS.PROOF%TYPE DEFAULT NULL
    );
    
    PROCEDURE VIEW_TRANSACTIONS (P_EMPLOYEE_ID NUMBER);
    
    PROCEDURE INSERT_TRANSACTION (
        P_EMPLOYEE_ID NUMBER,
        P_ACCOUNT_ID TRANSACTION_TABLE.ACCOUNT_ID%TYPE,
        P_STATUS_CODE TRANSACTION_TABLE.STATUS_CODE%TYPE,
        P_TRANSACTION_TYPE TRANSACTION_TABLE.TRANSACTION_TYPE%TYPE,
        P_AMOUNT TRANSACTION_TABLE.AMOUNT%TYPE,
        P_TIME_STAMP TRANSACTION_TABLE.TIME_STAMP%TYPE,
        P_TRANSACTION_DETAILS TRANSACTION_TABLE.TRANSACTION_DETAILS%TYPE,
        P_STATUS TRANSACTION_TABLE.STATUS%TYPE
    );
    
    PROCEDURE VIEW_LOANS (
        P_EMPLOYEE_ID NUMBER
    );
    
    PROCEDURE ADD_LOAN (
        P_EMPLOYEE_ID NUMBER,
        P_CUSTOMER_ID LOAN.CUSTOMER_ID%TYPE,
        P_LOAN_TYPE LOAN.LOAN_TYPE%TYPE,
        P_AMOUNT LOAN.AMOUNT%TYPE,
        P_INTEREST_RATE LOAN.INTEREST_RATE%TYPE,
        P_TERM_IN_MONTHS LOAN.TERM_IN_MONTHS%TYPE,
        P_COMMENCEMENT_DATE LOAN.COMMENCEMENT_DATE%TYPE
    );
    
    PROCEDURE DELETE_CUSTOMER_ACCOUNT (
        p_account_id ACCOUNTS.ACCOUNT_ID%TYPE,
        p_employee_id EMPLOYEE.EMPLOYEE_ID%TYPE
    );
    
END EMPLOYEE_PKG;
/

CREATE OR REPLACE PACKAGE BODY EMPLOYEE_PKG AS
    --VIEW EMPLOYEE DETAILS
    PROCEDURE VIEW_EMPLOYEE_DETAILS (P_EMPLOYEE_ID NUMBER) IS
        V_EMPLOYEE EMPLOYEE%ROWTYPE;
    BEGIN
        SELECT * INTO V_EMPLOYEE FROM EMPLOYEE WHERE EMPLOYEE_ID = P_EMPLOYEE_ID;
        
        DBMS_OUTPUT.PUT_LINE('Employee ID: ' || V_EMPLOYEE.EMPLOYEE_ID);
        DBMS_OUTPUT.PUT_LINE('First Name: ' || V_EMPLOYEE.FIRST_NAME);
        DBMS_OUTPUT.PUT_LINE('Last Name: ' || V_EMPLOYEE.LAST_NAME);
        DBMS_OUTPUT.PUT_LINE('Date of Birth: ' || V_EMPLOYEE.DATE_OF_BIRTH);
        DBMS_OUTPUT.PUT_LINE('Email ID: ' || V_EMPLOYEE.EMAIL_ID);
        DBMS_OUTPUT.PUT_LINE('Phone Number: ' || V_EMPLOYEE.PHONE_NUMBER);
        DBMS_OUTPUT.PUT_LINE('Date Registered: ' || V_EMPLOYEE.DATE_REGISTERED);
        DBMS_OUTPUT.PUT_LINE('Address: ' || V_EMPLOYEE.ADDRESS);
        DBMS_OUTPUT.PUT_LINE('City: ' || V_EMPLOYEE.CITY);
        DBMS_OUTPUT.PUT_LINE('State Name: ' || V_EMPLOYEE.STATE_NAME);
        DBMS_OUTPUT.PUT_LINE('Branch ID: ' || V_EMPLOYEE.BRANCH_ID);
        DBMS_OUTPUT.PUT_LINE('Role ID: ' || V_EMPLOYEE.ROLE_ID);
        DBMS_OUTPUT.PUT_LINE('Manager ID: ' || V_EMPLOYEE.MANAGER_ID);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('No employee found with ID: ' || P_EMPLOYEE_ID);
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    END VIEW_EMPLOYEE_DETAILS;
    
    PROCEDURE VIEW_CUSTOMERS(P_EMPLOYEE_ID NUMBER) IS
        CURSOR CUSTOMERS_CURSOR IS
            SELECT C.*, A.ACCOUNT_ID
            FROM CUSTOMER C
            JOIN ACCOUNTS A ON C.CUSTOMER_ID = A.CUSTOMER_ID
            JOIN EMPLOYEE E ON A.BRANCH_ID = E.BRANCH_ID
            WHERE E.EMPLOYEE_ID = P_EMPLOYEE_ID;

        CUSTOMER_REC CUSTOMERS_CURSOR%ROWTYPE;
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Customer Details:');
        DBMS_OUTPUT.PUT_LINE('--------------------------------------------------------------------------------');
        OPEN CUSTOMERS_CURSOR;
        LOOP
            FETCH CUSTOMERS_CURSOR INTO CUSTOMER_REC;
            EXIT WHEN CUSTOMERS_CURSOR%NOTFOUND;

            DBMS_OUTPUT.PUT_LINE('Customer ID: ' || CUSTOMER_REC.CUSTOMER_ID || ', First Name: ' || CUSTOMER_REC.FIRST_NAME || ', Last Name: ' || CUSTOMER_REC.LAST_NAME || ', Email: ' || CUSTOMER_REC.EMAIL_ID || ', Phone Number: ' || CUSTOMER_REC.PHONE_NUMBER || ', Account ID: ' || CUSTOMER_REC.ACCOUNT_ID);
        END LOOP;
        CLOSE CUSTOMERS_CURSOR;
    END VIEW_CUSTOMERS;

    PROCEDURE VIEW_CUSTOMER_BY_ID(P_EMPLOYEE_ID NUMBER, P_CUSTOMER_ID NUMBER) IS
        CURSOR ACCOUNTS_CURSOR IS
            SELECT C.CUSTOMER_ID, C.FIRST_NAME, C.LAST_NAME, C.EMAIL_ID, C.PHONE_NUMBER, A.ACCOUNT_ID
            FROM CUSTOMER C
            JOIN ACCOUNTS A ON C.CUSTOMER_ID = A.CUSTOMER_ID
            JOIN EMPLOYEE E ON A.BRANCH_ID = E.BRANCH_ID
            WHERE E.EMPLOYEE_ID = P_EMPLOYEE_ID AND C.CUSTOMER_ID = P_CUSTOMER_ID;

        ACCOUNT_REC ACCOUNTS_CURSOR%ROWTYPE;
        ROW_FOUND BOOLEAN := FALSE;
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Customer Details:');
        DBMS_OUTPUT.PUT_LINE('--------------------------------------------------------------------------------');
        OPEN ACCOUNTS_CURSOR;
        LOOP
            FETCH ACCOUNTS_CURSOR INTO ACCOUNT_REC;
            EXIT WHEN ACCOUNTS_CURSOR%NOTFOUND;

            DBMS_OUTPUT.PUT_LINE('Customer ID: ' || ACCOUNT_REC.CUSTOMER_ID || ', First Name: ' || ACCOUNT_REC.FIRST_NAME || ', Last Name: ' || ACCOUNT_REC.LAST_NAME || ', Email: ' || ACCOUNT_REC.EMAIL_ID || ', Phone Number: ' || ACCOUNT_REC.PHONE_NUMBER || ', Account ID: ' || ACCOUNT_REC.ACCOUNT_ID);
            ROW_FOUND := TRUE;
        END LOOP;
        CLOSE ACCOUNTS_CURSOR;

        IF NOT ROW_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('No customer found with the provided ID and employee branch.');
        END IF;
    END VIEW_CUSTOMER_BY_ID;
    
    PROCEDURE EMP_INSERT_CUSTOMER (
        P_FIRST_NAME CUSTOMER.FIRST_NAME%TYPE,
        P_LAST_NAME CUSTOMER.LAST_NAME%TYPE,
        P_DATE_OF_BIRTH CUSTOMER.DATE_OF_BIRTH%TYPE,
        P_EMAIL_ID CUSTOMER.EMAIL_ID%TYPE,
        P_PHONE_NUMBER CUSTOMER.PHONE_NUMBER%TYPE,
        P_DATE_REGISTERED CUSTOMER.DATE_REGISTERED%TYPE,
        P_ANNUAL_INCOME CUSTOMER.ANNUAL_INCOME%TYPE,
        P_LOGIN CUSTOMER.LOGIN%TYPE,
        P_PASSWORD_HASH CUSTOMER.PASSWORD_HASH%TYPE,
        P_ADDRESS CUSTOMER.ADDRESS%TYPE,
        P_CITY CUSTOMER.CITY%TYPE,
        P_STATE_NAME CUSTOMER.STATE_NAME%TYPE
    ) IS
        V_CUSTOMER_COUNT NUMBER;
    BEGIN
        SELECT COUNT(*) INTO V_CUSTOMER_COUNT FROM CUSTOMER WHERE EMAIL_ID = P_EMAIL_ID OR PHONE_NUMBER = P_PHONE_NUMBER OR LOGIN = P_LOGIN;

        IF V_CUSTOMER_COUNT = 0 THEN
            INSERT INTO CUSTOMER (
                FIRST_NAME,
                LAST_NAME,
                DATE_OF_BIRTH,
                EMAIL_ID,
                PHONE_NUMBER,
                DATE_REGISTERED,
                ANNUAL_INCOME,
                LOGIN,
                PASSWORD_HASH,
                ADDRESS,
                CITY,
                STATE_NAME
            ) VALUES (
                P_FIRST_NAME,
                P_LAST_NAME,
                P_DATE_OF_BIRTH,
                P_EMAIL_ID,
                P_PHONE_NUMBER,
                P_DATE_REGISTERED,
                P_ANNUAL_INCOME,
                P_LOGIN,
                P_PASSWORD_HASH,
                P_ADDRESS,
                P_CITY,
                P_STATE_NAME
            );

            DBMS_OUTPUT.PUT_LINE('Customer record inserted successfully.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Customer with the provided email or phone number or login already exists.');
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    END EMP_INSERT_CUSTOMER;
    
    PROCEDURE UPDATE_CUSTOMER (
        P_EMPLOYEE_ID NUMBER,
        P_CUSTOMER_ID CUSTOMER.CUSTOMER_ID%TYPE,
        P_FIRST_NAME CUSTOMER.FIRST_NAME%TYPE DEFAULT NULL,
        P_LAST_NAME CUSTOMER.LAST_NAME%TYPE DEFAULT NULL,
        P_DATE_OF_BIRTH CUSTOMER.DATE_OF_BIRTH%TYPE DEFAULT NULL,
        P_EMAIL_ID CUSTOMER.EMAIL_ID%TYPE DEFAULT NULL,
        P_PHONE_NUMBER CUSTOMER.PHONE_NUMBER%TYPE DEFAULT NULL,
        P_ANNUAL_INCOME CUSTOMER.ANNUAL_INCOME%TYPE DEFAULT NULL,
        P_ADDRESS CUSTOMER.ADDRESS%TYPE DEFAULT NULL,
        P_CITY CUSTOMER.CITY%TYPE DEFAULT NULL,
        P_STATE_NAME CUSTOMER.STATE_NAME%TYPE DEFAULT NULL
    ) AS
        V_BRANCH_ID BRANCH.BRANCH_ID%TYPE;
    BEGIN
        SELECT BRANCH_ID INTO V_BRANCH_ID FROM EMPLOYEE WHERE EMPLOYEE_ID = P_EMPLOYEE_ID;

        UPDATE CUSTOMER
        SET FIRST_NAME = COALESCE(P_FIRST_NAME, FIRST_NAME),
            LAST_NAME = COALESCE(P_LAST_NAME, LAST_NAME),
            DATE_OF_BIRTH = COALESCE(P_DATE_OF_BIRTH, DATE_OF_BIRTH),
            EMAIL_ID = COALESCE(P_EMAIL_ID, EMAIL_ID),
            PHONE_NUMBER = COALESCE(P_PHONE_NUMBER, PHONE_NUMBER),
            ANNUAL_INCOME = COALESCE(P_ANNUAL_INCOME, ANNUAL_INCOME),
            ADDRESS = COALESCE(P_ADDRESS, ADDRESS),
            CITY = COALESCE(P_CITY, CITY),
            STATE_NAME = COALESCE(P_STATE_NAME, STATE_NAME)
        WHERE CUSTOMER_ID = P_CUSTOMER_ID
        AND EXISTS (
            SELECT 1 FROM ACCOUNTS
            WHERE ACCOUNTS.CUSTOMER_ID = P_CUSTOMER_ID
            AND ACCOUNTS.BRANCH_ID = V_BRANCH_ID
        );

        IF SQL%ROWCOUNT > 0 THEN
            DBMS_OUTPUT.PUT_LINE('Customer record updated successfully.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('No customer record found with the given ID in the employee branch.');
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    END UPDATE_CUSTOMER;
    
    PROCEDURE VIEW_ACCOUNTS(P_EMPLOYEE_ID NUMBER) AS
        CURSOR C_ACCOUNTS IS
            SELECT A.*
            FROM ACCOUNTS A
            JOIN BRANCH B ON A.BRANCH_ID = B.BRANCH_ID
            WHERE B.BRANCH_ID = (SELECT BRANCH_ID FROM EMPLOYEE WHERE EMPLOYEE_ID = P_EMPLOYEE_ID);
    BEGIN
        FOR V_ACCOUNT IN C_ACCOUNTS LOOP
            DBMS_OUTPUT.PUT_LINE('Account ID: ' || V_ACCOUNT.ACCOUNT_ID || ', Customer ID: ' || V_ACCOUNT.CUSTOMER_ID || ', Account Type: ' || V_ACCOUNT.ACCOUNT_TYPE || ', Branch ID: ' || V_ACCOUNT.BRANCH_ID || ', Created Date: ' || V_ACCOUNT.CREATED_DATE || ', Balance: ' || V_ACCOUNT.BALANCE || ', Card Details: ' || V_ACCOUNT.CARD_DETAILS || ', Proof: ' || V_ACCOUNT.PROOF);
        END LOOP;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    END VIEW_ACCOUNTS;
    
    PROCEDURE INSERT_ACCOUNT (
        P_EMPLOYEE_ID NUMBER,
        P_CUSTOMER_ID ACCOUNTS.CUSTOMER_ID%TYPE,
        P_ACCOUNT_TYPE ACCOUNTS.ACCOUNT_TYPE%TYPE,
        P_CREATED_DATE ACCOUNTS.CREATED_DATE%TYPE,
        P_BALANCE ACCOUNTS.BALANCE%TYPE,
        P_CARD_DETAILS ACCOUNTS.CARD_DETAILS%TYPE,
        P_PROOF ACCOUNTS.PROOF%TYPE
    ) AS
        V_BRANCH_ID BRANCH.BRANCH_ID%TYPE;
        V_ACCOUNT_COUNT NUMBER;
    BEGIN
        SELECT BRANCH_ID INTO V_BRANCH_ID FROM EMPLOYEE WHERE EMPLOYEE_ID = P_EMPLOYEE_ID;

        SELECT COUNT(*) INTO V_ACCOUNT_COUNT
        FROM ACCOUNTS
        WHERE CUSTOMER_ID = P_CUSTOMER_ID AND ACCOUNT_TYPE = P_ACCOUNT_TYPE AND BRANCH_ID = V_BRANCH_ID;

        IF V_ACCOUNT_COUNT = 0 THEN
            INSERT INTO ACCOUNTS (CUSTOMER_ID, ACCOUNT_TYPE, BRANCH_ID, CREATED_DATE, BALANCE, CARD_DETAILS, PROOF)
            VALUES (P_CUSTOMER_ID, P_ACCOUNT_TYPE, V_BRANCH_ID, P_CREATED_DATE, P_BALANCE, P_CARD_DETAILS, P_PROOF);

            DBMS_OUTPUT.PUT_LINE('Account inserted successfully.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Account already exists.');
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    END INSERT_ACCOUNT;
    
    PROCEDURE UPDATE_ACCOUNT (
        P_EMPLOYEE_ID NUMBER,
        P_ACCOUNT_ID ACCOUNTS.ACCOUNT_ID%TYPE,
        P_ACCOUNT_TYPE ACCOUNTS.ACCOUNT_TYPE%TYPE DEFAULT NULL,
        P_BALANCE ACCOUNTS.BALANCE%TYPE DEFAULT NULL,
        P_CARD_DETAILS ACCOUNTS.CARD_DETAILS%TYPE DEFAULT NULL,
        P_PROOF ACCOUNTS.PROOF%TYPE DEFAULT NULL
    ) AS
        V_BRANCH_ID BRANCH.BRANCH_ID%TYPE;
    BEGIN
        SELECT BRANCH_ID INTO V_BRANCH_ID FROM EMPLOYEE WHERE EMPLOYEE_ID = P_EMPLOYEE_ID;
    
        UPDATE ACCOUNTS
        SET ACCOUNT_TYPE = COALESCE(P_ACCOUNT_TYPE, ACCOUNT_TYPE),
            BALANCE = COALESCE(P_BALANCE, BALANCE),
            CARD_DETAILS = COALESCE(P_CARD_DETAILS, CARD_DETAILS),
            PROOF = COALESCE(P_PROOF, PROOF)
        WHERE ACCOUNT_ID = P_ACCOUNT_ID
        AND BRANCH_ID = V_BRANCH_ID;

        IF SQL%ROWCOUNT = 0 THEN
            DBMS_OUTPUT.PUT_LINE('No account found for the specified account_id and employee_id');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Account updated successfully.');
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    END UPDATE_ACCOUNT;
    
    PROCEDURE VIEW_TRANSACTIONS (P_EMPLOYEE_ID NUMBER) AS
        V_BRANCH_ID BRANCH.BRANCH_ID%TYPE;
        CURSOR TRANSACTIONS_CURSOR IS
            SELECT T.TRANSACTION_ID, T.ACCOUNT_ID, T.STATUS_CODE, T.TRANSACTION_TYPE, T.AMOUNT, T.TIME_STAMP, T.TRANSACTION_DETAILS, T.STATUS
            FROM TRANSACTION_TABLE T
            JOIN ACCOUNTS A ON T.ACCOUNT_ID = A.ACCOUNT_ID
            WHERE A.BRANCH_ID = V_BRANCH_ID
            ORDER BY T.ACCOUNT_ID;
        TRANSACTION_RECORD TRANSACTIONS_CURSOR%ROWTYPE;
    BEGIN
        SELECT BRANCH_ID INTO V_BRANCH_ID FROM EMPLOYEE WHERE EMPLOYEE_ID = P_EMPLOYEE_ID;

        OPEN TRANSACTIONS_CURSOR;
        LOOP
            FETCH TRANSACTIONS_CURSOR INTO TRANSACTION_RECORD;
            EXIT WHEN TRANSACTIONS_CURSOR%NOTFOUND;

            DBMS_OUTPUT.PUT_LINE('Transaction ID: ' || TRANSACTION_RECORD.TRANSACTION_ID || ', Account ID: ' || TRANSACTION_RECORD.ACCOUNT_ID || ', Status Code: ' || TRANSACTION_RECORD.STATUS_CODE ||
                             ', Transaction Type: ' || TRANSACTION_RECORD.TRANSACTION_TYPE || ', Amount: ' || TRANSACTION_RECORD.AMOUNT || ', Time Stamp: ' || TRANSACTION_RECORD.TIME_STAMP ||
                             ', Transaction Details: ' || TRANSACTION_RECORD.TRANSACTION_DETAILS || ', Status: ' || TRANSACTION_RECORD.STATUS);
        END LOOP;
        CLOSE TRANSACTIONS_CURSOR;

    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    END VIEW_TRANSACTIONS;
    
    PROCEDURE INSERT_TRANSACTION (
        P_EMPLOYEE_ID NUMBER,
        P_ACCOUNT_ID TRANSACTION_TABLE.ACCOUNT_ID%TYPE,
        P_STATUS_CODE TRANSACTION_TABLE.STATUS_CODE%TYPE,
        P_TRANSACTION_TYPE TRANSACTION_TABLE.TRANSACTION_TYPE%TYPE,
        P_AMOUNT TRANSACTION_TABLE.AMOUNT%TYPE,
        P_TIME_STAMP TRANSACTION_TABLE.TIME_STAMP%TYPE,
        P_TRANSACTION_DETAILS TRANSACTION_TABLE.TRANSACTION_DETAILS%TYPE,
        P_STATUS TRANSACTION_TABLE.STATUS%TYPE
    ) AS
        V_BRANCH_ID BRANCH.BRANCH_ID%TYPE;
        V_ACCOUNT_BRANCH_ID BRANCH.BRANCH_ID%TYPE;
    BEGIN
        SELECT BRANCH_ID INTO V_BRANCH_ID FROM EMPLOYEE WHERE EMPLOYEE_ID = P_EMPLOYEE_ID;
        SELECT BRANCH_ID INTO V_ACCOUNT_BRANCH_ID FROM ACCOUNTS WHERE ACCOUNT_ID = P_ACCOUNT_ID;

        IF V_BRANCH_ID = V_ACCOUNT_BRANCH_ID THEN
            INSERT INTO TRANSACTION_TABLE (ACCOUNT_ID, STATUS_CODE, TRANSACTION_TYPE, AMOUNT, TIME_STAMP, TRANSACTION_DETAILS, STATUS)
            VALUES (P_ACCOUNT_ID, P_STATUS_CODE, P_TRANSACTION_TYPE, P_AMOUNT, P_TIME_STAMP, P_TRANSACTION_DETAILS, P_STATUS);

            DBMS_OUTPUT.PUT_LINE('Transaction inserted successfully.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Transaction not allowed. Account does not belong to the employee''s branch.');
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    END INSERT_TRANSACTION;
    
    PROCEDURE VIEW_LOANS (
        P_EMPLOYEE_ID NUMBER
    ) AS
        V_BRANCH_ID BRANCH.BRANCH_ID%TYPE;
        CURSOR LOANS_CURSOR IS
            SELECT L.LOAN_ID, L.CUSTOMER_ID, LT.LOAN_TYPE, L.BRANCH_ID, L.AMOUNT, L.INTEREST_RATE, L.TERM_IN_MONTHS, L.COMMENCEMENT_DATE
            FROM LOAN L
            JOIN LOAN_TYPE LT ON L.LOAN_TYPE = LT.LOAN_TYPE_ID
            WHERE L.BRANCH_ID = V_BRANCH_ID;
        LOAN_REC LOANS_CURSOR%ROWTYPE;
    BEGIN
        SELECT BRANCH_ID INTO V_BRANCH_ID FROM EMPLOYEE WHERE EMPLOYEE_ID = P_EMPLOYEE_ID;

        OPEN LOANS_CURSOR;
        LOOP
            FETCH LOANS_CURSOR INTO LOAN_REC;
            EXIT WHEN LOANS_CURSOR%NOTFOUND;

            DBMS_OUTPUT.PUT_LINE('LOAN_ID: ' || LOAN_REC.LOAN_ID || ', CUSTOMER_ID: ' || LOAN_REC.CUSTOMER_ID || ', LOAN_TYPE: ' || LOAN_REC.LOAN_TYPE || ', BRANCH_ID: ' || LOAN_REC.BRANCH_ID || ', AMOUNT: ' || LOAN_REC.AMOUNT || ', INTEREST_RATE: ' || LOAN_REC.INTEREST_RATE || ', TERM_IN_MONTHS: ' || LOAN_REC.TERM_IN_MONTHS || ', COMMENCEMENT_DATE: ' || TO_CHAR(LOAN_REC.COMMENCEMENT_DATE, 'DD-MON-YYYY'));
        END LOOP;

        CLOSE LOANS_CURSOR;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    END VIEW_LOANS;
    
    PROCEDURE ADD_LOAN (
        P_EMPLOYEE_ID NUMBER,
        P_CUSTOMER_ID LOAN.CUSTOMER_ID%TYPE,
        P_LOAN_TYPE LOAN.LOAN_TYPE%TYPE,
        P_AMOUNT LOAN.AMOUNT%TYPE,
        P_INTEREST_RATE LOAN.INTEREST_RATE%TYPE,
        P_TERM_IN_MONTHS LOAN.TERM_IN_MONTHS%TYPE,
        P_COMMENCEMENT_DATE LOAN.COMMENCEMENT_DATE%TYPE
    ) AS
        V_BRANCH_ID BRANCH.BRANCH_ID%TYPE;
    BEGIN
        SELECT BRANCH_ID INTO V_BRANCH_ID FROM EMPLOYEE WHERE EMPLOYEE_ID = P_EMPLOYEE_ID;

        INSERT INTO LOAN (CUSTOMER_ID, LOAN_TYPE, BRANCH_ID, AMOUNT, INTEREST_RATE, TERM_IN_MONTHS, COMMENCEMENT_DATE)
        VALUES (P_CUSTOMER_ID, P_LOAN_TYPE, V_BRANCH_ID, P_AMOUNT, P_INTEREST_RATE, P_TERM_IN_MONTHS, P_COMMENCEMENT_DATE);

        DBMS_OUTPUT.PUT_LINE('Loan added successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    END ADD_LOAN;
    
    PROCEDURE DELETE_CUSTOMER_ACCOUNT (
        p_account_id ACCOUNTS.ACCOUNT_ID%TYPE,
        p_employee_id EMPLOYEE.EMPLOYEE_ID%TYPE
    ) IS
        v_account_count NUMBER;
        v_employee_branch NUMBER;
        v_account_branch NUMBER;
        account_exists EXCEPTION;
        unauthorized_branch EXCEPTION;
        account_not_found EXCEPTION;
        employee_not_found EXCEPTION;
    BEGIN

    -- Get the branch_id of the employee
        BEGIN
            SELECT BRANCH_ID
            INTO v_employee_branch
            FROM EMPLOYEE
            WHERE EMPLOYEE_ID = p_employee_id;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RAISE employee_not_found;
        END;
        
        BEGIN
            SELECT BRANCH_ID
            INTO v_account_branch
            FROM ACCOUNTS
            WHERE ACCOUNT_ID = p_account_id;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RAISE account_not_found;
        END;    

        BEGIN
            SELECT COUNT(*)
            INTO v_account_count
            FROM ACCOUNTS A
            JOIN BRANCH B ON A.BRANCH_ID = B.BRANCH_ID
            WHERE A.ACCOUNT_ID = p_account_id;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RAISE account_not_found;
        END;
      
        IF v_account_count = 0 THEN
            RAISE account_exists;
        ELSE
        -- Check if the account is from the same branch as the employee
            IF v_account_branch != v_employee_branch THEN
                RAISE unauthorized_branch;
            END IF;

            DELETE FROM transaction_table T WHERE T.ACCOUNT_ID = p_account_id;
        
            DELETE FROM accounts A WHERE A.ACCOUNT_ID = p_account_id;
            
            DBMS_OUTPUT.PUT_LINE('Customer Account deleted successfully.');
        
        END IF;

        EXCEPTION
            WHEN account_exists THEN
                RAISE_APPLICATION_ERROR(-20002, 'An account with the customer ID does not exist.');
            WHEN unauthorized_branch THEN
                RAISE_APPLICATION_ERROR(-20003, 'The employee does not have the authority to delete an account from a different branch.');
            WHEN account_not_found THEN
                RAISE_APPLICATION_ERROR(-20019, 'Account ID does not exist.');
            WHEN employee_not_found THEN
                RAISE_APPLICATION_ERROR(-20029, 'Employee ID does not exist.');    
    END DELETE_CUSTOMER_ACCOUNT;
    
END EMPLOYEE_PKG;
/
--------------------------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE MANAGER_PKG AS
    
    PROCEDURE VIEW_EMPLOYEE_DETAILS(P_EMPLOYEE_ID NUMBER);
    
    PROCEDURE VIEW_CUSTOMERS(P_EMPLOYEE_ID NUMBER);
    
    PROCEDURE VIEW_CUSTOMER_BY_ID(P_EMPLOYEE_ID NUMBER, P_CUSTOMER_ID NUMBER);
    
    PROCEDURE INSERT_CUSTOMER (
        P_FIRST_NAME CUSTOMER.FIRST_NAME%TYPE,
        P_LAST_NAME CUSTOMER.LAST_NAME%TYPE,
        P_DATE_OF_BIRTH CUSTOMER.DATE_OF_BIRTH%TYPE,
        P_EMAIL_ID CUSTOMER.EMAIL_ID%TYPE,
        P_PHONE_NUMBER CUSTOMER.PHONE_NUMBER%TYPE,
        P_DATE_REGISTERED CUSTOMER.DATE_REGISTERED%TYPE,
        P_ANNUAL_INCOME CUSTOMER.ANNUAL_INCOME%TYPE,
        P_LOGIN CUSTOMER.LOGIN%TYPE,
        P_PASSWORD_HASH CUSTOMER.PASSWORD_HASH%TYPE,
        P_ADDRESS CUSTOMER.ADDRESS%TYPE,
        P_CITY CUSTOMER.CITY%TYPE,
        P_STATE_NAME CUSTOMER.STATE_NAME%TYPE
    );
    
    PROCEDURE UPDATE_CUSTOMER (
        P_EMPLOYEE_ID NUMBER,
        P_CUSTOMER_ID CUSTOMER.CUSTOMER_ID%TYPE,
        P_FIRST_NAME CUSTOMER.FIRST_NAME%TYPE DEFAULT NULL,
        P_LAST_NAME CUSTOMER.LAST_NAME%TYPE DEFAULT NULL,
        P_DATE_OF_BIRTH CUSTOMER.DATE_OF_BIRTH%TYPE DEFAULT NULL,
        P_EMAIL_ID CUSTOMER.EMAIL_ID%TYPE DEFAULT NULL,
        P_PHONE_NUMBER CUSTOMER.PHONE_NUMBER%TYPE DEFAULT NULL,
        P_ANNUAL_INCOME CUSTOMER.ANNUAL_INCOME%TYPE DEFAULT NULL,
        P_ADDRESS CUSTOMER.ADDRESS%TYPE DEFAULT NULL,
        P_CITY CUSTOMER.CITY%TYPE DEFAULT NULL,
        P_STATE_NAME CUSTOMER.STATE_NAME%TYPE DEFAULT NULL
    );
    
    PROCEDURE VIEW_ACCOUNTS(P_EMPLOYEE_ID NUMBER);
    
    PROCEDURE INSERT_ACCOUNT (
        P_EMPLOYEE_ID NUMBER,
        P_CUSTOMER_ID ACCOUNTS.CUSTOMER_ID%TYPE,
        P_ACCOUNT_TYPE ACCOUNTS.ACCOUNT_TYPE%TYPE,
        P_CREATED_DATE ACCOUNTS.CREATED_DATE%TYPE,
        P_BALANCE ACCOUNTS.BALANCE%TYPE,
        P_CARD_DETAILS ACCOUNTS.CARD_DETAILS%TYPE,
        P_PROOF ACCOUNTS.PROOF%TYPE
    );
    
    PROCEDURE UPDATE_ACCOUNT (
        P_EMPLOYEE_ID NUMBER,
        P_ACCOUNT_ID ACCOUNTS.ACCOUNT_ID%TYPE,
        P_ACCOUNT_TYPE ACCOUNTS.ACCOUNT_TYPE%TYPE DEFAULT NULL,
        P_BALANCE ACCOUNTS.BALANCE%TYPE DEFAULT NULL,
        P_CARD_DETAILS ACCOUNTS.CARD_DETAILS%TYPE DEFAULT NULL,
        P_PROOF ACCOUNTS.PROOF%TYPE DEFAULT NULL
    );
    
    PROCEDURE VIEW_TRANSACTIONS (P_EMPLOYEE_ID NUMBER);
    
    PROCEDURE INSERT_TRANSACTION (
        P_EMPLOYEE_ID NUMBER,
        P_ACCOUNT_ID TRANSACTION_TABLE.ACCOUNT_ID%TYPE,
        P_STATUS_CODE TRANSACTION_TABLE.STATUS_CODE%TYPE,
        P_TRANSACTION_TYPE TRANSACTION_TABLE.TRANSACTION_TYPE%TYPE,
        P_AMOUNT TRANSACTION_TABLE.AMOUNT%TYPE,
        P_TIME_STAMP TRANSACTION_TABLE.TIME_STAMP%TYPE,
        P_TRANSACTION_DETAILS TRANSACTION_TABLE.TRANSACTION_DETAILS%TYPE,
        P_STATUS TRANSACTION_TABLE.STATUS%TYPE
    );
    
    PROCEDURE VIEW_LOANS (
        P_EMPLOYEE_ID NUMBER
    );
    
    PROCEDURE ADD_LOAN (
        P_EMPLOYEE_ID NUMBER,
        P_CUSTOMER_ID LOAN.CUSTOMER_ID%TYPE,
        P_LOAN_TYPE LOAN.LOAN_TYPE%TYPE,
        P_AMOUNT LOAN.AMOUNT%TYPE,
        P_INTEREST_RATE LOAN.INTEREST_RATE%TYPE,
        P_TERM_IN_MONTHS LOAN.TERM_IN_MONTHS%TYPE,
        P_COMMENCEMENT_DATE LOAN.COMMENCEMENT_DATE%TYPE
    );

    -- Additional manager procedures for adding and updating employees
    PROCEDURE ADD_EMPLOYEE (
        P_EMPLOYEE_ID NUMBER,
        P_BRANCH_ID NUMBER,
        P_ROLE_ID NUMBER,
        P_FIRST_NAME EMPLOYEE.FIRST_NAME%TYPE,
        P_LAST_NAME EMPLOYEE.LAST_NAME%TYPE,
        P_DATE_OF_BIRTH EMPLOYEE.DATE_OF_BIRTH%TYPE,
        P_EMAIL_ID EMPLOYEE.EMAIL_ID%TYPE,
        P_PHONE_NUMBER EMPLOYEE.PHONE_NUMBER%TYPE,
        P_DATE_REGISTERED EMPLOYEE.DATE_REGISTERED%TYPE,
        P_LOGIN EMPLOYEE.LOGIN%TYPE,
        P_PASSWORD_HASH EMPLOYEE.PASSWORD_HASH%TYPE,
        P_ADDRESS EMPLOYEE.ADDRESS%TYPE,
        P_CITY EMPLOYEE.CITY%TYPE,
        P_STATE_NAME EMPLOYEE.STATE_NAME%TYPE,
        P_MANAGER_ID EMPLOYEE.MANAGER_ID%TYPE
    );
    
    PROCEDURE UPDATE_EMPLOYEE (
        P_EMPLOYEE_ID NUMBER,
        P_TARGET_EMPLOYEE_ID NUMBER,
        P_FIRST_NAME EMPLOYEE.FIRST_NAME%TYPE DEFAULT NULL,
        P_LAST_NAME EMPLOYEE.LAST_NAME%TYPE DEFAULT NULL,
        P_DATE_OF_BIRTH EMPLOYEE.DATE_OF_BIRTH%TYPE DEFAULT NULL,
        P_EMAIL_ID EMPLOYEE.EMAIL_ID%TYPE DEFAULT NULL,
        P_PHONE_NUMBER EMPLOYEE.PHONE_NUMBER%TYPE DEFAULT NULL,
        P_DATE_REGISTERED EMPLOYEE.DATE_REGISTERED%TYPE DEFAULT NULL,
        P_LOGIN EMPLOYEE.LOGIN%TYPE DEFAULT NULL,
        P_PASSWORD_HASH EMPLOYEE.PASSWORD_HASH%TYPE DEFAULT NULL,
        P_ADDRESS EMPLOYEE.ADDRESS%TYPE DEFAULT NULL,
        P_CITY EMPLOYEE.CITY%TYPE DEFAULT NULL,
        P_STATE_NAME EMPLOYEE.STATE_NAME%TYPE DEFAULT NULL,
        P_MANAGER_ID EMPLOYEE.MANAGER_ID%TYPE DEFAULT NULL
     );
     
     PROCEDURE DELETE_CUSTOMER_ACCOUNT (
        p_account_id      IN ACCOUNTS.ACCOUNT_ID%TYPE,
        p_employee_id       IN EMPLOYEE.EMPLOYEE_ID%TYPE
    );
     
    PROCEDURE DELETE_EMPLOYEE (
        p_manager_id      IN EMPLOYEE.EMPLOYEE_ID%TYPE,
        p_employee_id       IN EMPLOYEE.EMPLOYEE_ID%TYPE
    );
    
END MANAGER_PKG;
/

CREATE OR REPLACE PACKAGE BODY MANAGER_PKG AS
    --VIEW EMPLOYEE DETAILS
    PROCEDURE VIEW_EMPLOYEE_DETAILS (P_EMPLOYEE_ID NUMBER) IS
        V_EMPLOYEE EMPLOYEE%ROWTYPE;
    BEGIN
        SELECT * INTO V_EMPLOYEE FROM EMPLOYEE WHERE EMPLOYEE_ID = P_EMPLOYEE_ID;
        
        DBMS_OUTPUT.PUT_LINE('Employee ID: ' || V_EMPLOYEE.EMPLOYEE_ID);
        DBMS_OUTPUT.PUT_LINE('First Name: ' || V_EMPLOYEE.FIRST_NAME);
        DBMS_OUTPUT.PUT_LINE('Last Name: ' || V_EMPLOYEE.LAST_NAME);
        DBMS_OUTPUT.PUT_LINE('Date of Birth: ' || V_EMPLOYEE.DATE_OF_BIRTH);
        DBMS_OUTPUT.PUT_LINE('Email ID: ' || V_EMPLOYEE.EMAIL_ID);
        DBMS_OUTPUT.PUT_LINE('Phone Number: ' || V_EMPLOYEE.PHONE_NUMBER);
        DBMS_OUTPUT.PUT_LINE('Date Registered: ' || V_EMPLOYEE.DATE_REGISTERED);
        DBMS_OUTPUT.PUT_LINE('Address: ' || V_EMPLOYEE.ADDRESS);
        DBMS_OUTPUT.PUT_LINE('City: ' || V_EMPLOYEE.CITY);
        DBMS_OUTPUT.PUT_LINE('State Name: ' || V_EMPLOYEE.STATE_NAME);
        DBMS_OUTPUT.PUT_LINE('Branch ID: ' || V_EMPLOYEE.BRANCH_ID);
        DBMS_OUTPUT.PUT_LINE('Role ID: ' || V_EMPLOYEE.ROLE_ID);
        DBMS_OUTPUT.PUT_LINE('Manager ID: ' || V_EMPLOYEE.MANAGER_ID);
    EXCEPTION
        WHEN NO_DATA_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('No employee found with ID: ' || P_EMPLOYEE_ID);
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    END VIEW_EMPLOYEE_DETAILS;
    
    PROCEDURE VIEW_CUSTOMERS(P_EMPLOYEE_ID NUMBER) IS
        CURSOR CUSTOMERS_CURSOR IS
            SELECT C.*, A.ACCOUNT_ID
            FROM CUSTOMER C
            JOIN ACCOUNTS A ON C.CUSTOMER_ID = A.CUSTOMER_ID
            JOIN EMPLOYEE E ON A.BRANCH_ID = E.BRANCH_ID
            WHERE E.EMPLOYEE_ID = P_EMPLOYEE_ID;

        CUSTOMER_REC CUSTOMERS_CURSOR%ROWTYPE;
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Customer Details:');
        DBMS_OUTPUT.PUT_LINE('--------------------------------------------------------------------------------');
        OPEN CUSTOMERS_CURSOR;
        LOOP
            FETCH CUSTOMERS_CURSOR INTO CUSTOMER_REC;
            EXIT WHEN CUSTOMERS_CURSOR%NOTFOUND;

            DBMS_OUTPUT.PUT_LINE('Customer ID: ' || CUSTOMER_REC.CUSTOMER_ID || ', First Name: ' || CUSTOMER_REC.FIRST_NAME || ', Last Name: ' || CUSTOMER_REC.LAST_NAME || ', Email: ' || CUSTOMER_REC.EMAIL_ID || ', Phone Number: ' || CUSTOMER_REC.PHONE_NUMBER || ', Account ID: ' || CUSTOMER_REC.ACCOUNT_ID);
        END LOOP;
        CLOSE CUSTOMERS_CURSOR;
    END VIEW_CUSTOMERS;

    PROCEDURE VIEW_CUSTOMER_BY_ID(P_EMPLOYEE_ID NUMBER, P_CUSTOMER_ID NUMBER) IS
        CURSOR ACCOUNTS_CURSOR IS
            SELECT C.CUSTOMER_ID, C.FIRST_NAME, C.LAST_NAME, C.EMAIL_ID, C.PHONE_NUMBER, A.ACCOUNT_ID
            FROM CUSTOMER C
            JOIN ACCOUNTS A ON C.CUSTOMER_ID = A.CUSTOMER_ID
            JOIN EMPLOYEE E ON A.BRANCH_ID = E.BRANCH_ID
            WHERE E.EMPLOYEE_ID = P_EMPLOYEE_ID AND C.CUSTOMER_ID = P_CUSTOMER_ID;

        ACCOUNT_REC ACCOUNTS_CURSOR%ROWTYPE;
        ROW_FOUND BOOLEAN := FALSE;
    BEGIN
        DBMS_OUTPUT.PUT_LINE('Customer Details:');
        DBMS_OUTPUT.PUT_LINE('--------------------------------------------------------------------------------');
        OPEN ACCOUNTS_CURSOR;
        LOOP
            FETCH ACCOUNTS_CURSOR INTO ACCOUNT_REC;
            EXIT WHEN ACCOUNTS_CURSOR%NOTFOUND;

            DBMS_OUTPUT.PUT_LINE('Customer ID: ' || ACCOUNT_REC.CUSTOMER_ID || ', First Name: ' || ACCOUNT_REC.FIRST_NAME || ', Last Name: ' || ACCOUNT_REC.LAST_NAME || ', Email: ' || ACCOUNT_REC.EMAIL_ID || ', Phone Number: ' || ACCOUNT_REC.PHONE_NUMBER || ', Account ID: ' || ACCOUNT_REC.ACCOUNT_ID);
            ROW_FOUND := TRUE;
        END LOOP;
        CLOSE ACCOUNTS_CURSOR;

        IF NOT ROW_FOUND THEN
            DBMS_OUTPUT.PUT_LINE('No customer found with the provided ID and manager branch.');
        END IF;
    END VIEW_CUSTOMER_BY_ID;
    
    PROCEDURE INSERT_CUSTOMER (
        P_FIRST_NAME CUSTOMER.FIRST_NAME%TYPE,
        P_LAST_NAME CUSTOMER.LAST_NAME%TYPE,
        P_DATE_OF_BIRTH CUSTOMER.DATE_OF_BIRTH%TYPE,
        P_EMAIL_ID CUSTOMER.EMAIL_ID%TYPE,
        P_PHONE_NUMBER CUSTOMER.PHONE_NUMBER%TYPE,
        P_DATE_REGISTERED CUSTOMER.DATE_REGISTERED%TYPE,
        P_ANNUAL_INCOME CUSTOMER.ANNUAL_INCOME%TYPE,
        P_LOGIN CUSTOMER.LOGIN%TYPE,
        P_PASSWORD_HASH CUSTOMER.PASSWORD_HASH%TYPE,
        P_ADDRESS CUSTOMER.ADDRESS%TYPE,
        P_CITY CUSTOMER.CITY%TYPE,
        P_STATE_NAME CUSTOMER.STATE_NAME%TYPE
    ) IS
        V_CUSTOMER_COUNT NUMBER;
    BEGIN
        SELECT COUNT(*) INTO V_CUSTOMER_COUNT FROM CUSTOMER WHERE EMAIL_ID = P_EMAIL_ID OR PHONE_NUMBER = P_PHONE_NUMBER OR LOGIN = P_LOGIN;

        IF V_CUSTOMER_COUNT = 0 THEN
            INSERT INTO CUSTOMER (
                FIRST_NAME,
                LAST_NAME,
                DATE_OF_BIRTH,
                EMAIL_ID,
                PHONE_NUMBER,
                DATE_REGISTERED,
                ANNUAL_INCOME,
                LOGIN,
                PASSWORD_HASH,
                ADDRESS,
                CITY,
                STATE_NAME
            ) VALUES (
                P_FIRST_NAME,
                P_LAST_NAME,
                P_DATE_OF_BIRTH,
                P_EMAIL_ID,
                P_PHONE_NUMBER,
                P_DATE_REGISTERED,
                P_ANNUAL_INCOME,
                P_LOGIN,
                P_PASSWORD_HASH,
                P_ADDRESS,
                P_CITY,
                P_STATE_NAME
            );

            DBMS_OUTPUT.PUT_LINE('Customer record inserted successfully.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Customer with the provided email or phone number or login already exists.');
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    END INSERT_CUSTOMER;
    
    PROCEDURE UPDATE_CUSTOMER (
        P_EMPLOYEE_ID NUMBER,
        P_CUSTOMER_ID CUSTOMER.CUSTOMER_ID%TYPE,
        P_FIRST_NAME CUSTOMER.FIRST_NAME%TYPE DEFAULT NULL,
        P_LAST_NAME CUSTOMER.LAST_NAME%TYPE DEFAULT NULL,
        P_DATE_OF_BIRTH CUSTOMER.DATE_OF_BIRTH%TYPE DEFAULT NULL,
        P_EMAIL_ID CUSTOMER.EMAIL_ID%TYPE DEFAULT NULL,
        P_PHONE_NUMBER CUSTOMER.PHONE_NUMBER%TYPE DEFAULT NULL,
        P_ANNUAL_INCOME CUSTOMER.ANNUAL_INCOME%TYPE DEFAULT NULL,
        P_ADDRESS CUSTOMER.ADDRESS%TYPE DEFAULT NULL,
        P_CITY CUSTOMER.CITY%TYPE DEFAULT NULL,
        P_STATE_NAME CUSTOMER.STATE_NAME%TYPE DEFAULT NULL
    ) AS
        V_BRANCH_ID BRANCH.BRANCH_ID%TYPE;
    BEGIN
        SELECT BRANCH_ID INTO V_BRANCH_ID FROM EMPLOYEE WHERE EMPLOYEE_ID = P_EMPLOYEE_ID;

        UPDATE CUSTOMER
        SET FIRST_NAME = COALESCE(P_FIRST_NAME, FIRST_NAME),
            LAST_NAME = COALESCE(P_LAST_NAME, LAST_NAME),
            DATE_OF_BIRTH = COALESCE(P_DATE_OF_BIRTH, DATE_OF_BIRTH),
            EMAIL_ID = COALESCE(P_EMAIL_ID, EMAIL_ID),
            PHONE_NUMBER = COALESCE(P_PHONE_NUMBER, PHONE_NUMBER),
            ANNUAL_INCOME = COALESCE(P_ANNUAL_INCOME, ANNUAL_INCOME),
            ADDRESS = COALESCE(P_ADDRESS, ADDRESS),
            CITY = COALESCE(P_CITY, CITY),
            STATE_NAME = COALESCE(P_STATE_NAME, STATE_NAME)
        WHERE CUSTOMER_ID = P_CUSTOMER_ID
        AND EXISTS (
            SELECT 1 FROM ACCOUNTS
            WHERE ACCOUNTS.CUSTOMER_ID = P_CUSTOMER_ID
            AND ACCOUNTS.BRANCH_ID = V_BRANCH_ID
        );

        IF SQL%ROWCOUNT > 0 THEN
            DBMS_OUTPUT.PUT_LINE('Customer record updated successfully.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('No customer record found with the given ID in the manager branch.');
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    END UPDATE_CUSTOMER;
    
    PROCEDURE VIEW_ACCOUNTS(P_EMPLOYEE_ID NUMBER) AS
        CURSOR C_ACCOUNTS IS
            SELECT A.*
            FROM ACCOUNTS A
            JOIN BRANCH B ON A.BRANCH_ID = B.BRANCH_ID
            WHERE B.BRANCH_ID = (SELECT BRANCH_ID FROM EMPLOYEE WHERE EMPLOYEE_ID = P_EMPLOYEE_ID);
    BEGIN
        FOR V_ACCOUNT IN C_ACCOUNTS LOOP
            DBMS_OUTPUT.PUT_LINE('Account ID: ' || V_ACCOUNT.ACCOUNT_ID || ', Customer ID: ' || V_ACCOUNT.CUSTOMER_ID || ', Account Type: ' || V_ACCOUNT.ACCOUNT_TYPE || ', Branch ID: ' || V_ACCOUNT.BRANCH_ID || ', Created Date: ' || V_ACCOUNT.CREATED_DATE || ', Balance: ' || V_ACCOUNT.BALANCE || ', Card Details: ' || V_ACCOUNT.CARD_DETAILS || ', Proof: ' || V_ACCOUNT.PROOF);
        END LOOP;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    END VIEW_ACCOUNTS;
    
    PROCEDURE INSERT_ACCOUNT (
        P_EMPLOYEE_ID NUMBER,
        P_CUSTOMER_ID ACCOUNTS.CUSTOMER_ID%TYPE,
        P_ACCOUNT_TYPE ACCOUNTS.ACCOUNT_TYPE%TYPE,
        P_CREATED_DATE ACCOUNTS.CREATED_DATE%TYPE,
        P_BALANCE ACCOUNTS.BALANCE%TYPE,
        P_CARD_DETAILS ACCOUNTS.CARD_DETAILS%TYPE,
        P_PROOF ACCOUNTS.PROOF%TYPE
    ) AS
        V_BRANCH_ID BRANCH.BRANCH_ID%TYPE;
        V_ACCOUNT_COUNT NUMBER;
    BEGIN
        SELECT BRANCH_ID INTO V_BRANCH_ID FROM EMPLOYEE WHERE EMPLOYEE_ID = P_EMPLOYEE_ID;

        SELECT COUNT(*) INTO V_ACCOUNT_COUNT
        FROM ACCOUNTS
        WHERE CUSTOMER_ID = P_CUSTOMER_ID AND ACCOUNT_TYPE = P_ACCOUNT_TYPE AND BRANCH_ID = V_BRANCH_ID;

        IF V_ACCOUNT_COUNT = 0 THEN
            INSERT INTO ACCOUNTS (CUSTOMER_ID, ACCOUNT_TYPE, BRANCH_ID, CREATED_DATE, BALANCE, CARD_DETAILS, PROOF)
            VALUES (P_CUSTOMER_ID, P_ACCOUNT_TYPE, V_BRANCH_ID, P_CREATED_DATE, P_BALANCE, P_CARD_DETAILS, P_PROOF);

            DBMS_OUTPUT.PUT_LINE('Account inserted successfully.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Account already exists.');
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    END INSERT_ACCOUNT;
    
    PROCEDURE UPDATE_ACCOUNT (
        P_EMPLOYEE_ID NUMBER,
        P_ACCOUNT_ID ACCOUNTS.ACCOUNT_ID%TYPE,
        P_ACCOUNT_TYPE ACCOUNTS.ACCOUNT_TYPE%TYPE DEFAULT NULL,
        P_BALANCE ACCOUNTS.BALANCE%TYPE DEFAULT NULL,
        P_CARD_DETAILS ACCOUNTS.CARD_DETAILS%TYPE DEFAULT NULL,
        P_PROOF ACCOUNTS.PROOF%TYPE DEFAULT NULL
    ) AS
        V_BRANCH_ID BRANCH.BRANCH_ID%TYPE;
    BEGIN
        SELECT BRANCH_ID INTO V_BRANCH_ID FROM EMPLOYEE WHERE EMPLOYEE_ID = P_EMPLOYEE_ID;
    
        UPDATE ACCOUNTS
        SET ACCOUNT_TYPE = COALESCE(P_ACCOUNT_TYPE, ACCOUNT_TYPE),
            BALANCE = COALESCE(P_BALANCE, BALANCE),
            CARD_DETAILS = COALESCE(P_CARD_DETAILS, CARD_DETAILS),
            PROOF = COALESCE(P_PROOF, PROOF)
        WHERE ACCOUNT_ID = P_ACCOUNT_ID
        AND BRANCH_ID = V_BRANCH_ID;

        IF SQL%ROWCOUNT = 0 THEN
            DBMS_OUTPUT.PUT_LINE('No account found for the specified account_id and manager_id');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Account updated successfully.');
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    END UPDATE_ACCOUNT;
    
    PROCEDURE VIEW_TRANSACTIONS (P_EMPLOYEE_ID NUMBER) AS
        V_BRANCH_ID BRANCH.BRANCH_ID%TYPE;
        CURSOR TRANSACTIONS_CURSOR IS
            SELECT T.TRANSACTION_ID, T.ACCOUNT_ID, T.STATUS_CODE, T.TRANSACTION_TYPE, T.AMOUNT, T.TIME_STAMP, T.TRANSACTION_DETAILS, T.STATUS
            FROM TRANSACTION_TABLE T
            JOIN ACCOUNTS A ON T.ACCOUNT_ID = A.ACCOUNT_ID
            WHERE A.BRANCH_ID = V_BRANCH_ID
            ORDER BY T.ACCOUNT_ID;
        TRANSACTION_RECORD TRANSACTIONS_CURSOR%ROWTYPE;
    BEGIN
        SELECT BRANCH_ID INTO V_BRANCH_ID FROM EMPLOYEE WHERE EMPLOYEE_ID = P_EMPLOYEE_ID;

        OPEN TRANSACTIONS_CURSOR;
        LOOP
            FETCH TRANSACTIONS_CURSOR INTO TRANSACTION_RECORD;
            EXIT WHEN TRANSACTIONS_CURSOR%NOTFOUND;

            DBMS_OUTPUT.PUT_LINE('Transaction ID: ' || TRANSACTION_RECORD.TRANSACTION_ID || ', Account ID: ' || TRANSACTION_RECORD.ACCOUNT_ID || ', Status Code: ' || TRANSACTION_RECORD.STATUS_CODE ||
                             ', Transaction Type: ' || TRANSACTION_RECORD.TRANSACTION_TYPE || ', Amount: ' || TRANSACTION_RECORD.AMOUNT || ', Time Stamp: ' || TRANSACTION_RECORD.TIME_STAMP ||
                             ', Transaction Details: ' || TRANSACTION_RECORD.TRANSACTION_DETAILS || ', Status: ' || TRANSACTION_RECORD.STATUS);
        END LOOP;
        CLOSE TRANSACTIONS_CURSOR;

    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    END VIEW_TRANSACTIONS;
    
    PROCEDURE INSERT_TRANSACTION (
        P_EMPLOYEE_ID NUMBER,
        P_ACCOUNT_ID TRANSACTION_TABLE.ACCOUNT_ID%TYPE,
        P_STATUS_CODE TRANSACTION_TABLE.STATUS_CODE%TYPE,
        P_TRANSACTION_TYPE TRANSACTION_TABLE.TRANSACTION_TYPE%TYPE,
        P_AMOUNT TRANSACTION_TABLE.AMOUNT%TYPE,
        P_TIME_STAMP TRANSACTION_TABLE.TIME_STAMP%TYPE,
        P_TRANSACTION_DETAILS TRANSACTION_TABLE.TRANSACTION_DETAILS%TYPE,
        P_STATUS TRANSACTION_TABLE.STATUS%TYPE
    ) AS
        V_BRANCH_ID BRANCH.BRANCH_ID%TYPE;
        V_ACCOUNT_BRANCH_ID BRANCH.BRANCH_ID%TYPE;
    BEGIN
        SELECT BRANCH_ID INTO V_BRANCH_ID FROM EMPLOYEE WHERE EMPLOYEE_ID = P_EMPLOYEE_ID;
        SELECT BRANCH_ID INTO V_ACCOUNT_BRANCH_ID FROM ACCOUNTS WHERE ACCOUNT_ID = P_ACCOUNT_ID;

        IF V_BRANCH_ID = V_ACCOUNT_BRANCH_ID THEN
            INSERT INTO TRANSACTION_TABLE (ACCOUNT_ID, STATUS_CODE, TRANSACTION_TYPE, AMOUNT, TIME_STAMP, TRANSACTION_DETAILS, STATUS)
            VALUES (P_ACCOUNT_ID, P_STATUS_CODE, P_TRANSACTION_TYPE, P_AMOUNT, P_TIME_STAMP, P_TRANSACTION_DETAILS, P_STATUS);

            DBMS_OUTPUT.PUT_LINE('Transaction inserted successfully.');
        ELSE
            DBMS_OUTPUT.PUT_LINE('Transaction not allowed. Account does not belong to the manager''s branch.');
        END IF;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    END INSERT_TRANSACTION;
    
    PROCEDURE VIEW_LOANS (
        P_EMPLOYEE_ID NUMBER
    ) AS
        V_BRANCH_ID BRANCH.BRANCH_ID%TYPE;
        CURSOR LOANS_CURSOR IS
            SELECT L.LOAN_ID, L.CUSTOMER_ID, LT.LOAN_TYPE, L.BRANCH_ID, L.AMOUNT, L.INTEREST_RATE, L.TERM_IN_MONTHS, L.COMMENCEMENT_DATE
            FROM LOAN L
            JOIN LOAN_TYPE LT ON L.LOAN_TYPE = LT.LOAN_TYPE_ID
            WHERE L.BRANCH_ID = V_BRANCH_ID;
        LOAN_REC LOANS_CURSOR%ROWTYPE;
    BEGIN
        SELECT BRANCH_ID INTO V_BRANCH_ID FROM EMPLOYEE WHERE EMPLOYEE_ID = P_EMPLOYEE_ID;

        OPEN LOANS_CURSOR;
        LOOP
            FETCH LOANS_CURSOR INTO LOAN_REC;
            EXIT WHEN LOANS_CURSOR%NOTFOUND;

            DBMS_OUTPUT.PUT_LINE('LOAN_ID: ' || LOAN_REC.LOAN_ID || ', CUSTOMER_ID: ' || LOAN_REC.CUSTOMER_ID || ', LOAN_TYPE: ' || LOAN_REC.LOAN_TYPE || ', BRANCH_ID: ' || LOAN_REC.BRANCH_ID || ', AMOUNT: ' || LOAN_REC.AMOUNT || ', INTEREST_RATE: ' || LOAN_REC.INTEREST_RATE || ', TERM_IN_MONTHS: ' || LOAN_REC.TERM_IN_MONTHS || ', COMMENCEMENT_DATE: ' || TO_CHAR(LOAN_REC.COMMENCEMENT_DATE, 'DD-MON-YYYY'));
        END LOOP;

        CLOSE LOANS_CURSOR;
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    END VIEW_LOANS;
    
    PROCEDURE ADD_LOAN (
        P_EMPLOYEE_ID NUMBER,
        P_CUSTOMER_ID LOAN.CUSTOMER_ID%TYPE,
        P_LOAN_TYPE LOAN.LOAN_TYPE%TYPE,
        P_AMOUNT LOAN.AMOUNT%TYPE,
        P_INTEREST_RATE LOAN.INTEREST_RATE%TYPE,
        P_TERM_IN_MONTHS LOAN.TERM_IN_MONTHS%TYPE,
        P_COMMENCEMENT_DATE LOAN.COMMENCEMENT_DATE%TYPE
    ) AS
        V_BRANCH_ID BRANCH.BRANCH_ID%TYPE;
    BEGIN
        SELECT BRANCH_ID INTO V_BRANCH_ID FROM EMPLOYEE WHERE EMPLOYEE_ID = P_EMPLOYEE_ID;

        INSERT INTO LOAN (CUSTOMER_ID, LOAN_TYPE, BRANCH_ID, AMOUNT, INTEREST_RATE, TERM_IN_MONTHS, COMMENCEMENT_DATE)
        VALUES (P_CUSTOMER_ID, P_LOAN_TYPE, V_BRANCH_ID, P_AMOUNT, P_INTEREST_RATE, P_TERM_IN_MONTHS, P_COMMENCEMENT_DATE);

        DBMS_OUTPUT.PUT_LINE('Loan added successfully.');
    EXCEPTION
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
    END ADD_LOAN;
    
    PROCEDURE ADD_EMPLOYEE (
        P_EMPLOYEE_ID NUMBER,
        P_BRANCH_ID NUMBER,
        P_ROLE_ID NUMBER,
        P_FIRST_NAME EMPLOYEE.FIRST_NAME%TYPE,
        P_LAST_NAME EMPLOYEE.LAST_NAME%TYPE,
        P_DATE_OF_BIRTH EMPLOYEE.DATE_OF_BIRTH%TYPE,
        P_EMAIL_ID EMPLOYEE.EMAIL_ID%TYPE,
        P_PHONE_NUMBER EMPLOYEE.PHONE_NUMBER%TYPE,
        P_DATE_REGISTERED EMPLOYEE.DATE_REGISTERED%TYPE,
        P_LOGIN EMPLOYEE.LOGIN%TYPE,
        P_PASSWORD_HASH EMPLOYEE.PASSWORD_HASH%TYPE,
        P_ADDRESS EMPLOYEE.ADDRESS%TYPE,
        P_CITY EMPLOYEE.CITY%TYPE,
        P_STATE_NAME EMPLOYEE.STATE_NAME%TYPE,
        P_MANAGER_ID EMPLOYEE.MANAGER_ID%TYPE
    ) AS
        V_EXISTING_EMP_COUNT NUMBER;
        V_MANAGER_RECORD EMPLOYEE%ROWTYPE;
    BEGIN
        SELECT *
        INTO V_MANAGER_RECORD
        FROM EMPLOYEE
        WHERE EMPLOYEE_ID = P_EMPLOYEE_ID;

        IF V_MANAGER_RECORD.ROLE_ID = 2 AND V_MANAGER_RECORD.BRANCH_ID = P_BRANCH_ID THEN
          SELECT COUNT(*)
          INTO V_EXISTING_EMP_COUNT
          FROM EMPLOYEE
          WHERE EMAIL_ID = P_EMAIL_ID
            OR PHONE_NUMBER = P_PHONE_NUMBER;

          IF V_EXISTING_EMP_COUNT = 0 THEN
            INSERT INTO EMPLOYEE (
              BRANCH_ID, ROLE_ID, FIRST_NAME, LAST_NAME, DATE_OF_BIRTH, EMAIL_ID, PHONE_NUMBER,
              DATE_REGISTERED, LOGIN, PASSWORD_HASH, ADDRESS, CITY, STATE_NAME, MANAGER_ID
            ) VALUES (
              P_BRANCH_ID, P_ROLE_ID, P_FIRST_NAME, P_LAST_NAME, P_DATE_OF_BIRTH, P_EMAIL_ID, P_PHONE_NUMBER,
              P_DATE_REGISTERED, P_LOGIN, P_PASSWORD_HASH, P_ADDRESS, P_CITY, P_STATE_NAME, P_MANAGER_ID
            );
            DBMS_OUTPUT.PUT_LINE('Employee added successfully.');
          ELSE
            DBMS_OUTPUT.PUT_LINE('An employee with the same email address or phone number already exists.');
          END IF;
        ELSE
          DBMS_OUTPUT.PUT_LINE('You do not have the required permissions to add an employee in this branch.');
        END IF;
     END ADD_EMPLOYEE;
  
  PROCEDURE UPDATE_EMPLOYEE (
    P_EMPLOYEE_ID NUMBER,
    P_TARGET_EMPLOYEE_ID NUMBER,
    P_FIRST_NAME EMPLOYEE.FIRST_NAME%TYPE DEFAULT NULL,
    P_LAST_NAME EMPLOYEE.LAST_NAME%TYPE DEFAULT NULL,
    P_DATE_OF_BIRTH EMPLOYEE.DATE_OF_BIRTH%TYPE DEFAULT NULL,
    P_EMAIL_ID EMPLOYEE.EMAIL_ID%TYPE DEFAULT NULL,
    P_PHONE_NUMBER EMPLOYEE.PHONE_NUMBER%TYPE DEFAULT NULL,
    P_DATE_REGISTERED EMPLOYEE.DATE_REGISTERED%TYPE DEFAULT NULL,
    P_LOGIN EMPLOYEE.LOGIN%TYPE DEFAULT NULL,
    P_PASSWORD_HASH EMPLOYEE.PASSWORD_HASH%TYPE DEFAULT NULL,
    P_ADDRESS EMPLOYEE.ADDRESS%TYPE DEFAULT NULL,
    P_CITY EMPLOYEE.CITY%TYPE DEFAULT NULL,
    P_STATE_NAME EMPLOYEE.STATE_NAME%TYPE DEFAULT NULL,
    P_MANAGER_ID EMPLOYEE.MANAGER_ID%TYPE DEFAULT NULL
  ) AS
    V_MANAGER_RECORD EMPLOYEE%ROWTYPE;
    V_TARGET_EMP_BRANCH_ID NUMBER;
  BEGIN
    SELECT *
    INTO V_MANAGER_RECORD
    FROM EMPLOYEE
    WHERE EMPLOYEE_ID = P_EMPLOYEE_ID;

    SELECT BRANCH_ID
    INTO V_TARGET_EMP_BRANCH_ID
    FROM EMPLOYEE
    WHERE EMPLOYEE_ID = P_TARGET_EMPLOYEE_ID;

    IF V_MANAGER_RECORD.ROLE_ID = 2 AND V_MANAGER_RECORD.BRANCH_ID = V_TARGET_EMP_BRANCH_ID THEN
      UPDATE EMPLOYEE
      SET FIRST_NAME      = COALESCE(P_FIRST_NAME, FIRST_NAME),
          LAST_NAME       = COALESCE(P_LAST_NAME, LAST_NAME),
          DATE_OF_BIRTH   = COALESCE(P_DATE_OF_BIRTH, DATE_OF_BIRTH),
          EMAIL_ID        = COALESCE(P_EMAIL_ID, EMAIL_ID),
          PHONE_NUMBER    = COALESCE(P_PHONE_NUMBER, PHONE_NUMBER),
          DATE_REGISTERED = COALESCE(P_DATE_REGISTERED, DATE_REGISTERED),
          LOGIN           = COALESCE(P_LOGIN, LOGIN),
          PASSWORD_HASH   = COALESCE(P_PASSWORD_HASH, PASSWORD_HASH),
          ADDRESS         = COALESCE(P_ADDRESS, ADDRESS),
          CITY            = COALESCE(P_CITY, CITY),
          STATE_NAME      = COALESCE(P_STATE_NAME, STATE_NAME),
          MANAGER_ID      = COALESCE(P_MANAGER_ID, MANAGER_ID)
      WHERE EMPLOYEE_ID = P_TARGET_EMPLOYEE_ID;
      DBMS_OUTPUT.PUT_LINE('Employee updated successfully.');
    ELSE
      DBMS_OUTPUT.PUT_LINE('You do not have the required permissions to update an employee in this branch.');
    END IF;
  END UPDATE_EMPLOYEE;
  
  PROCEDURE DELETE_CUSTOMER_ACCOUNT (
        p_account_id ACCOUNTS.ACCOUNT_ID%TYPE,
        p_employee_id EMPLOYEE.EMPLOYEE_ID%TYPE
    ) IS
        v_account_count NUMBER;
        v_employee_branch NUMBER;
        v_account_branch NUMBER;
        account_exists EXCEPTION;
        unauthorized_branch EXCEPTION;
        account_not_found EXCEPTION;
        employee_not_found EXCEPTION;
    BEGIN

    -- Get the branch_id of the employee
        BEGIN
            SELECT BRANCH_ID
            INTO v_employee_branch
            FROM EMPLOYEE
            WHERE EMPLOYEE_ID = p_employee_id;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RAISE employee_not_found;
        END;
        
        BEGIN
            SELECT BRANCH_ID
            INTO v_account_branch
            FROM ACCOUNTS
            WHERE ACCOUNT_ID = p_account_id;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RAISE account_not_found;
        END;    

        BEGIN
            SELECT COUNT(*)
            INTO v_account_count
            FROM ACCOUNTS A
            JOIN BRANCH B ON A.BRANCH_ID = B.BRANCH_ID
            WHERE A.ACCOUNT_ID = p_account_id;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RAISE account_not_found;
        END;
      
        IF v_account_count = 0 THEN
            RAISE account_exists;
        ELSE
        -- Check if the account is from the same branch as the employee
            IF v_account_branch != v_employee_branch THEN
                RAISE unauthorized_branch;
            END IF;

            DELETE FROM transaction_table T WHERE T.ACCOUNT_ID = p_account_id;
        
            DELETE FROM accounts A WHERE A.ACCOUNT_ID = p_account_id;
            
            DBMS_OUTPUT.PUT_LINE('Customer Account deleted successfully.');
        
        END IF;

        EXCEPTION
            WHEN account_exists THEN
                RAISE_APPLICATION_ERROR(-20002, 'An account with the customer ID does not exist.');
            WHEN unauthorized_branch THEN
                RAISE_APPLICATION_ERROR(-20003, 'The employee does not have the authority to delete an account from a different branch.');
            WHEN account_not_found THEN
                RAISE_APPLICATION_ERROR(-20019, 'Account ID does not exist.');
            WHEN employee_not_found THEN
                RAISE_APPLICATION_ERROR(-20029, 'Employee ID does not exist.');    
    END DELETE_CUSTOMER_ACCOUNT;

    PROCEDURE DELETE_EMPLOYEE (
        p_manager_id  IN EMPLOYEE.EMPLOYEE_ID%TYPE,
        p_employee_id IN EMPLOYEE.EMPLOYEE_ID%TYPE
    ) IS
        v_manager_branch NUMBER;
        v_employee_branch NUMBER;
        manager_not_found EXCEPTION;
        employee_not_found EXCEPTION;
        different_branch EXCEPTION;
    BEGIN
        BEGIN
            SELECT BRANCH_ID
            INTO v_manager_branch
            FROM EMPLOYEE
            WHERE EMPLOYEE_ID = p_manager_id;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RAISE manager_not_found;
        END;

        BEGIN
            SELECT BRANCH_ID
            INTO v_employee_branch
            FROM EMPLOYEE
            WHERE EMPLOYEE_ID = p_employee_id;
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                RAISE employee_not_found;
        END;

        IF v_manager_branch != v_employee_branch THEN
            RAISE different_branch;
        END IF;

        DELETE FROM EMPLOYEE WHERE EMPLOYEE_ID = p_employee_id;
        
        DBMS_OUTPUT.PUT_LINE('Employee deleted successfully.');

    EXCEPTION
        WHEN employee_not_found THEN
            RAISE_APPLICATION_ERROR(-20002, 'No employee found the provided employee_id');
        WHEN manager_not_found THEN
            RAISE_APPLICATION_ERROR(-20002, 'No manager exists with the provided Employee_id.');
        WHEN different_branch THEN
            RAISE_APPLICATION_ERROR(-20003, 'The manager and employee are from different branches.');
    END DELETE_EMPLOYEE;
    
END MANAGER_PKG;
/
-----------------------------------------------------------------------------------------------------------------
-- Package Specification
CREATE OR REPLACE PACKAGE CUSTOMER_PKG AS
  PROCEDURE view_customer_info(p_customer_id NUMBER);
  PROCEDURE view_accounts(p_customer_id NUMBER);
  PROCEDURE view_transactions(p_customer_id NUMBER);
  PROCEDURE view_loans(p_customer_id NUMBER);
  PROCEDURE view_transactions_by_account_id_only(p_account_id NUMBER);
  PROCEDURE view_latest_5_transactions(p_account_id NUMBER);
  PROCEDURE view_last_transaction(p_account_id NUMBER);
  PROCEDURE view_customer_latest_5_transactions(p_customer_id NUMBER);
  PROCEDURE view_customer_last_transaction(p_customer_id NUMBER);
END CUSTOMER_PKG;
/

-- Package Body
CREATE OR REPLACE PACKAGE BODY CUSTOMER_PKG AS

  PROCEDURE view_customer_info(p_customer_id NUMBER) IS
    CURSOR customer_info IS
      SELECT *
      FROM CUSTOMER
      WHERE CUSTOMER_ID = p_customer_id;
    v_customer_info customer_info%ROWTYPE;
  BEGIN
    OPEN customer_info;
    FETCH customer_info INTO v_customer_info;
    CLOSE customer_info;

    DBMS_OUTPUT.PUT_LINE('Customer ID: ' || v_customer_info.CUSTOMER_ID || ', First Name: ' || v_customer_info.FIRST_NAME || ', Last Name: ' || v_customer_info.LAST_NAME || ', Date of Birth: ' || v_customer_info.DATE_OF_BIRTH || ', Email ID: ' || v_customer_info.EMAIL_ID || ', Phone Number: ' || v_customer_info.PHONE_NUMBER || ', Date Registered: ' || v_customer_info.DATE_REGISTERED || ', Annual Income: ' || v_customer_info.ANNUAL_INCOME || ', Login: ' || v_customer_info.LOGIN || ', Password Hash: ' || v_customer_info.PASSWORD_HASH || ', Address: ' || v_customer_info.ADDRESS || ', City: ' || v_customer_info.CITY || ', State Name: ' || v_customer_info.STATE_NAME);
  END view_customer_info;

  PROCEDURE view_accounts(p_customer_id NUMBER) IS
    CURSOR customer_accounts IS
      SELECT *
      FROM ACCOUNTS
      WHERE CUSTOMER_ID = p_customer_id;
    v_customer_accounts customer_accounts%ROWTYPE;
  BEGIN
    OPEN customer_accounts;
    LOOP
      FETCH customer_accounts INTO v_customer_accounts;
      EXIT WHEN customer_accounts%NOTFOUND;

      DBMS_OUTPUT.PUT_LINE('Account ID: ' || v_customer_accounts.ACCOUNT_ID || ', Customer ID: ' || v_customer_accounts.CUSTOMER_ID || ', Account Type: ' || v_customer_accounts.ACCOUNT_TYPE || ', Branch ID: ' || v_customer_accounts.BRANCH_ID || ', Created Date: ' || v_customer_accounts.CREATED_DATE || ', Balance: ' || v_customer_accounts.BALANCE || ', Card Details: ' || v_customer_accounts.CARD_DETAILS || ', Proof: ' || v_customer_accounts.PROOF);
    END LOOP;
    CLOSE customer_accounts;
  END view_accounts;

  PROCEDURE view_transactions(p_customer_id NUMBER) IS
    CURSOR customer_transactions IS
      SELECT t.*
      FROM TRANSACTION_TABLE t
      JOIN ACCOUNTS a ON t.ACCOUNT_ID = a.ACCOUNT_ID
      WHERE a.CUSTOMER_ID = p_customer_id;
    v_customer_transactions customer_transactions%ROWTYPE;
  BEGIN
    OPEN customer_transactions;
    LOOP
      FETCH customer_transactions INTO v_customer_transactions;
      EXIT WHEN customer_transactions%NOTFOUND;

      DBMS_OUTPUT.PUT_LINE('Transaction ID: ' || v_customer_transactions.TRANSACTION_ID || ', Account ID: ' || v_customer_transactions.ACCOUNT_ID || ', Status Code: ' || v_customer_transactions.STATUS_CODE || ', Transaction Type: ' || v_customer_transactions.TRANSACTION_TYPE || ', Amount: ' || v_customer_transactions.AMOUNT || ', Time Stamp: ' || v_customer_transactions.TIME_STAMP || ', Transaction Details: ' || v_customer_transactions.TRANSACTION_DETAILS || ', Status: ' || v_customer_transactions.STATUS);
    END LOOP;
    CLOSE customer_transactions;
  END view_transactions;

  PROCEDURE view_loans(p_customer_id NUMBER) IS
    CURSOR customer_loans IS
      SELECT *
      FROM LOAN
      WHERE CUSTOMER_ID = p_customer_id;
    v_customer_loans customer_loans%ROWTYPE;
  BEGIN
    OPEN customer_loans;
    LOOP
      FETCH customer_loans INTO v_customer_loans;
      EXIT WHEN customer_loans%NOTFOUND;

      DBMS_OUTPUT.PUT_LINE('Loan ID: ' || v_customer_loans.LOAN_ID || ', Customer ID: ' || v_customer_loans.CUSTOMER_ID || ', Loan Type: ' || v_customer_loans.LOAN_TYPE || ', Branch ID: ' || v_customer_loans.BRANCH_ID || ', Amount: ' || v_customer_loans.AMOUNT || ', Interest Rate: ' || v_customer_loans.INTEREST_RATE || ', Term in Months: ' || v_customer_loans.TERM_IN_MONTHS || ', Commencement Date: ' || v_customer_loans.COMMENCEMENT_DATE);
    END LOOP;
    CLOSE customer_loans;
  END view_loans;

  PROCEDURE view_transactions_by_account_id(p_customer_id NUMBER, p_account_id NUMBER) IS
    CURSOR customer_transactions_by_account IS
      SELECT t.*
      FROM TRANSACTION_TABLE t
      JOIN ACCOUNTS a ON t.ACCOUNT_ID = a.ACCOUNT_ID
      WHERE a.CUSTOMER_ID = p_customer_id AND a.ACCOUNT_ID = p_account_id;
    v_customer_transactions_by_account customer_transactions_by_account%ROWTYPE;
  BEGIN
    OPEN customer_transactions_by_account;
    LOOP
      FETCH customer_transactions_by_account INTO v_customer_transactions_by_account;
      EXIT WHEN customer_transactions_by_account%NOTFOUND;

      DBMS_OUTPUT.PUT_LINE('Transaction ID: ' || v_customer_transactions_by_account.TRANSACTION_ID || ', Account ID: ' || v_customer_transactions_by_account.ACCOUNT_ID || ', Status Code: ' || v_customer_transactions_by_account.STATUS_CODE || ', Transaction Type: ' || v_customer_transactions_by_account.TRANSACTION_TYPE || ', Amount: ' || v_customer_transactions_by_account.AMOUNT || ', Time Stamp: ' || v_customer_transactions_by_account.TIME_STAMP || ', Transaction Details: ' || v_customer_transactions_by_account.TRANSACTION_DETAILS || ', Status: ' || v_customer_transactions_by_account.STATUS);
    END LOOP;
    CLOSE customer_transactions_by_account;
  END view_transactions_by_account_id;
  
  PROCEDURE view_transactions_by_account_id_only(p_account_id NUMBER) IS
    CURSOR account_transactions IS
      SELECT *
      FROM TRANSACTION_TABLE
      WHERE ACCOUNT_ID = p_account_id;
    v_account_transactions account_transactions%ROWTYPE;
  BEGIN
    OPEN account_transactions;
    LOOP
      FETCH account_transactions INTO v_account_transactions;
      EXIT WHEN account_transactions%NOTFOUND;

      DBMS_OUTPUT.PUT_LINE('Transaction ID: ' || v_account_transactions.TRANSACTION_ID || ', Account ID: ' || v_account_transactions.ACCOUNT_ID || ', Status Code: ' || v_account_transactions.STATUS_CODE || ', Transaction Type: ' || v_account_transactions.TRANSACTION_TYPE || ', Amount: ' || v_account_transactions.AMOUNT || ', Time Stamp: ' || v_account_transactions.TIME_STAMP || ', Transaction Details: ' || v_account_transactions.TRANSACTION_DETAILS || ', Status: ' || v_account_transactions.STATUS);
    END LOOP;
    CLOSE account_transactions;
  END view_transactions_by_account_id_only;

  PROCEDURE view_latest_5_transactions(p_account_id NUMBER) IS
    CURSOR latest_5_transactions IS
      SELECT *
      FROM (
        SELECT *
        FROM TRANSACTION_TABLE
        WHERE ACCOUNT_ID = p_account_id
        ORDER BY TIME_STAMP DESC
      )
      WHERE ROWNUM <= 5;
    v_latest_5_transactions latest_5_transactions%ROWTYPE;
  BEGIN
    OPEN latest_5_transactions;
    LOOP
      FETCH latest_5_transactions INTO v_latest_5_transactions;
      EXIT WHEN latest_5_transactions%NOTFOUND;

      DBMS_OUTPUT.PUT_LINE('Transaction ID: ' || v_latest_5_transactions.TRANSACTION_ID || ', Account ID: ' || v_latest_5_transactions.ACCOUNT_ID || ', Status Code: ' || v_latest_5_transactions.STATUS_CODE || ', Transaction Type: ' || v_latest_5_transactions.TRANSACTION_TYPE || ', Amount: ' || v_latest_5_transactions.AMOUNT || ', Time Stamp: ' || v_latest_5_transactions.TIME_STAMP || ', Transaction Details: ' || v_latest_5_transactions.TRANSACTION_DETAILS || ', Status: ' || v_latest_5_transactions.STATUS);
    END LOOP;
    CLOSE latest_5_transactions;
  END view_latest_5_transactions;

  PROCEDURE view_last_transaction(p_account_id NUMBER) IS
    CURSOR last_transaction IS
      SELECT *
      FROM (
        SELECT *
        FROM TRANSACTION_TABLE
        WHERE ACCOUNT_ID = p_account_id
        ORDER BY TIME_STAMP DESC
      )
      WHERE ROWNUM = 1;
    v_last_transaction last_transaction%ROWTYPE;
  BEGIN
    OPEN last_transaction;
    FETCH last_transaction INTO v_last_transaction;
    CLOSE last_transaction;

    DBMS_OUTPUT.PUT_LINE('Transaction ID: ' || v_last_transaction.TRANSACTION_ID || ', Account ID: ' || v_last_transaction.ACCOUNT_ID || ', Status Code: ' || v_last_transaction.STATUS_CODE || ', Transaction Type: ' || v_last_transaction.TRANSACTION_TYPE || ', Amount: ' || v_last_transaction.AMOUNT || ', Time Stamp: ' || v_last_transaction.TIME_STAMP || ', Transaction Details: ' || v_last_transaction.TRANSACTION_DETAILS || ', Status: ' || v_last_transaction.STATUS);
  END view_last_transaction;
  
  PROCEDURE view_customer_latest_5_transactions(p_customer_id NUMBER) IS
    CURSOR latest_5_transactions IS
      SELECT tt.*
      FROM (
        SELECT tt.*
        FROM TRANSACTION_TABLE tt
        JOIN ACCOUNTS a ON tt.ACCOUNT_ID = a.ACCOUNT_ID
        WHERE a.CUSTOMER_ID = p_customer_id
        ORDER BY tt.TIME_STAMP DESC
      ) tt
      WHERE ROWNUM <= 5;
    v_latest_5_transactions latest_5_transactions%ROWTYPE;
  BEGIN
    OPEN latest_5_transactions;
    LOOP
      FETCH latest_5_transactions INTO v_latest_5_transactions;
      EXIT WHEN latest_5_transactions%NOTFOUND;

      DBMS_OUTPUT.PUT_LINE('Transaction ID: ' || v_latest_5_transactions.TRANSACTION_ID || ', Account ID: ' || v_latest_5_transactions.ACCOUNT_ID || ', Status Code: ' || v_latest_5_transactions.STATUS_CODE || ', Transaction Type: ' || v_latest_5_transactions.TRANSACTION_TYPE || ', Amount: ' || v_latest_5_transactions.AMOUNT || ', Time Stamp: ' || v_latest_5_transactions.TIME_STAMP || ', Transaction Details: ' || v_latest_5_transactions.TRANSACTION_DETAILS || ', Status: ' || v_latest_5_transactions.STATUS);
    END LOOP;
    CLOSE latest_5_transactions;
  END view_customer_latest_5_transactions;

  PROCEDURE view_customer_last_transaction(p_customer_id NUMBER) IS
    CURSOR last_transaction IS
      SELECT tt.*
      FROM (
        SELECT tt.*
        FROM TRANSACTION_TABLE tt
        JOIN ACCOUNTS a ON tt.ACCOUNT_ID = a.ACCOUNT_ID
        WHERE a.CUSTOMER_ID = p_customer_id
        ORDER BY tt.TIME_STAMP DESC
      ) tt
      WHERE ROWNUM = 1;
    v_last_transaction last_transaction%ROWTYPE;
  BEGIN
    OPEN last_transaction;
    FETCH last_transaction INTO v_last_transaction;
    CLOSE last_transaction;

    DBMS_OUTPUT.PUT_LINE('Transaction ID: ' || v_last_transaction.TRANSACTION_ID || ', Account ID: ' || v_last_transaction.ACCOUNT_ID || ', Status Code: ' || v_last_transaction.STATUS_CODE || ', Transaction Type: ' || v_last_transaction.TRANSACTION_TYPE || ', Amount: ' || v_last_transaction.AMOUNT || ', Time Stamp: ' || v_last_transaction.TIME_STAMP || ', Transaction Details: ' || v_last_transaction.TRANSACTION_DETAILS || ', Status: ' || v_last_transaction.STATUS);
  END view_customer_last_transaction;

END CUSTOMER_PKG;
/
---------------------------------------------------------------------------------------------------------------------------------
GRANT EXECUTE ON EMPLOYEE_PKG TO employee_user;

GRANT EXECUTE ON MANAGER_PKG TO manager_user;

GRANT EXECUTE ON CUSTOMER_PKG TO customer_user;
---------------------------------------------------------------------------------------------------------------------------------

--VIEWS

---------------------------------------------------------------------------------------------------------------------------------
--V_AGG_HOURLY_TRANSACTIONS_BY_TYPE: Fetch the aggregate of the
--transactions started within the last hour from the 9PM of 16th March 2023 across all the accounts.
--The returned set should be grouped by their type
--CREATE VIEW V_AGG_HOURLY_TRANSACTIONS_BY_TYPE AS
CREATE OR REPLACE VIEW V_AGG_HOURLY_TRANSACTIONS_BY_TYPE_16th_March AS
    SELECT ty.transaction_type, COUNT(tr.transaction_id) AS num_transactions, SUM(tr.amount) AS total_amount
    FROM transaction_table tr
             JOIN transaction_type ty ON tr.transaction_type = ty.transaction_type_id
    WHERE TRUNC(tr.time_stamp, 'HH24') = TO_DATE('16-MAR-2023 21:00:00', 'DD-MON-YYYY HH24:MI:SS') - INTERVAL '1' HOUR
      AND tr.Status != 'Failed'
    GROUP BY ty.transaction_type
    ORDER BY ty.transaction_type;

--V_AGG_HOURLY_TRANSACTIONS_BY_TYPE: Fetch the aggregate of the
--transactions started within the last hour from the current timestamp across all the accounts.
--The returned set should be grouped by their type
--CREATE VIEW V_AGG_HOURLY_TRANSACTIONS_BY_TYPE AS
CREATE OR REPLACE VIEW V_AGG_HOURLY_TRANSACTIONS_BY_TYPE AS
SELECT ty.transaction_type, COUNT(tr.transaction_id) AS num_transactions, SUM(tr.amount) AS total_amount
FROM transaction_table tr
         JOIN transaction_type ty ON tr.transaction_type = ty.transaction_type_id
WHERE Tr.time_stamp BETWEEN SYSDATE - INTERVAL '1' HOUR AND SYSDATE - INTERVAL '1' SECOND
  AND Tr.Status != 'Failed'
GROUP BY ty.transaction_type
ORDER BY ty.transaction_type;

--V_HOURLY_FAILED_TRANSACTION: Fetches all the transactions started in the last
--hour  9PM of 16th March 2023 , which is in a "failure” status.
CREATE OR REPLACE VIEW V_HOURLY_FAILED_TRANSACTION_16th_March AS
    SELECT ty.transaction_type, COUNT(tr.transaction_id) AS num_transactions, SUM(tr.amount) AS total_amount
    FROM transaction_table tr
             JOIN transaction_type ty ON tr.transaction_type = ty.transaction_type_id
    WHERE TRUNC(tr.time_stamp, 'HH24') = TO_DATE('16-MAR-2023 21:00:00', 'DD-MON-YYYY HH24:MI:SS') - INTERVAL '1' HOUR
      AND tr.Status = 'Failed'
    GROUP BY ty.transaction_type
    ORDER BY ty.transaction_type;

--V_HOURLY_FAILED_TRANSACTION: Fetches all the transactions started in the last
--hour  from the current timestamp , which is in a "failure” status.
--CREATE VIEW V_HOURLY_FAILED_TRANSACTION AS
CREATE OR REPLACE VIEW V_HOURLY_FAILED_TRANSACTION AS
    SELECT ty.transaction_type, COUNT(tr.transaction_id) AS num_transactions, SUM(tr.amount) AS total_amount
    FROM transaction_table tr
             JOIN transaction_type ty ON tr.transaction_type = ty.transaction_type_id
    WHERE Tr.time_stamp BETWEEN SYSDATE - INTERVAL '1' HOUR AND SYSDATE - INTERVAL '1' SECOND
      AND Tr.Status = 'Failed'
    GROUP BY ty.transaction_type
    ORDER BY ty.transaction_type;

--V_AGG_DAILY_TRANSACTIONS_BY_TYPE: Fetch the aggregate of the transactions
--started within the last day from 16th March 2023 across all the accounts. The returned
--set should be grouped by their type
CREATE OR REPLACE VIEW V_AGG_DAILY_TRANSACTIONS_BY_TYPE_15th_March AS
    SELECT tr.transaction_type, COUNT(T.transaction_id) AS num_transactions, SUM(T.amount) as total_amount
    FROM transaction_table T
             JOIN transaction_type tr ON T.transaction_type = tr.transaction_type_id
             JOIN accounts A ON T.account_id = A.account_id
    WHERE TRUNC(T.time_stamp) = TRUNC(TO_DATE('16-MAR-2023', 'DD-MON-YYYY')) - 1
      AND T.Status != 'Failed'
    GROUP BY tr.transaction_type
    ORDER BY tr.transaction_type;

--V_AGG_DAILY_TRANSACTIONS_BY_TYPE: Fetch the aggregate of the transactions
--started within the last day from current date across all the accounts. The returned
--set should be grouped by their type
CREATE OR REPLACE VIEW V_AGG_DAILY_TRANSACTIONS_BY_TYPE As
    SELECT tr.transaction_type, COUNT(T.transaction_id) AS num_transactions, SUM(T.amount) as total_amount
    FROM transaction_table T
             JOIN transaction_type tr ON T.transaction_type = tr.transaction_type_id
             JOIN accounts A ON T.account_id = A.account_id
    WHERE TRUNC(T.time_stamp) = TRUNC(SYSDATE) - 1
      AND T.Status != 'Failed'
    GROUP BY tr.transaction_type
    ORDER BY tr.transaction_type;

--V_DAILY_FAILED_TRANSACTIONS: Fetches all the transactions started in the last
--day from 16th March 2023, which is in a "failure” status.
CREATE OR REPLACE VIEW V_DAILY_FAILED_TRANSACTIONS_15th_March AS
    SELECT tr.transaction_type, COUNT(T.transaction_id) AS num_transactions, SUM(T.amount) as total_amount
    FROM transaction_table T
             JOIN transaction_type tr ON T.transaction_type = tr.transaction_type_id
             JOIN accounts A ON T.account_id = A.account_id
    WHERE TRUNC(T.time_stamp) = TRUNC(TO_DATE('16-MAR-2023', 'DD-MON-YYYY')) - 1
      AND T.Status = 'Failed'
    GROUP BY tr.transaction_type
    ORDER BY tr.transaction_type;

--V_DAILY_FAILED_TRANSACTIONS: Fetches all the transactions started in the last
--day from current date, which is in a "failure” status.
CREATE OR REPLACE VIEW V_DAILY_FAILED_TRANSACTIONS AS
    SELECT tr.transaction_type, COUNT(T.transaction_id) AS num_transactions, SUM(T.amount) as total_amount
    FROM transaction_table T
             JOIN transaction_type tr ON T.transaction_type = tr.transaction_type_id
             JOIN accounts A ON T.account_id = A.account_id
    WHERE TRUNC(T.time_stamp) = TRUNC(SYSDATE) - 1
      AND T.Status = 'Failed'
    GROUP BY tr.transaction_type
    ORDER BY tr.transaction_type;

--V_AGG_DAILY_TRANSACTIONS_BY_BRANCH: Fetch the aggregate of the
--transactions started within the last day from 16th March 2023 across all the accounts.
--The returned set should be grouped by the branch from where the transactions originated
--from.
CREATE OR REPLACE VIEW V_AGG_DAILY_TRANSACTIONS_BY_BRANCH_15th_March AS
    SELECT B.branch_name,
           tr.transaction_type,
           COUNT(T.transaction_id) AS num_transactions,
           SUM(T.amount)           as total_amount
    FROM transaction_table T
             JOIN transaction_type tr ON T.transaction_type = tr.transaction_type_id
             JOIN accounts A ON T.account_id = A.account_id
             JOIN branch B ON A.branch_id = B.branch_id
    WHERE TRUNC(T.time_stamp) = TRUNC(TO_DATE('16-MAR-2023', 'DD-MON-YYYY')) - 1
      AND T.Status != 'Failed'
    GROUP BY B.branch_name, tr.transaction_type
    ORDER BY B.branch_name, tr.transaction_type;

--V_AGG_DAILY_TRANSACTIONS_BY_BRANCH: Fetch the aggregate of the
--transactions started within the last day from current date across all the accounts.
--The returned set should be grouped by the branch from where the transactions originated
--from.
CREATE OR REPLACE VIEW V_AGG_DAILY_TRANSACTIONS_BY_BRANCH AS
    SELECT B.branch_name,
           tr.transaction_type,
           COUNT(T.transaction_id) AS num_transactions,
           SUM(T.amount)           as total_amount
    FROM transaction_table T
             JOIN transaction_type tr ON T.transaction_type = tr.transaction_type_id
             JOIN accounts A ON T.account_id = A.account_id
             JOIN branch B ON A.branch_id = B.branch_id
    WHERE TRUNC(T.time_stamp) = TRUNC(SYSDATE) - 1
      AND T.Status != 'Failed'
    GROUP BY B.branch_name, tr.transaction_type
    ORDER BY B.branch_name, tr.transaction_type;

--V_AGG_DAILY_FAILED_TRANSACTIONS_BY_BRANCH: Fetch the aggregate of the
--transactions started within the last day from 16th March 2023 across all the accounts.
--The returned set should be grouped by the branch from where the transactions originated
--from.
CREATE OR REPLACE VIEW V_AGG_DAILY_FAILED_TRANSACTIONS_BY_BRANCH_15th_March AS
    SELECT B.branch_name,
           tr.transaction_type,
           COUNT(T.transaction_id) AS num_transactions,
           SUM(T.amount)           as total_amount
    FROM transaction_table T
             JOIN transaction_type tr ON T.transaction_type = tr.transaction_type_id
             JOIN accounts A ON T.account_id = A.account_id
             JOIN branch B ON A.branch_id = B.branch_id
    WHERE TRUNC(T.time_stamp) = TRUNC(TO_DATE('16-MAR-2023', 'DD-MON-YYYY')) - 1
      AND T.Status = 'Failed'
    GROUP BY B.branch_name, tr.transaction_type
    ORDER BY B.branch_name, tr.transaction_type;

--V_AGG_DAILY_FAILED_TRANSACTIONS_BY_BRANCH: Fetch the aggregate of the
--transactions started within the last day from current date across all the accounts.
--The returned set should be grouped by the branch from where the transactions originated
--from.
CREATE OR REPLACE VIEW V_AGG_DAILY_FAILED_TRANSACTIONS_BY_BRANCH AS
    SELECT B.branch_name,
           tr.transaction_type,
           COUNT(T.transaction_id) AS num_transactions,
           SUM(T.amount)           as total_amount
    FROM transaction_table T
             JOIN transaction_type tr ON T.transaction_type = tr.transaction_type_id
             JOIN accounts A ON T.account_id = A.account_id
             JOIN branch B ON A.branch_id = B.branch_id
    WHERE TRUNC(T.time_stamp) = TRUNC(SYSDATE) - 1
      AND T.Status = 'Failed'
    GROUP BY B.branch_name, tr.transaction_type
    ORDER BY B.branch_name, tr.transaction_type;

--V_AGG_HOURLY_TRANSACTIONS_BY_BRANCH: Fetch the aggregate of the
--transactions started within the last hour from 9PM of 16th March 2023 across all the accounts.
--The returned set should be grouped by the branch from where the transactions originated
--from.
CREATE OR REPLACE VIEW V_AGG_HOURLY_TRANSACTIONS_BY_BRANCH_16th_March AS
    SELECT B.branch_name,
           tr.transaction_type,
           COUNT(T.transaction_id) AS num_transactions,
           SUM(T.amount)           as total_amount
    FROM transaction_table T
             JOIN transaction_type tr ON T.transaction_type = tr.transaction_type_id
             JOIN accounts A ON T.account_id = A.account_id
             JOIN branch B ON A.branch_id = B.branch_id
    WHERE TRUNC(T.time_stamp, 'HH24') = TO_DATE('16-MAR-2023 21:00:00', 'DD-MON-YYYY HH24:MI:SS') - INTERVAL '1' HOUR
      AND T.Status != 'Failed'
    GROUP BY B.branch_name, tr.transaction_type
    ORDER BY B.branch_name, tr.transaction_type;

--V_AGG_HOURLY_TRANSACTIONS_BY_BRANCH: Fetch the aggregate of the
--transactions started within the last hour from current timestamp across all the accounts.
--The returned set should be grouped by the branch from where the transactions originated
--from.
CREATE OR REPLACE VIEW V_AGG_HOURLY_TRANSACTIONS_BY_BRANCH AS
    SELECT B.branch_name,
           tr.transaction_type,
           COUNT(T.transaction_id) AS num_transactions,
           SUM(T.amount)           as total_amount
    FROM transaction_table T
             JOIN transaction_type tr ON T.transaction_type = tr.transaction_type_id
             JOIN accounts A ON T.account_id = A.account_id
             JOIN branch B ON A.branch_id = B.branch_id
    WHERE T.time_stamp BETWEEN SYSDATE - INTERVAL '1' HOUR AND SYSDATE - INTERVAL '1' SECOND
      AND T.Status != 'Failed'
    GROUP BY B.branch_name, tr.transaction_type
    ORDER BY B.branch_name, tr.transaction_type;

--V_AGG_HOURLY_FAILED_TRANSACTIONS_BY_BRANCH: Fetch the aggregate of the
--transactions started within the last hour from  9PM of 16th March 2023 across all the accounts.
--The returned set should be grouped by the branch from where the transactions originated
--from.
CREATE OR REPLACE VIEW V_AGG_HOURLY_FAILED_TRANSACTIONS_BY_BRANCH_16th_March AS
    SELECT B.branch_name,
           tr.transaction_type,
           COUNT(T.transaction_id) AS num_transactions,
           SUM(T.amount)           AS total_amount
    FROM transaction_table T
             JOIN transaction_type tr ON T.transaction_type = tr.transaction_type_id
             JOIN accounts A ON T.account_id = A.account_id
             JOIN branch B ON A.branch_id = B.branch_id
    WHERE TRUNC(T.time_stamp, 'HH24') = TO_DATE('16-MAR-2023 21:00:00', 'DD-MON-YYYY HH24:MI:SS') - INTERVAL '1' HOUR
      AND T.Status = 'Failed'
    GROUP BY B.branch_name, tr.transaction_type
    ORDER BY B.branch_name, tr.transaction_type;

--V_AGG_HOURLY_FAILED_TRANSACTIONS_BY_BRANCH: Fetch the aggregate of the
--transactions started within the last hour from  current timestamp across all the accounts.
--The returned set should be grouped by the branch from where the transactions originated
--from.
CREATE OR REPLACE VIEW V_AGG_HOURLY_FAILED_TRANSACTIONS_BY_BRANCH AS
    SELECT B.branch_name,
           tr.transaction_type,
           COUNT(T.transaction_id) AS num_transactions,
           SUM(T.amount)           AS total_amount
    FROM transaction_table T
             JOIN transaction_type tr ON T.transaction_type = tr.transaction_type_id
             JOIN accounts A ON T.account_id = A.account_id
             JOIN branch B ON A.branch_id = B.branch_id
    WHERE T.time_stamp BETWEEN SYSDATE - INTERVAL '1' HOUR AND SYSDATE - INTERVAL '1' SECOND
      AND T.Status = 'Failed'
    GROUP BY B.branch_name, tr.transaction_type
    ORDER BY B.branch_name, tr.transaction_type;

--V_CUSTOMER_ACCOUNT_BALANCES: Fetches all customer information with their
--account balances and account types, grouped by customer.
--CREATE VIEW V_CUSTOMER_ACCOUNT_BALANCES AS
CREATE OR REPLACE VIEW V_CUSTOMER_ACCOUNT_BALANCES AS
    SELECT c.customer_id, c.first_name, c.last_name, t.account_type, SUM(a.balance) AS total_balance
    FROM customer c
             JOIN accounts a ON c.customer_id = a.customer_id
             JOIN account_type t ON a.account_type = t.account_type_id
    GROUP BY c.customer_id, c.first_name, c.last_name, a.account_type, t.account_type
    ORDER BY c.customer_id, c.first_name, c.last_name;

--V_ACCOUNTS_BRANCH_INFO: Fetches all accounts with their branch information
--including branch name and branch code, grouped by account.
--CREATE VIEW V_ACCOUNTS_BRANCH_INFO AS
CREATE OR REPLACE VIEW V_ACCOUNTS_BRANCH_INFO AS
    SELECT a.account_id,
           a.customer_id,
           c.first_name ||' '|| c.last_name as customer_name,
           t.account_type,
           a.balance,
           b.branch_name,
           b.branch_code
    FROM accounts a
             JOIN branch b ON a.branch_id = b.branch_id
             JOIN customer c ON a.customer_id = c.customer_id
             JOIN account_type t ON a.account_type = t.account_type_id
    GROUP BY a.account_id, a.customer_id, c.first_name, c.last_name, t.account_type, a.balance, b.branch_name, b.branch_code
    ORDER BY a.account_id, a.customer_id;

--V_TRANSACTION_DETAILS: Fetches all transaction information with details including
--transaction ID, customer account number, transaction amount, account type, and
--transaction type, grouped by customer.
CREATE OR REPLACE VIEW V_TRANSACTION_DETAILS AS
SELECT t.transaction_id, t.account_id, a.customer_id, c.first_name || ' ' || c.last_name AS customer_name, t.amount, ty.account_type, t.time_stamp, tr.transaction_type, t.status
FROM transaction_table t
JOIN accounts a ON t.account_id = a.account_id
JOIN account_type ty ON a.account_type = ty.account_type_id
JOIN transaction_type tr ON t.transaction_type = tr.transaction_type_id
JOIN customer c on a.customer_id = c.customer_id
GROUP BY a.customer_id, t.account_id, t.transaction_id, c.first_name || ' ' || c.last_name, t.amount, ty.account_type, t.time_stamp, tr.transaction_type, t.status
ORDER BY t.transaction_id;

--V_LOANS_CUSTOMER_INFO: Fetches all loans with customer email, address, and
--customer information including customer name, branch name, branch code, and loan type
--descriptions, grouped by customer.
CREATE OR REPLACE VIEW V_LOANS_CUSTOMER_INFO AS
SELECT l.loan_id, c.first_name || ' ' || c.last_name AS customer_name, c.email_id, c.address,  b.branch_name, b.branch_code, lt.loan_type_id as loan_type, lt.loan_description AS loan_type_description
FROM loan l
JOIN customer c ON l.customer_id = c.customer_id
JOIN accounts a ON c.customer_id = a.customer_id
JOIN branch b ON a.branch_id = b.branch_id
JOIN loan_type lt ON l.loan_type = lt.loan_type_id
GROUP BY l.loan_id, c.email_id, c.address, c.first_name || ' ' || c.last_name, b.branch_name, b.branch_code, lt.loan_type_id, lt.loan_description
ORDER BY l.loan_id, c.email_id;

--V_EMPLOYEE_POSITION_INFO: Fetches all employees with their position
--information, branch name, and manager name, as well as associated manager's email
--address and phone number, grouped by employee.
CREATE OR REPLACE VIEW V_EMPLOYEE_POSITION_INFO AS
SELECT e.employee_id, e.first_name || ' ' || e.last_name AS employee_name, e.email_id, e.phone_number, r.position_name, b.branch_name, m.first_name || ' ' || m.last_name AS manager_name, m.email_id AS manager_email, m.phone_number AS manager_phone
FROM employee e
JOIN role_table r ON e.role_id = r.role_id
JOIN branch b ON e.branch_id = b.branch_id
LEFT JOIN employee m ON e.manager_id = m.employee_id
GROUP BY e.employee_id, e.first_name, e.last_name, e.email_id, e.phone_number, r.position_name, b.branch_name, m.first_name, m.last_name, m.email_id, m.phone_number
ORDER BY e.employee_id, e.first_name;   

--V OVERDRAFT_ACCOUNTS: Fetch all the accounts that are currently in overdraft status.
CREATE OR REPLACE VIEW V_OVERDRAFT_ACCOUNTS AS
SELECT a.account_id, c.customer_id, c.first_name || ' ' || c.last_name AS customer_name, a.balance FROM accounts a
JOIN customer c on c.customer_id=a.customer_id
WHERE balance < 0;

--V_AGG_OVERDRAFT_ACCOUNTS_BY_BRANCH: Fetch the aggregate of all
--accounts that are in overdraft status grouped by the branch.
CREATE OR REPLACE VIEW V_AGG_OVERDRAFT_ACCOUNTS_BY_BRANCH AS
SELECT b.branch_id, b.branch_name, COUNT(a.account_id) AS num_overdraft_accounts, SUM(a.balance) AS total_overdraft_balance
FROM accounts a
JOIN branch b ON a.branch_id = b.branch_id
WHERE a.balance < 0
GROUP BY b.branch_id, b.branch_name;

---------------------------------------------------------------------------------------------------------------------------------

COMMIT;

--Display created tables
SELECT * FROM CUSTOMER;

SELECT * FROM BRANCH;

SELECT * FROM LOAN_TYPE;

SELECT * FROM LOAN;

SELECT * FROM ACCOUNT_TYPE;

SELECT * FROM ACCOUNTS;

SELECT * FROM ROLE_TABLE;

SELECT * FROM EMPLOYEE;

SELECT * FROM STATUS_CODE;

SELECT * FROM TRANSACTION_TYPE;

SELECT * FROM TRANSACTION_TABLE ORDER BY TRANSACTION_ID;

--Display created views
SELECT * FROM V_AGG_HOURLY_TRANSACTIONS_BY_TYPE;

SELECT * FROM V_HOURLY_FAILED_TRANSACTION;

SELECT * FROM V_AGG_DAILY_TRANSACTIONS_BY_TYPE;

SELECT * FROM V_DAILY_FAILED_TRANSACTIONS;

SELECT * FROM V_AGG_DAILY_TRANSACTIONS_BY_BRANCH;

SELECT * FROM V_AGG_DAILY_FAILED_TRANSACTIONS_BY_BRANCH;

SELECT * FROM V_AGG_HOURLY_TRANSACTIONS_BY_BRANCH;

SELECT * FROM V_AGG_HOURLY_FAILED_TRANSACTIONS_BY_BRANCH;

SELECT * FROM V_CUSTOMER_ACCOUNT_BALANCES;

SELECT * FROM V_ACCOUNTS_BRANCH_INFO;

SELECT * FROM V_TRANSACTION_DETAILS;

SELECT * FROM V_LOANS_CUSTOMER_INFO;

SELECT * FROM V_EMPLOYEE_POSITION_INFO;

SELECT * FROM V_OVERDRAFT_ACCOUNTS;

SELECT * FROM V_AGG_OVERDRAFT_ACCOUNTS_BY_BRANCH;

---------------------------------------------------------------------------------------------------------------------------------
--FUNCTIONS
---------------------------------------------------------------------------------------------------------------------------------

CREATE OR REPLACE FUNCTION GET_TOTAL_LOAN_AMOUNT (
    p_customer_id IN LOAN.CUSTOMER_ID%TYPE
) RETURN NUMBER
IS
    v_total_amount NUMBER := 0;
BEGIN
    SELECT SUM(AMOUNT)
    INTO v_total_amount
    FROM LOAN
    WHERE CUSTOMER_ID = p_customer_id;

    RETURN NVL(v_total_amount, 0);
END GET_TOTAL_LOAN_AMOUNT;
/


CREATE OR REPLACE FUNCTION GET_ACCOUNT_BALANCE (
    p_customer_id IN ACCOUNTS.CUSTOMER_ID%TYPE
) RETURN NUMBER
IS
    v_balance NUMBER := 0;
BEGIN
    SELECT SUM(BALANCE)
    INTO v_balance
    FROM ACCOUNTS
    WHERE CUSTOMER_ID = p_customer_id;

    RETURN NVL(v_balance, 0);
END GET_ACCOUNT_BALANCE;
/

CREATE OR REPLACE FUNCTION GET_CUSTOMER_FULL_NAME (
    p_customer_id IN CUSTOMER.CUSTOMER_ID%TYPE
) RETURN VARCHAR2
IS
    v_full_name VARCHAR2(100);
BEGIN
    SELECT FIRST_NAME || ' ' || LAST_NAME
    INTO v_full_name
    FROM CUSTOMER
    WHERE CUSTOMER_ID = p_customer_id;

    RETURN v_full_name;
END GET_CUSTOMER_FULL_NAME;
/

CREATE OR REPLACE FUNCTION GET_EMPLOYEE_FULL_NAME (
    p_employee_id IN EMPLOYEE.EMPLOYEE_ID%TYPE
) RETURN VARCHAR2
IS
    v_full_name VARCHAR2(100);
BEGIN
    SELECT FIRST_NAME || ' ' || LAST_NAME
    INTO v_full_name
    FROM EMPLOYEE
    WHERE EMPLOYEE_ID = p_employee_id;

    RETURN v_full_name;
END GET_EMPLOYEE_FULL_NAME;
/

CREATE OR REPLACE FUNCTION GET_CUSTOMER_LOAN_COUNT (
    p_customer_id IN LOAN.CUSTOMER_ID%TYPE
) RETURN NUMBER
IS
    v_loan_count NUMBER := 0;
BEGIN
    SELECT COUNT(*)
    INTO v_loan_count
    FROM LOAN
    WHERE CUSTOMER_ID = p_customer_id;

    RETURN v_loan_count;
END GET_CUSTOMER_LOAN_COUNT;
/

CREATE OR REPLACE FUNCTION IS_BALANCE_SUFFICIENT (
    p_account_id IN ACCOUNTS.ACCOUNT_ID%TYPE,
    p_amount     IN NUMBER
) RETURN CHAR
IS
    v_balance NUMBER := 0;
BEGIN
    SELECT BALANCE
    INTO v_balance
    FROM ACCOUNTS
    WHERE ACCOUNT_ID = p_account_id;

    IF v_balance >= p_amount THEN
        RETURN 'Yes';
    ELSE
        RETURN 'No';
    END IF;
END IS_BALANCE_SUFFICIENT;
/


CREATE OR REPLACE FUNCTION GET_ACCOUNT_COUNT_BY_TYPE (
    p_account_type IN ACCOUNTS.ACCOUNT_TYPE%TYPE
) RETURN NUMBER
IS
    v_account_count NUMBER := 0;
BEGIN
    SELECT COUNT(*)
    INTO v_account_count
    FROM ACCOUNTS
    WHERE ACCOUNT_TYPE = p_account_type;

    RETURN v_account_count;
END GET_ACCOUNT_COUNT_BY_TYPE;
/

CREATE OR REPLACE FUNCTION GET_EMPLOYEE_COUNT_BY_BRANCH (
    p_branch_id IN EMPLOYEE.BRANCH_ID%TYPE
) RETURN NUMBER
IS
    v_employee_count NUMBER := 0;
BEGIN
    SELECT COUNT(*)
    INTO v_employee_count
    FROM EMPLOYEE
    WHERE BRANCH_ID = p_branch_id;

    RETURN v_employee_count;
END GET_EMPLOYEE_COUNT_BY_BRANCH;
/

SELECT GET_CUSTOMER_FULL_NAME(1800) FROM DUAL;

SELECT GET_EMPLOYEE_FULL_NAME(608) FROM DUAL;

SELECT GET_TOTAL_LOAN_AMOUNT(1845) FROM Dual;

SELECT GET_ACCOUNT_BALANCE(1800) FROM DUAL;

SELECT GET_CUSTOMER_LOAN_COUNT(1815) FROM DUAL;

SELECT IS_BALANCE_SUFFICIENT(105, 45000) AS IS_SUFFICIENT FROM DUAL;

SELECT GET_ACCOUNT_COUNT_BY_TYPE(4) FROM DUAL;

SELECT GET_EMPLOYEE_COUNT_BY_BRANCH(3601) FROM DUAL;

---------------------------------------------------------------------------------------------------------------------------------
--TESTING MAIN DB ADMIN PACKAGES
---------------------------------------------------------------------------------------------------------------------------------


-----CUSTOMER MANAGEMENT PKG
BEGIN
    CUSTOMER_MGMT_PKG.UPDATE_CUSTOMER_DETAILS(
        p_customer_id => 1800, -- Replace with the actual customer ID you want to update
        p_email_id => 'john.doe.updated@email.com',
        p_phone_number => '9876543210'
    );
END;
/

DECLARE
    v_accounts SYS_REFCURSOR;
    v_account_id ACCOUNTS.ACCOUNT_ID%TYPE;
    v_balance ACCOUNTS.BALANCE%TYPE;
BEGIN
    v_accounts := CUSTOMER_MGMT_PKG.GET_CUSTOMER_ACCOUNTS(p_customer_id => 1805); -- Replace '1' with a valid customer ID from your database

    LOOP
        FETCH v_accounts INTO v_account_id, v_balance;
        EXIT WHEN v_accounts%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Account ID: ' || v_account_id || ', Balance: ' || v_balance);
    END LOOP;

    CLOSE v_accounts;
END;
/

DECLARE
    v_loans SYS_REFCURSOR;
    v_loan_rec LOAN.LOAN_ID%TYPE;
    v_loan_type LOAN_TYPE.LOAN_TYPE%TYPE;
    v_amount LOAN.AMOUNT%TYPE;
BEGIN
    v_loans := CUSTOMER_MGMT_PKG.GET_CUSTOMER_LOANS(p_customer_id => 1805);
    LOOP
        FETCH v_loans INTO v_loan_rec, v_loan_type, v_amount;
        EXIT WHEN v_loans%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Loan ID: ' || v_loan_rec || ', Loan Type: ' || v_loan_type || ', Amount: ' || v_amount);
    END LOOP;
    CLOSE v_loans;
END;
/

DECLARE
    v_transactions SYS_REFCURSOR;
    TYPE v_transaction_record_type IS RECORD (
        TRANSACTION_ID      TRANSACTION_TABLE.TRANSACTION_ID%TYPE,
        TIME_STAMP          TRANSACTION_TABLE.TIME_STAMP%TYPE,
        AMOUNT              TRANSACTION_TABLE.AMOUNT%TYPE,
        TRANSACTION_DETAILS TRANSACTION_TABLE.TRANSACTION_DETAILS%TYPE,
        STATUS              TRANSACTION_TABLE.STATUS%TYPE,
        ACCOUNT_ID          TRANSACTION_TABLE.ACCOUNT_ID%TYPE
    );
    v_transaction v_transaction_record_type;
BEGIN
    v_transactions := CUSTOMER_MGMT_PKG.GET_LIKELIEST_5_TRANSACTIONS(p_customer_id => 1815);

    LOOP
        FETCH v_transactions INTO v_transaction;
        EXIT WHEN v_transactions%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE('Account ID: ' || v_transaction.ACCOUNT_ID || ', Transaction ID: ' || v_transaction.TRANSACTION_ID || ', Time Stamp: ' || v_transaction.TIME_STAMP || ', Amount: ' || v_transaction.AMOUNT || ', Details: ' || v_transaction.TRANSACTION_DETAILS || ', Status: ' || v_transaction.STATUS);
    END LOOP;
    CLOSE v_transactions;
END;
/

DECLARE
    v_latest_transaction SYS_REFCURSOR;
    TYPE v_transaction IS RECORD (
        TRANSACTION_ID      TRANSACTION_TABLE.TRANSACTION_ID%TYPE,
        ACCOUNT_ID          TRANSACTION_TABLE.ACCOUNT_ID%TYPE,
        STATUS              TRANSACTION_TABLE.STATUS%TYPE,
        TIME_STAMP          TRANSACTION_TABLE.TIME_STAMP%TYPE,
        AMOUNT              TRANSACTION_TABLE.AMOUNT%TYPE,
        TRANSACTION_DETAILS TRANSACTION_TABLE.TRANSACTION_DETAILS%TYPE
    );
    v_t v_transaction;
BEGIN
    v_latest_transaction := CUSTOMER_MGMT_PKG.GET_LATEST_TRANSACTION(p_customer_id => 1805);

    FETCH v_latest_transaction INTO v_t;
    CLOSE v_latest_transaction;
    
    DBMS_OUTPUT.PUT_LINE('Account ID: ' || v_t.ACCOUNT_ID || ', Transaction ID: ' || v_t.TRANSACTION_ID || ', Time Stamp: ' || v_t.TIME_STAMP || ', Amount: ' || v_t.AMOUNT || ', Details: ' || v_t.TRANSACTION_DETAILS || ', Status: ' || v_t.STATUS);
END;
/


--------EMPLOYEE MANAGEMENT PKG
BEGIN
    EMPLOYEE_MGMT_PKG.UPDATE_EMPLOYEE_DETAILS(
        p_employee_id => 608, -- Replace with the actual customer ID you want to update
        p_email_id => 'updated@email.com',
        p_phone_number => '3344556677'
    );
END;
/

DECLARE
    v_employee_id EMPLOYEE.EMPLOYEE_ID%TYPE := 620; -- Replace with an actual employee ID in your table
    v_result EMPLOYEE%ROWTYPE;
BEGIN
    v_result := Employee_Mgmt_pkg.GET_EMPLOYEE_BY_ID(v_employee_id);
    DBMS_OUTPUT.PUT_LINE('Employee ID: ' || v_result.EMPLOYEE_ID || ', Name: ' || v_result.FIRST_NAME || ' ' || v_result.LAST_NAME);
END;
/

DECLARE
    v_role_id EMPLOYEE.ROLE_ID%TYPE := 1; -- Replace with an actual role ID in your table
    v_employee_cur SYS_REFCURSOR;
    v_result EMPLOYEE.EMPLOYEE_ID%TYPE;
    v_fname EMPLOYEE.FIRST_NAME%TYPE;
    v_lname EMPLOYEE.LAST_NAME%TYPE;
    v_bname BRANCH.BRANCH_NAME%TYPE;
BEGIN
    v_employee_cur := Employee_Mgmt_pkg.GET_EMPLOYEES_BY_ROLE(v_role_id);
    LOOP
        FETCH v_employee_cur INTO v_result, v_fname, v_lname, v_bname;
        EXIT WHEN v_employee_cur%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Employee ID: ' || v_result || ', Name: ' || v_fname || ' ' || v_lname || ', Branch:' || v_bname);
    END LOOP;
    CLOSE v_employee_cur;
END;
/

----------ACCOUNT MANAGEMENT PKG
DECLARE
    v_exists NUMBER;
BEGIN
    v_exists := ACCOUNT_MGMT_PKG.ACCOUNT_EXISTS(p_account_id => 101);
    IF v_exists = 1 THEN
        DBMS_OUTPUT.PUT_LINE('Account already exists');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Account does not exist');
    END IF;
END;
/

DECLARE
    v_account_id ACCOUNTS.ACCOUNT_ID%TYPE := 101; -- Replace with a valid account ID from your database
    v_balance NUMBER;
BEGIN
    v_balance := ACCOUNT_MGMT_PKG.GET_ACCOUNT_BALANCE(p_account_id => v_account_id);
    DBMS_OUTPUT.PUT_LINE('Account ID: ' || v_account_id || ', Balance: ' || v_balance);
END;
/

DECLARE
    v_bank_statement SYS_REFCURSOR;
    Type v_transaction IS RECORD (
        TRANSACTION_ID      TRANSACTION_TABLE.TRANSACTION_ID%TYPE,
        ACCOUNT_ID          TRANSACTION_TABLE.ACCOUNT_ID%TYPE,
        TIME_STAMP          TRANSACTION_TABLE.TIME_STAMP%TYPE,
        AMOUNT              TRANSACTION_TABLE.AMOUNT%TYPE,
        TRANSACTION_DETAILS TRANSACTION_TABLE.TRANSACTION_DETAILS%TYPE,
        STATUS              TRANSACTION_TABLE.STATUS%TYPE
    );
    v_t v_transaction;
BEGIN
    v_bank_statement := ACCOUNT_MGMT_PKG.GET_BANK_STATEMENT(p_account_id => 103);

    LOOP
        FETCH v_bank_statement INTO v_t;
        EXIT WHEN v_bank_statement%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE('Transaction ID: ' || v_t.TRANSACTION_ID || ', Account ID: ' || v_t.ACCOUNT_ID || ', Time Stamp: ' || v_t.TIME_STAMP || ', Amount: ' || v_t.AMOUNT || ', Details: ' || v_t.TRANSACTION_DETAILS || ', Status: ' || v_t.STATUS);
    END LOOP;
    CLOSE v_bank_statement;
END;
/

DECLARE
    v_latest_transaction SYS_REFCURSOR;
    v_transaction TRANSACTION_TABLE%ROWTYPE;
BEGIN
    v_latest_transaction := ACCOUNT_MGMT_PKG.GET_LATEST_TRANSACTION(p_account_id => 101);

    FETCH v_latest_transaction INTO v_transaction;
    CLOSE v_latest_transaction;

    DBMS_OUTPUT.PUT_LINE('Transaction ID: ' || v_transaction.TRANSACTION_ID || ', Account ID: ' || v_transaction.ACCOUNT_ID || ', Time Stamp: ' || v_transaction.TIME_STAMP || ', Amount: ' || v_transaction.AMOUNT || ', Details: ' || v_transaction.TRANSACTION_DETAILS || ', Status: ' || v_transaction.STATUS);
END;
/

DECLARE
    v_last_5_transactions SYS_REFCURSOR;
    v_transaction TRANSACTION_TABLE%ROWTYPE;
BEGIN
    v_last_5_transactions := ACCOUNT_MGMT_PKG.GET_LIKELIEST_5_TRANSACTIONS(p_account_id => 101);

    LOOP
        FETCH v_last_5_transactions INTO v_transaction;
        EXIT WHEN v_last_5_transactions%NOTFOUND;

        DBMS_OUTPUT.PUT_LINE('Transaction ID: ' || v_transaction.TRANSACTION_ID || ', Account ID: ' || v_transaction.ACCOUNT_ID || ', Time Stamp: ' || v_transaction.TIME_STAMP || ', Amount: ' || v_transaction.AMOUNT || ', Details: ' || v_transaction.TRANSACTION_DETAILS || ', Status: ' || v_transaction.STATUS);
    END LOOP;
    CLOSE v_last_5_transactions;
END;
/

----------LOAN MANAGEMENT PKG
DECLARE
    v_loan_exists NUMBER;
BEGIN
    v_loan_exists := LOAN_MGMT_PKG.LOAN_EXISTS(p_loan_id => 500); -- Replace with a valid loan ID
    IF v_loan_exists = 1 THEN
        DBMS_OUTPUT.PUT_LINE('Loan already exists');
    ELSE
        DBMS_OUTPUT.PUT_LINE('Loan does not exist');
    END IF;
END;
/


DECLARE
    v_loan_details SYS_REFCURSOR;
    v_loan_rec LOAN%ROWTYPE;
BEGIN
    v_loan_details := LOAN_MGMT_PKG.GET_LOAN_DETAILS(p_loan_id => 505); -- Replace with a valid loan ID

    LOOP
        FETCH v_loan_details INTO v_loan_rec;
        EXIT WHEN v_loan_details%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Loan ID: ' || v_loan_rec.LOAN_ID || ', Amount: ' || v_loan_rec.AMOUNT || ', Interest Rate: ' || v_loan_rec.INTEREST_RATE);
    END LOOP;

    CLOSE v_loan_details;
END;
/

BEGIN
    LOAN_MGMT_PKG.UPDATE_LOAN_DETAILS(
        p_loan_id => 500, -- Replace with a valid loan ID
        p_amount => 25000,
        p_commencement_date => TO_DATE('2023-04-02', 'YYYY-MM-DD')
    );
    COMMIT;
END;
/

----------------TRANSACTION MANAGEMENT PKG
DECLARE
    v_transaction_details SYS_REFCURSOR;
    v_transaction_rec TRANSACTION_TABLE%ROWTYPE;
BEGIN
    v_transaction_details := TRANSACTION_MGMT_PKG.GET_TRANSACTION_DETAILS(p_transaction_id => 10001); -- Replace with a valid loan ID

    LOOP
        FETCH v_transaction_details INTO v_transaction_rec;
        EXIT WHEN v_transaction_details%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE('Transaction ID: ' || v_transaction_rec.TRANSACTION_ID || ', Amount: ' || v_transaction_rec.AMOUNT || ', Account ID: ' || v_transaction_rec.ACCOUNT_ID || ', Status: ' || v_transaction_rec.STATUS || ', Timestamp: ' || v_transaction_rec.TIME_STAMP || ', Transaction Details: ' || v_transaction_rec.TRANSACTION_DETAILS);
    END LOOP;

    CLOSE v_transaction_details;
END;
/

BEGIN
    CUSTOMER_MGMT_PKG.ADD_NEW_CUSTOMER(
        'John', 'Doe', TO_DATE('1985-06-15', 'YYYY-MM-DD'), 'john.doe@email.com', '1234567890',
        TO_DATE('2023-01-01', 'YYYY-MM-DD'), 50000, 'johndoe', 'abc123xyz456', '123 Main St', 'Springfield',
        'Massachusetts'
    );
END;
/

BEGIN
    EMPLOYEE_MGMT_PKG.ADD_NEW_EMPLOYEE(3600, 2, 'Michael', 'Roberts', TO_DATE('1980-07-15', 'YYYY-MM-DD'), 'michael.roberts@email.com', '1234567890',
                     TO_DATE('2020-10-15', 'YYYY-MM-DD'), 'michaelr', 'a6f8c4d93479234bdf1a776121b8e8b3', '123 Main St', 'Boston',
                     'MA', 608);
                     
END;
/

COMMIT;