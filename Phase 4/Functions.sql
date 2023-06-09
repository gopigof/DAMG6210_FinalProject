-------------------------------------------------------------------------------------------
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
