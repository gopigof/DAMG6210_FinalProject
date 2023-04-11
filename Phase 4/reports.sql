---------------------------------------------------------------
-- User Defined Reports
--------------------------------------------------------------

-- 1. Branch Level Accounts Report
SELECT
    B.BRANCH_NAME,
    AT.ACCOUNT_TYPE,
    SUM(A.BALANCE)
FROM
    BRANCH B
    JOIN ACCOUNTS A ON B.BRANCH_ID = A.BRANCH_ID
    JOIN CUSTOMER C ON C.CUSTOMER_ID = A.CUSTOMER_ID
    JOIN ACCOUNT_TYPE AT ON A.ACCOUNT_TYPE = AT.ACCOUNT_TYPE_ID
GROUP BY
    B.BRANCH_NAME, AT.ACCOUNT_TYPE


-- 2.