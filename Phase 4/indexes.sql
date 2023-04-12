---------------------------------------------------------------
-- User Defined Indexes
--------------------------------------------------------------

-- Customer Table Index
CREATE INDEX idx_customer_login_username ON CUSTOMER (LOGIN);

-- Department Table Index
CREATE INDEX idx_department_location ON DEPARTMENT (DEPT_LOCATION);

-- Transaction table Index
CREATE INDEX IDX_TRANSACTION_TABLE_TIMESTAMP ON TRANSACTION_TABLE (TIME_STAMP);

-- Employee Table Index
CREATE INDEX idx_employee_email ON EMPLOYEE (EMAIL_ID);

-- Branch Table Indexes
CREATE INDEX idx_branch_name ON BRANCH (BRANCH_NAME);
CREATE INDEX idx_branch_city ON BRANCH (CITY);

-- Transaction Type Table Index
CREATE INDEX idx_transaction_type_tran_type ON TRANSACTION_TYPE (TRANSACTION_TYPE);

-- Loan Type Table Index
CREATE INDEX idx_loan_type_loan_type ON LOAN_TYPE (LOAN_TYPE);

