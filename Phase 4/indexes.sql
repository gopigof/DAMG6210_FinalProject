---------------------------------------------------------------
-- User Defined Indexes
--------------------------------------------------------------

-- Accounts Table Index
CREATE INDEX idx_account_created_date ON ACCOUNTS (CREATED_DATE);

-- Branch Table Indexes
CREATE INDEX idx_branch_name ON BRANCH (BRANCH_NAME);
CREATE INDEX idx_branch_city ON BRANCH (CITY);

-- Customer Table Index
CREATE INDEX idx_customer_login_username ON CUSTOMER (LOGIN);

-- Employee Table Index
CREATE INDEX idx_employee_login ON EMPLOYEE (LOGIN);

-- Transaction table Index
CREATE INDEX IDX_TRANSACTION_TABLE_STATUS ON TRANSACTION_TABLE (STATUS);
