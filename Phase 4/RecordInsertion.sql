-------------------------------------------------------------------------------------------
--Insert Customer Records using CUSTOMER_MGMT_PKG
BEGIN
    CUSTOMER_MGMT_PKG.ADD_NEW_CUSTOMER(
        'John', 'Doe', TO_DATE('1985-06-15', 'YYYY-MM-DD'), 'john.doe@email.com', '1234567890',
        TO_DATE('2023-01-01', 'YYYY-MM-DD'), 50000, 'johndoe', 'abc123xyz456', '123 Main St', 'Springfield',
        'Massachusetts'
    );

    CUSTOMER_MGMT_PKG.ADD_NEW_CUSTOMER(
        'Jane', 'Doe', TO_DATE('1990-09-20', 'YYYY-MM-DD'), 'jane.doe@email.com', '1234567891',
        TO_DATE('2023-01-05', 'YYYY-MM-DD'), 55000, 'janedoe', 'def123xyz456', '234 Elm St', 'Boston', 'Massachusetts'
    );

    -- Repeat this pattern for the rest of the customers:

    CUSTOMER_MGMT_PKG.ADD_NEW_CUSTOMER(
        'Bob', 'Smith', TO_DATE('1978-03-12', 'YYYY-MM-DD'), 'bob.smith@email.com', '1234567892',
        TO_DATE('2023-01-10', 'YYYY-MM-DD'), 65000, 'bobsmith', 'ghi123xyz456', '345 Oak St', 'Springfield',
        'Massachusetts'
    );
    
    CUSTOMER_MGMT_PKG.ADD_NEW_CUSTOMER(
        'Alice', 'Johnson', TO_DATE('1993-12-01', 'YYYY-MM-DD'), 'alice.johnson@email.com', '1234567893',
        TO_DATE('2023-01-15', 'YYYY-MM-DD'), 58000, 'alicejohn', 'jkl123xyz456', '456 Maple St', 'Cambridge',
        'Massachusetts'
    );
    
    CUSTOMER_MGMT_PKG.ADD_NEW_CUSTOMER(
        'Charlie', 'Brown', TO_DATE('1988-05-25', 'YYYY-MM-DD'), 'charlie.brown@email.com', '1234567894',
        TO_DATE('2023-01-20', 'YYYY-MM-DD'), 100000, 'charliebr', 'mno123xyz456', '567 Pine St', 'Springfield',
        'Massachusetts'
    );
    
    CUSTOMER_MGMT_PKG.ADD_NEW_CUSTOMER(
        'Olivia', 'Miller', TO_DATE('1995-10-10', 'YYYY-MM-DD'), 'olivia.miller@email.com', '1234567895',
        TO_DATE('2023-01-25', 'YYYY-MM-DD'), 75000, 'oliviamill', 'pqr123xyz456', '678 Birch St', 'Boston',
        'Massachusetts'
    );
    
    CUSTOMER_MGMT_PKG.ADD_NEW_CUSTOMER(
        'William', 'Davis', TO_DATE('1982-07-18', 'YYYY-MM-DD'), 'william.davis@email.com', '1234567896',
        TO_DATE('2023-01-30', 'YYYY-MM-DD'), 66000, 'williamdav', 'stu123xyz456', '789 Cedar St', 'Springfield',
        'Massachusetts'
    );
    
    CUSTOMER_MGMT_PKG.ADD_NEW_CUSTOMER(
        'Emily', 'Garcia', TO_DATE('1987-01-30', 'YYYY-MM-DD'), 'emily.garcia@email.com', '1234567897',
        TO_DATE('2023-02-02', 'YYYY-MM-DD'), 98000, 'emilyga', 'vwx123xyz456', '890 Willow St', 'Lowell',
        'Massachusetts'
    );
    
    CUSTOMER_MGMT_PKG.ADD_NEW_CUSTOMER(
        'Daniel', 'Anderson', TO_DATE('1992-04-08', 'YYYY-MM-DD'), 'daniel.anderson@email.com', '1234567898',
        TO_DATE('2023-02-07', 'YYYY-MM-DD'), 80000, 'danieland', 'yzA123xyz456', '901 Aspen St', 'Boston',
        'Massachusetts'
    );
    
    CUSTOMER_MGMT_PKG.ADD_NEW_CUSTOMER(
        'Emma', 'Taylor', TO_DATE('1997-02-15', 'YYYY-MM-DD'), 'emma.taylor@email.com', '1234567899',
        TO_DATE('2023-02-12', 'YYYY-MM-DD'), 130000, 'emmataylor', 'zAB123xyz456', '1002 Oak Grove St', 'Cambridge',
        'Massachusetts'
    );
    
END;
/

