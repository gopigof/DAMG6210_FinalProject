-------------------------------------------------------------------------------------------

--VIEWS

-------------------------------------------------------------------------------------------
--V_AGG_HOURLY_TRANSACTIONS_BY_TYPE: Fetch the aggregate of the
--transactions started within the last hour from the 9PM of 16th March 2023 across all the accounts.
--The returned set should be grouped by their type
--CREATE VIEW V_AGG_HOURLY_TRANSACTIONS_BY_TYPE AS
CREATE OR REPLACE VIEW V_AGG_HOURLY_TRANSACTIONS_BY_TYPE_16th_March AS
    SELECT ty.transaction_type, COUNT(tr.transaction_id) AS num_transactions, SUM(tr.amount) AS total_amount
    FROM transaction_table tr
             JOIN transaction_type ty ON tr.transaction_type = ty.transaction_type_id
    WHERE TRUNC(tr.time_stamp, 'HH24') = TO_DATE('16-MAR-2023 21:00:00', 'DD-MON-YYYY HH24:MI:SS') - INTERVAL '1' HOUR
      AND tr.Status != 'Failed'
    GROUP BY ty.transaction_type
    ORDER BY ty.transaction_type;

--V_AGG_HOURLY_TRANSACTIONS_BY_TYPE: Fetch the aggregate of the
--transactions started within the last hour from the current timestamp across all the accounts.
--The returned set should be grouped by their type
--CREATE VIEW V_AGG_HOURLY_TRANSACTIONS_BY_TYPE AS
CREATE OR REPLACE VIEW V_AGG_HOURLY_TRANSACTIONS_BY_TYPE AS
SELECT ty.transaction_type, COUNT(tr.transaction_id) AS num_transactions, SUM(tr.amount) AS total_amount
FROM transaction_table tr
         JOIN transaction_type ty ON tr.transaction_type = ty.transaction_type_id
WHERE Tr.time_stamp BETWEEN SYSDATE - INTERVAL '1' HOUR AND SYSDATE - INTERVAL '1' SECOND
  AND Tr.Status != 'Failed'
GROUP BY ty.transaction_type
ORDER BY ty.transaction_type;

--V_HOURLY_FAILED_TRANSACTION: Fetches all the transactions started in the last
--hour  9PM of 16th March 2023 , which is in a "failure” status.
CREATE OR REPLACE VIEW V_HOURLY_FAILED_TRANSACTION_16th_March AS
    SELECT ty.transaction_type, COUNT(tr.transaction_id) AS num_transactions, SUM(tr.amount) AS total_amount
    FROM transaction_table tr
             JOIN transaction_type ty ON tr.transaction_type = ty.transaction_type_id
    WHERE TRUNC(tr.time_stamp, 'HH24') = TO_DATE('16-MAR-2023 21:00:00', 'DD-MON-YYYY HH24:MI:SS') - INTERVAL '1' HOUR
      AND tr.Status = 'Failed'
    GROUP BY ty.transaction_type
    ORDER BY ty.transaction_type;

--V_HOURLY_FAILED_TRANSACTION: Fetches all the transactions started in the last
--hour  from the current timestamp , which is in a "failure” status.
--CREATE VIEW V_HOURLY_FAILED_TRANSACTION AS
CREATE OR REPLACE VIEW V_HOURLY_FAILED_TRANSACTION AS
    SELECT ty.transaction_type, COUNT(tr.transaction_id) AS num_transactions, SUM(tr.amount) AS total_amount
    FROM transaction_table tr
             JOIN transaction_type ty ON tr.transaction_type = ty.transaction_type_id
    WHERE Tr.time_stamp BETWEEN SYSDATE - INTERVAL '1' HOUR AND SYSDATE - INTERVAL '1' SECOND
      AND Tr.Status = 'Failed'
    GROUP BY ty.transaction_type
    ORDER BY ty.transaction_type;

    