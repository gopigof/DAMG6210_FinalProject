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
-------------------------------------------------------------------------------------------
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
-------------------------------------------------------------------------------------------
--                        ***********PACKAGES FOR USERS***********
-------------------------------------------------------------------------------------------
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
    
END EMPLOYEE_PKG;
/
-------------------------------------------------------------------------------------------
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
    
END MANAGER_PKG;
/
-------------------------------------------------------------------------------------------
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
-------------------------------------------------------------------------------------------