-- Insert Branch records using ADD_NEW_BRANCH Procedure
BEGIN
    ADD_NEW_BRANCH('Central Branch', 'CENBR01', '123 Central St', 'Boston', 'Massachusetts', '9876543210', 'central.branch@email.com');
    ADD_NEW_BRANCH('Westside Branch', 'WESBR01', '456 Westside Ave', 'Springfield', 'Massachusetts', '9876543211', 'westside.branch@email.com');
END;
/

-- Insert Loan_Type records using ADD_NEW_LOAN_TYPE Procedure
BEGIN
    ADD_NEW_LOAN_TYPE('Personal Loan', 'Unsecured loan for personal expenses');
    ADD_NEW_LOAN_TYPE('Mortgage Loan', 'Loan for home purchase, secured by the property');
    ADD_NEW_LOAN_TYPE('Auto Loan', 'Loan for vehicle purchase, secured by the vehicle');
    ADD_NEW_LOAN_TYPE('Student Loan', 'Loan for educational expenses, often with lower interest rates');
    ADD_NEW_LOAN_TYPE('Business Loan', 'Loan for business expenses, often secured by business assets');
    ADD_NEW_LOAN_TYPE('Home Equity Loan', 'Loan based on the equity in the borrower''s home, secured by the property');
END;
/

-- Insert Loan records using LOAN_MGMT_PKG 
BEGIN
    LOAN_MGMT_PKG.ADD_NEW_LOAN(1810, 1, 3600, 15000, 6.0, 48, TO_DATE('2023-01-15', 'YYYY-MM-DD'));
    LOAN_MGMT_PKG.ADD_NEW_LOAN(1835, 2, 3601, 250000, 3.75, 360, TO_DATE('2023-02-10', 'YYYY-MM-DD'));
    LOAN_MGMT_PKG.ADD_NEW_LOAN(1820, 4, 3600, 60000, 4.5, 120, TO_DATE('2023-01-25', 'YYYY-MM-DD'));
    LOAN_MGMT_PKG.ADD_NEW_LOAN(1845, 3, 3600, 18000, 5.25, 60, TO_DATE('2023-02-15', 'YYYY-MM-DD'));
    LOAN_MGMT_PKG.ADD_NEW_LOAN(1800, 1, 3600, 8000, 7.0, 36, TO_DATE('2023-01-15', 'YYYY-MM-DD'));
    LOAN_MGMT_PKG.ADD_NEW_LOAN(1805, 5, 3601, 50000, 5.5, 84, TO_DATE('2023-02-10', 'YYYY-MM-DD'));
    LOAN_MGMT_PKG.ADD_NEW_LOAN(1825, 2, 3600, 300000, 4.0, 360, TO_DATE('2023-02-28', 'YYYY-MM-DD'));
    LOAN_MGMT_PKG.ADD_NEW_LOAN(1845, 6, 3601, 70000, 4.75, 120, TO_DATE('2023-03-20', 'YYYY-MM-DD'));
    LOAN_MGMT_PKG.ADD_NEW_LOAN(1810, 3, 3600, 12000, 5.0, 48, TO_DATE('2023-02-05', 'YYYY-MM-DD'));
END;
/

-- Insert Account_type records using ADD_NEW_ACCOUNT_TYPE Procedure
BEGIN
    ADD_NEW_ACCOUNT_TYPE('Savings Account', 1.5);
    ADD_NEW_ACCOUNT_TYPE('Checking Account', 0.25);
    ADD_NEW_ACCOUNT_TYPE('High-Yield Savings Account', 3);
    ADD_NEW_ACCOUNT_TYPE('Student Account', 0);
END;
/



