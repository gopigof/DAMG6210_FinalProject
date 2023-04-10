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