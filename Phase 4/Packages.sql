-------------------------------------------------------------------------------------------
--                        ***********PACKAGES FOR DATABASE_ADMIN***********
-------------------------------------------------------------------------------------------                    
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

---------------------------------------------------------------------------------------------------------------------------------------------------------------
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
--------------------------------------------------------------------------------------------------------------------------
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