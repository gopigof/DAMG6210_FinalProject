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