-- Insert Accounts
BEGIN
    -- 1. John Doe
    ACCOUNT_MGMT_PKG.ADD_NEW_ACCOUNT(1800, 1, 3600, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 10000, 1111222233331111, 'Drivers License');
    ACCOUNT_MGMT_PKG.ADD_NEW_ACCOUNT(1800, 2, 3600, TO_DATE('2023-01-01', 'YYYY-MM-DD'), 15000, 1111222233331122, 'Drivers License');

    -- 2. Jane Doe
    ACCOUNT_MGMT_PKG.ADD_NEW_ACCOUNT(1805, 1, 3600, TO_DATE('2023-01-05', 'YYYY-MM-DD'), 12000, 1111222233332211, 'Passport');
    ACCOUNT_MGMT_PKG.ADD_NEW_ACCOUNT(1805, 2, 3600, TO_DATE('2023-01-05', 'YYYY-MM-DD'), 8000, 1111222233332222, 'Passport');

    -- 3. Bob Smith
    ACCOUNT_MGMT_PKG.ADD_NEW_ACCOUNT(1810, 1, 3601, TO_DATE('2023-01-10', 'YYYY-MM-DD'), 25000, 1111222233333311, 'Drivers License');

    -- 4. Alice Johnson
    ACCOUNT_MGMT_PKG.ADD_NEW_ACCOUNT(1815, 1, 3600, TO_DATE('2023-01-15', 'YYYY-MM-DD'), 18000, 1111222233334411, 'Passport');
    ACCOUNT_MGMT_PKG.ADD_NEW_ACCOUNT(1815, 2, 3600, TO_DATE('2023-01-15', 'YYYY-MM-DD'), 9000, 1111222233334422, 'Passport');

    -- 5. Charlie Brown
    ACCOUNT_MGMT_PKG.ADD_NEW_ACCOUNT(1820, 3, 3601, TO_DATE('2023-01-20', 'YYYY-MM-DD'), 30000, 1111222233335533, 'Drivers License');
    ACCOUNT_MGMT_PKG.ADD_NEW_ACCOUNT(1820, 4, 3601, TO_DATE('2023-01-20', 'YYYY-MM-DD'), 1000, 1111222233335544, 'Drivers License');

    -- 6. Grace Smith
    ACCOUNT_MGMT_PKG.ADD_NEW_ACCOUNT(1825, 2, 3600, TO_DATE('2023-01-25', 'YYYY-MM-DD'), 8000, 1111222233336611, 'Passport');
    ACCOUNT_MGMT_PKG.ADD_NEW_ACCOUNT(1825, 4, 3600, TO_DATE('2023-01-25', 'YYYY-MM-DD'), 2000, 1111222233336622, 'Passport');

    -- 7. Emma Johnson
    ACCOUNT_MGMT_PKG.ADD_NEW_ACCOUNT(1830, 3, 3601, TO_DATE('2023-01-30', 'YYYY-MM-DD'), 40000, 1111222233337733, 'Drivers License');

    -- 8. James Brown
    ACCOUNT_MGMT_PKG.ADD_NEW_ACCOUNT(1835, 1, 3600, TO_DATE('2023-02-02', 'YYYY-MM-DD'), 12000, 1111222233338811, 'Passport');
    ACCOUNT_MGMT_PKG.ADD_NEW_ACCOUNT(1835, 2, 3600, TO_DATE('2023-02-02', 'YYYY-MM-DD'), 6000, 1111222233338822, 'Passport');

    -- 9. Emily Brown
    ACCOUNT_MGMT_PKG.ADD_NEW_ACCOUNT(1840, 4, 3601, TO_DATE('2023-02-07', 'YYYY-MM-DD'), -200, 1111222233339922, 'Drivers License');

    -- 10. William Johnson
    ACCOUNT_MGMT_PKG.ADD_NEW_ACCOUNT(1845, 4, 3600, TO_DATE('2023-02-12', 'YYYY-MM-DD'), -500, 1111222233330022, 'Passport');

END;
/

-- Insert Roles using ADD_NEW_ROLE Procedure
BEGIN
    ADD_NEW_ROLE('Employee', 35000);
    ADD_NEW_ROLE('Branch Manager', 60000);
END;
/

