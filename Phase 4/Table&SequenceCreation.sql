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