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