-------------------------------------------------------------------------------------------
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
