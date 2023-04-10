-------------------------------------------------------------------------------------------
--TESTING MAIN DB ADMIN FUNCTIONS
-------------------------------------------------------------------------------------------
SELECT GET_CUSTOMER_FULL_NAME(1800) FROM DUAL;

SELECT GET_EMPLOYEE_FULL_NAME(608) FROM DUAL;

SELECT GET_TOTAL_LOAN_AMOUNT(1845) FROM Dual;

SELECT GET_ACCOUNT_BALANCE(1800) FROM DUAL;

SELECT GET_CUSTOMER_LOAN_COUNT(1815) FROM DUAL;

SELECT IS_BALANCE_SUFFICIENT(105, 45000) AS IS_SUFFICIENT FROM DUAL;

SELECT GET_ACCOUNT_COUNT_BY_TYPE(4) FROM DUAL;

SELECT GET_EMPLOYEE_COUNT_BY_BRANCH(3601) FROM DUAL;

-------------------------------------------------------------------------------------------
--TESTING MAIN DB ADMIN PACKAGES
-------------------------------------------------------------------------------------------

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
-------------------------------------------------------------------------------------------

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
-------------------------------------------------------------------------------------------
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
-------------------------------------------------------------------------------------------
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
-------------------------------------------------------------------------------------------
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
-------------------------------------------------------------------------------------------
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
-------------------------------------------------------------------------------------------