-- Insert employees using EMPLOYEE_MGMT_PKG
BEGIN
    EMPLOYEE_MGMT_PKG.ADD_NEW_EMPLOYEE(3600, 2, 'Michael', 'Roberts', TO_DATE('1980-07-15', 'YYYY-MM-DD'), 'michael.roberts@email.com', '1234567890',
                     TO_DATE('2020-10-15', 'YYYY-MM-DD'), 'michaelr', 'a6f8c4d93479234bdf1a776121b8e8b3', '123 Main St', 'Boston',
                     'MA', 608);

    EMPLOYEE_MGMT_PKG.ADD_NEW_EMPLOYEE(3600, 1, 'Laura', 'Wilson', TO_DATE('1990-03-12', 'YYYY-MM-DD'), 'laura.wilson@email.com', '2345678901',
                     TO_DATE('2022-12-10', 'YYYY-MM-DD'), 'lauraw', '5b5ec7c5f17d7e1e76c71e7aa52f8c5d', '234 Main St', 'Powell',
                     'MA', 608);
    
    EMPLOYEE_MGMT_PKG.ADD_NEW_EMPLOYEE(3600, 1, 'Daniel', 'Green', TO_DATE('1985-06-25', 'YYYY-MM-DD'), 'daniel.green@email.com', '3456789012',
        TO_DATE('2023-02-01', 'YYYY-MM-DD'), 'danielg', 'c7d3a3c07de98b8f8525b5ee5f5e9fc9', '345 Main St',
        'Springfield', 'MA', 608);

    EMPLOYEE_MGMT_PKG.ADD_NEW_EMPLOYEE(3600, 1, 'Sophia', 'Mitchell', TO_DATE('1988-08-14', 'YYYY-MM-DD'), 'sophia.mitchell@email.com', '4567890123',
        TO_DATE('2021-05-23', 'YYYY-MM-DD'), 'sophiam', '3e1d07a3f11b1d8d83e4cd4eef581123', '456 Main St', 'New York',
        'NY', 608);

    EMPLOYEE_MGMT_PKG.ADD_NEW_EMPLOYEE(3601, 2, 'Olivia', 'Parker', TO_DATE('1978-02-27', 'YYYY-MM-DD'), 'olivia.parker@email.com', '5678901234',
        TO_DATE('2019-11-18', 'YYYY-MM-DD'), 'oliviap', '8a9c7a635bdf0cd0d1f8e4fe7cbe4aef', '567 Main St', 'Cambridge',
        'MA', 620);

    EMPLOYEE_MGMT_PKG.ADD_NEW_EMPLOYEE(3601, 1, 'Emma', 'Turner', TO_DATE('1993-11-06', 'YYYY-MM-DD'), 'emma.turner@email.com', '6789012345',
        TO_DATE('2023-01-27', 'YYYY-MM-DD'), 'emmat', 'de4e1a7ab4c0f4b8c482b5d5b0c1e2cd', '678 Main St', 'Los Angeles',
        'CA', 620);

    EMPLOYEE_MGMT_PKG.ADD_NEW_EMPLOYEE(3601, 1, 'Jacob', 'Adams', TO_DATE('1986-12-23', 'YYYY-MM-DD'), 'jacob.adams@email.com', '7890123456',
        TO_DATE('2022-11-23', 'YYYY-MM-DD'), 'jacobad', '927d6aa81d45cde1d8c0f2e68e3d3e3c', '789 Main St', 'New York',
        'NY', 620);

    EMPLOYEE_MGMT_PKG.ADD_NEW_EMPLOYEE(3601, 1, 'Ava', 'Bennett', TO_DATE('1991-04-30', 'YYYY-MM-DD'), 'ava.bennett@email.com', '8901234567',
        TO_DATE('2021-04-11', 'YYYY-MM-DD'), 'avab', '1a2b3c4d5e6f7g8h9i0j1k2l3m4n5o6p', '890 Main St', 'Cambridge',
        'MA', 620);

    EMPLOYEE_MGMT_PKG.ADD_NEW_EMPLOYEE(3600, 1, 'Oliver', 'Patterson', TO_DATE('1993-08-17', 'YYYY-MM-DD'), 'oliver.patterson@email.com', '8912345678',
        TO_DATE('2023-01-15', 'YYYY-MM-DD'), 'oliverp', '1a2b3c4d5e6f7g8h9i0j1k2l3m4n5o6p', '123 High St', 'Worcester',
        'MA', 608);

    EMPLOYEE_MGMT_PKG.ADD_NEW_EMPLOYEE(3601, 1, 'Sophia', 'Turner', TO_DATE('1994-11-05', 'YYYY-MM-DD'), 'sophia.turner@email.com', '8923456789',
        TO_DATE('2023-01-20', 'YYYY-MM-DD'), 'sophiat', '1a2b3c4d5e6f7g8h9i0j1k2l3m4n5o6p', '980 Elm St', 'Cambridge',
        'MA', 620);
    
END;
/

-- insert transaction_type using ADD_NEW_TRANSACTION_TYPE Procedure
BEGIN
    ADD_NEW_TRANSACTION_TYPE('DEPOSIT', 'Deposit funds into an account');
    ADD_NEW_TRANSACTION_TYPE('WITHDRAWAL', 'Withdraw funds from an account');
    ADD_NEW_TRANSACTION_TYPE('TRANSFER', 'Transfer funds between accounts');
    ADD_NEW_TRANSACTION_TYPE('ONLINE_RETAIL', 'Online retail purchase');
END;
/

-- insert status_codes using ADD_NEW_STATUS_CODE Procedure
BEGIN
    ADD_NEW_STATUS_CODE(LPAD('00', 2, '0'), 'Transaction Approved');
    ADD_NEW_STATUS_CODE(LPAD('06', 2, '0'), 'Error');
    ADD_NEW_STATUS_CODE(LPAD('12', 2, '0'), 'Invalid Transaction');
    ADD_NEW_STATUS_CODE(LPAD('13', 2, '0'), 'Invalid Amount');
    ADD_NEW_STATUS_CODE(LPAD('14', 2, '0'), 'Invalid Card Number');
    ADD_NEW_STATUS_CODE(LPAD('51', 2, '0'), 'Insufficient Funds');
    ADD_NEW_STATUS_CODE(LPAD('54', 2, '0'), 'Expired Card');
END;
/

BEGIN
    DBMS_OUTPUT.ENABLE(1000000);
END;
/
