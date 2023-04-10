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
-------------------------------------------------------------------------------------------