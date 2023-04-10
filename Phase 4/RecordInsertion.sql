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


-- Insert transactions using TRANSACTION_MGMT_PKG
-- Account 1
-- Initial balance: 0
-- Final balance: 10000
-- Day 1
DECLARE
    current_time TIMESTAMP;
BEGIN
    current_time := SYSTIMESTAMP;

    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '00', 1, 12300, TO_TIMESTAMP('2023-03-09 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Deposit at Branch','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '00', 1, 12300, TO_TIMESTAMP('2023-03-09 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Deposit at Branch','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '00', 2, 1000, TO_TIMESTAMP('2023-03-09 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '00', 4, 250, TO_TIMESTAMP('2023-03-09 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Online Shopping','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '00', 3, 500, TO_TIMESTAMP('2023-03-09 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer to account_id 102','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '14', 2, 7000, TO_TIMESTAMP('2023-03-09 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '51', 2, 17000, TO_TIMESTAMP('2023-03-09 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
-- Day 2
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '00', 2, 500, TO_TIMESTAMP('2023-03-10 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '00', 4, 500, TO_TIMESTAMP('2023-03-10 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Online Subscription','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '54', 4, 200, TO_TIMESTAMP('2023-03-10 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Expired Card', 'Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '00', 1, 750, TO_TIMESTAMP('2023-03-10 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Refund from Online Shopping','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '00', 3, 1500, TO_TIMESTAMP('2023-03-10 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer to account_id 103','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '06', 3, 7000, TO_TIMESTAMP('2023-03-10 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Failed');
-- Day 3
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '00', 1, 2500, TO_TIMESTAMP('2023-03-11 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Salary Deposit','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '00', 4, 200, TO_TIMESTAMP('2023-03-11 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '00', 2, 800, TO_TIMESTAMP('2023-03-11 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '00', 4, 300, TO_TIMESTAMP('2023-03-11 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '51', 2, 12000, TO_TIMESTAMP('2023-03-11 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '14', 2, 2000, TO_TIMESTAMP('2023-03-11 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
-- Day 4, 5, 6, and 7
-- Add similar transactions to the above pattern for the remaining days.
-- Day 4
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '00', 1, 650, TO_TIMESTAMP('2023-03-12 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Refund', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '00', 4, 200, TO_TIMESTAMP('2023-03-12 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '00', 2, 300, TO_TIMESTAMP('2023-03-12 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '00', 4, 150, TO_TIMESTAMP('2023-03-12 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '51', 2, 12000, TO_TIMESTAMP('2023-03-12 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '06', 3, 5000, TO_TIMESTAMP('2023-03-12 13:40:00', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Failed');
-- Day 5
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '00', 1, 650, TO_TIMESTAMP('2023-03-13 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Deposit at Branch','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '00', 4, 200, TO_TIMESTAMP('2023-03-13 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '00', 2, 300, TO_TIMESTAMP('2023-03-13 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '00', 4, 150, TO_TIMESTAMP('2023-03-13 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '51', 2, 12000, TO_TIMESTAMP('2023-03-13 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '14', 2, 1000, TO_TIMESTAMP('2023-03-13 20:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
-- Day 6
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '00', 1, 650, TO_TIMESTAMP('2023-03-14 09:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Deposit at Branch','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '00', 4, 200, TO_TIMESTAMP('2023-03-14 10:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '00', 2, 300, TO_TIMESTAMP('2023-03-14 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '00', 4, 150, TO_TIMESTAMP('2023-03-14 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '51', 2, 12000, TO_TIMESTAMP('2023-03-14 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '06', 3, 250, TO_TIMESTAMP('2023-03-14 21:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Failed');
-- Day 7
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '00', 1, 650, current_time - INTERVAL '1' DAY + INTERVAL '9' HOUR, 'Refund', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '00', 4, 200, current_time - INTERVAL '1' DAY + INTERVAL '10' HOUR, 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '00', 2, 300, current_time - INTERVAL '1' DAY + INTERVAL '11' HOUR, 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '00', 4, 150, current_time - INTERVAL '1' DAY + INTERVAL '12' HOUR, 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '51', 2, 12000, current_time - INTERVAL '1' DAY + INTERVAL '13' HOUR, 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '14', 2, 3000, current_time - INTERVAL '1' DAY + INTERVAL '14' HOUR, 'Withdrawal from ATM','Failed');
-- Last hour transactions
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '00', 3, 650, current_time - INTERVAL '1' HOUR + INTERVAL '40' MINUTE, 'Transfer Made', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '00', 4, 200, current_time - INTERVAL '1' HOUR + INTERVAL '45' MINUTE, 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '00', 2, 300, current_time - INTERVAL '1' HOUR + INTERVAL '46' MINUTE, 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '00', 4, 150, current_time - INTERVAL '1' HOUR + INTERVAL '47' MINUTE, 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '51', 2, 12000, current_time - INTERVAL '1' HOUR + INTERVAL '48' MINUTE, 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(101, '00', 1, 1300, current_time - INTERVAL '1' HOUR + INTERVAL '49' MINUTE, 'Deposit at Branch','Completed');

-- Account 2
-- Initial balance: 0
-- Final balance: 15000
-- Day 1
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '00', 1, 17300, TO_TIMESTAMP('2023-03-09 07:23:42', 'YYYY-MM-DD HH24:MI:SS'), 'Deposit at Branch','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '00', 2, 1000, TO_TIMESTAMP('2023-03-09 12:50:47', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '00', 4, 250, TO_TIMESTAMP('2023-03-09 12:56:56', 'YYYY-MM-DD HH24:MI:SS'), 'Online Shopping','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '00', 3, 500, TO_TIMESTAMP('2023-03-09 13:34:59', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '14', 2, 7000, TO_TIMESTAMP('2023-03-09 16:30:43', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '51', 2, 20000, TO_TIMESTAMP('2023-03-09 16:35:00', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
-- Day 2
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '00', 2, 500, TO_TIMESTAMP('2023-03-10 11:57:30', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '00', 4, 500, TO_TIMESTAMP('2023-03-10 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Online Subscription','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '54', 4, 200, TO_TIMESTAMP('2023-03-10 12:21:54', 'YYYY-MM-DD HH24:MI:SS'), 'Expired Card', 'Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '00', 1, 750, TO_TIMESTAMP('2023-03-10 13:03:21', 'YYYY-MM-DD HH24:MI:SS'), 'Refund from Online Shopping','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '00', 3, 1500, TO_TIMESTAMP('2023-03-10 14:19:29', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '06', 3, 7000, TO_TIMESTAMP('2023-03-10 16:51:33', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Failed');
-- Day 3
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '00', 1, 2500, TO_TIMESTAMP('2023-03-11 06:21:20', 'YYYY-MM-DD HH24:MI:SS'), 'Salary Deposit','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '00', 4, 200, TO_TIMESTAMP('2023-03-11 09:02:56', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '00', 2, 800, TO_TIMESTAMP('2023-03-11 11:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '00', 4, 300, TO_TIMESTAMP('2023-03-11 12:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '51', 2, 20000, TO_TIMESTAMP('2023-03-11 13:54:00', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '14', 2, 2000, TO_TIMESTAMP('2023-03-11 21:25:09', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
-- Day 4, 5, 6, and 7
-- Add similar transactions to the above pattern for the remaining days.
-- Day 4
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '00', 1, 650, TO_TIMESTAMP('2023-03-12 13:08:12', 'YYYY-MM-DD HH24:MI:SS'), 'Refund', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '00', 4, 200, TO_TIMESTAMP('2023-03-12 14:15:00', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '00', 2, 300, TO_TIMESTAMP('2023-03-12 16:09:40', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '00', 4, 150, TO_TIMESTAMP('2023-03-12 18:09:00', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '51', 2, 27800, TO_TIMESTAMP('2023-03-12 18:16:00', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '06', 3, 5000, TO_TIMESTAMP('2023-03-12 13:40:00', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Failed');
-- Day 5
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '00', 1, 650, TO_TIMESTAMP('2023-03-13 02:03:50', 'YYYY-MM-DD HH24:MI:SS'), 'Deposit at Branch','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '00', 4, 200, TO_TIMESTAMP('2023-03-13 09:45:51', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '00', 2, 300, TO_TIMESTAMP('2023-03-13 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '00', 4, 150, TO_TIMESTAMP('2023-03-13 15:54:00', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '51', 2, 19870, TO_TIMESTAMP('2023-03-13 16:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '14', 2, 1000, TO_TIMESTAMP('2023-03-13 20:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
-- Day 6
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '00', 1, 650, TO_TIMESTAMP('2023-03-14 13:26:00', 'YYYY-MM-DD HH24:MI:SS'), 'Deposit at Branch','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '00', 4, 200, TO_TIMESTAMP('2023-03-14 13:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '00', 2, 300, TO_TIMESTAMP('2023-03-14 16:17:00', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '00', 4, 150, TO_TIMESTAMP('2023-03-14 17:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '51', 2, 16590, TO_TIMESTAMP('2023-03-14 17:25:00', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '06', 3, 250, TO_TIMESTAMP('2023-03-14 21:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Failed');
-- Day 7
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '00', 1, 650, current_time - INTERVAL '1' DAY - INTERVAL '21' HOUR - INTERVAL '15' MINUTE, 'Refund', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '00', 4, 200, current_time - INTERVAL '1' DAY - INTERVAL '17' HOUR - INTERVAL '14' MINUTE, 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '00', 2, 300, current_time - INTERVAL '1' DAY - INTERVAL '12' HOUR - INTERVAL '10' MINUTE, 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '00', 4, 150, current_time - INTERVAL '1' DAY - INTERVAL '12' HOUR, 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '51', 2, 15500, current_time - INTERVAL '1' DAY - INTERVAL '8' HOUR - INTERVAL '26' MINUTE, 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '14', 2, 3000, current_time - INTERVAL '1' DAY - INTERVAL '8' HOUR - INTERVAL '58' MINUTE, 'Withdrawal from ATM','Failed');
-- Last hour transactions
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '00', 3, 650, current_time - INTERVAL '1' HOUR - INTERVAL '20' MINUTE - INTERVAL '5' SECOND, 'Transfer Made', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '00', 4, 200, current_time - INTERVAL '1' HOUR - INTERVAL '20' MINUTE, 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '00', 2, 300, current_time - INTERVAL '1' HOUR - INTERVAL '18' MINUTE - INTERVAL '30' SECOND, 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '00', 4, 150, current_time - INTERVAL '1' HOUR - INTERVAL '18' MINUTE - INTERVAL '30' SECOND, 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '51', 2, 17980, current_time - INTERVAL '1' HOUR - INTERVAL '17' MINUTE - INTERVAL '55' SECOND, 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(102, '00', 1, 1300, current_time - INTERVAL '1' HOUR - INTERVAL '16' MINUTE - INTERVAL '30' SECOND, 'Deposit at Branch','Completed');
    
-- Account 3
-- Initial balance: 0
-- Final balance: 12000
-- Day 1
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '00', 1, 12800, TO_TIMESTAMP('2023-03-09 08:23:42', 'YYYY-MM-DD HH24:MI:SS'), 'Deposit at Branch','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '00', 2, 1000, TO_TIMESTAMP('2023-03-09 15:50:47', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '00', 4, 250, TO_TIMESTAMP('2023-03-09 17:56:56', 'YYYY-MM-DD HH24:MI:SS'), 'Online Shopping','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '00', 3, 500, TO_TIMESTAMP('2023-03-09 18:34:59', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '14', 2, 7000, TO_TIMESTAMP('2023-03-09 18:39:43', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '51', 2, 20000, TO_TIMESTAMP('2023-03-09 19:35:00', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
-- Day 2
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '00', 2, 500, TO_TIMESTAMP('2023-03-10 12:57:30', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '00', 4, 500, TO_TIMESTAMP('2023-03-10 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Online Subscription','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '54', 4, 200, TO_TIMESTAMP('2023-03-10 13:21:54', 'YYYY-MM-DD HH24:MI:SS'), 'Expired Card', 'Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '00', 1, 750, TO_TIMESTAMP('2023-03-10 13:33:21', 'YYYY-MM-DD HH24:MI:SS'), 'Refund from Online Shopping','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '00', 3, 1500, TO_TIMESTAMP('2023-03-10 14:37:29', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer from account_id 101','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '06', 3, 7000, TO_TIMESTAMP('2023-03-10 19:55:33', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Failed');
-- Day 3
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '00', 1, 2500, TO_TIMESTAMP('2023-03-11 01:24:20', 'YYYY-MM-DD HH24:MI:SS'), 'Salary Deposit','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '00', 4, 200, TO_TIMESTAMP('2023-03-11 12:02:56', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '00', 2, 800, TO_TIMESTAMP('2023-03-11 13:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '00', 4, 300, TO_TIMESTAMP('2023-03-11 13:29:00', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '51', 2, 20000, TO_TIMESTAMP('2023-03-11 13:54:00', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '14', 2, 2000, TO_TIMESTAMP('2023-03-11 21:25:09', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '00', 3, 1500, TO_TIMESTAMP('2023-03-11 23:19:29', 'YYYY-MM-DD HH24:MI:SS'), 'Outward Transfer','Completed');
-- Day 4, 5, 6, and 7
-- Add similar transactions to the above pattern for the remaining days.
-- Day 4
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '00', 1, 650, TO_TIMESTAMP('2023-03-12 14:08:12', 'YYYY-MM-DD HH24:MI:SS'), 'Refund', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '00', 4, 200, TO_TIMESTAMP('2023-03-12 14:15:00', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '00', 2, 300, TO_TIMESTAMP('2023-03-12 15:09:40', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '00', 4, 150, TO_TIMESTAMP('2023-03-12 20:09:00', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '51', 2, 14800, TO_TIMESTAMP('2023-03-12 20:16:00', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '06', 3, 5000, TO_TIMESTAMP('2023-03-12 21:40:00', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Failed');
-- Day 5
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '00', 1, 650, TO_TIMESTAMP('2023-03-13 05:03:50', 'YYYY-MM-DD HH24:MI:SS'), 'Deposit at Branch','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '00', 4, 200, TO_TIMESTAMP('2023-03-13 13:45:51', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '00', 2, 300, TO_TIMESTAMP('2023-03-13 14:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '00', 4, 150, TO_TIMESTAMP('2023-03-13 14:54:00', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '51', 2, 12270, TO_TIMESTAMP('2023-03-13 15:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '14', 2, 1000, TO_TIMESTAMP('2023-03-13 19:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
-- Day 6
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '00', 1, 650, TO_TIMESTAMP('2023-03-14 04:26:00', 'YYYY-MM-DD HH24:MI:SS'), 'Deposit at Branch','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '00', 4, 200, TO_TIMESTAMP('2023-03-14 11:30:00', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '00', 2, 300, TO_TIMESTAMP('2023-03-14 13:17:00', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '00', 4, 150, TO_TIMESTAMP('2023-03-14 19:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '51', 2, 13275, TO_TIMESTAMP('2023-03-14 19:25:00', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '06', 3, 250, TO_TIMESTAMP('2023-03-14 21:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Failed');
-- Day 7
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '00', 1, 650, current_time - INTERVAL '1' DAY - INTERVAL '7' HOUR - INTERVAL '59' MINUTE, 'Refund', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '00', 4, 200, current_time - INTERVAL '1' DAY - INTERVAL '7' HOUR - INTERVAL '58' MINUTE, 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '00', 2, 300, current_time - INTERVAL '1' DAY - INTERVAL '5' HOUR - INTERVAL '54' MINUTE, 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '00', 4, 150, current_time - INTERVAL '1' DAY - INTERVAL '3' HOUR - INTERVAL '44' MINUTE, 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '51', 2, 14000, current_time - INTERVAL '1' DAY - INTERVAL '3' HOUR - INTERVAL '10' MINUTE, 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '14', 2, 3000, current_time - INTERVAL '1' DAY - INTERVAL '1' HOUR - INTERVAL '42' MINUTE, 'Withdrawal from ATM','Failed');

-- Last hour transactions
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '00', 3, 650, current_time - INTERVAL '4' MINUTE, 'Transfer Made', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '00', 4, 200, current_time - INTERVAL '3' MINUTE - INTERVAL '46' SECOND, 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '00', 2, 300, current_time - INTERVAL '2' MINUTE - INTERVAL '40' SECOND, 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '00', 4, 150, current_time - INTERVAL '1' MINUTE, 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '51', 2, 15450, current_time, 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(103, '00', 1, 1300, current_time + INTERVAL '20' SECOND, 'Deposit at Branch','Completed');
    
-- Account 4
-- Initial balance: 0
-- Final balance: 8000
-- Day 1
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '00', 1, 15000, TO_TIMESTAMP('2023-03-09 03:29:42', 'YYYY-MM-DD HH24:MI:SS'), 'Deposit at Branch','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '00', 2, 3000, TO_TIMESTAMP('2023-03-09 04:59:47', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '00', 4, 250, TO_TIMESTAMP('2023-03-09 07:59:16', 'YYYY-MM-DD HH24:MI:SS'), 'Online Shopping','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '00', 3, 500, TO_TIMESTAMP('2023-03-09 10:39:09', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '14', 2, 7000, TO_TIMESTAMP('2023-03-09 11:39:43', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '51', 2, 20000, TO_TIMESTAMP('2023-03-09 14:35:00', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
-- Day 2
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '00', 2, 500, TO_TIMESTAMP('2023-03-10 08:57:30', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '00', 4, 500, TO_TIMESTAMP('2023-03-10 10:10:23', 'YYYY-MM-DD HH24:MI:SS'), 'Online Subscription','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '54', 4, 200, TO_TIMESTAMP('2023-03-10 10:21:54', 'YYYY-MM-DD HH24:MI:SS'), 'Expired Card', 'Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '00', 1, 750, TO_TIMESTAMP('2023-03-10 12:33:21', 'YYYY-MM-DD HH24:MI:SS'), 'Refund from Online Shopping','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '06', 3, 7000, TO_TIMESTAMP('2023-03-10 23:55:33', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Failed');
-- Day 3
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '00', 1, 2500, TO_TIMESTAMP('2023-03-11 08:15:20', 'YYYY-MM-DD HH24:MI:SS'), 'Salary Deposit','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '00', 4, 200, TO_TIMESTAMP('2023-03-11 08:20:56', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '00', 2, 2800, TO_TIMESTAMP('2023-03-11 10:50:20', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '00', 4, 1000, TO_TIMESTAMP('2023-03-11 11:29:39', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '51', 2, 20000, TO_TIMESTAMP('2023-03-11 12:45:21', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '14', 2, 2000, TO_TIMESTAMP('2023-03-11 14:39:29', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '00', 3, 1500, TO_TIMESTAMP('2023-03-11 19:49:19', 'YYYY-MM-DD HH24:MI:SS'), 'Outward Transfer','Completed');
-- Day 4, 5, 6, and 7
-- Add similar transactions to the above pattern for the remaining days.
-- Day 4
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '00', 1, 800, TO_TIMESTAMP('2023-03-12 03:31:22', 'YYYY-MM-DD HH24:MI:SS'), 'Refund', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '00', 4, 200, TO_TIMESTAMP('2023-03-12 13:15:25', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '00', 2, 300, TO_TIMESTAMP('2023-03-12 13:29:40', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '00', 4, 300, TO_TIMESTAMP('2023-03-12 21:34:49', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '51', 2, 14800, TO_TIMESTAMP('2023-03-12 22:16:32', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '06', 3, 5000, TO_TIMESTAMP('2023-03-12 23:40:56', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Failed');
-- Day 5
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '00', 1, 650, TO_TIMESTAMP('2023-03-13 05:55:29', 'YYYY-MM-DD HH24:MI:SS'), 'Deposit at Branch','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '00', 4, 200, TO_TIMESTAMP('2023-03-13 08:51:02', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '00', 2, 300, TO_TIMESTAMP('2023-03-13 10:23:45', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '00', 4, 150, TO_TIMESTAMP('2023-03-13 17:54:43', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '51', 2, 12270, TO_TIMESTAMP('2023-03-13 17:59:09', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '14', 2, 1000, TO_TIMESTAMP('2023-03-13 21:41:25', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
-- Day 6
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '00', 1, 800, TO_TIMESTAMP('2023-03-14 04:26:28', 'YYYY-MM-DD HH24:MI:SS'), 'Deposit at Branch','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '00', 4, 200, TO_TIMESTAMP('2023-03-14 10:30:44', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '00', 2, 300, TO_TIMESTAMP('2023-03-14 13:19:32', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '00', 4, 300, TO_TIMESTAMP('2023-03-14 14:55:34', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '51', 2, 13275, TO_TIMESTAMP('2023-03-14 19:25:32', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '06', 3, 250, TO_TIMESTAMP('2023-03-14 21:29:11', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Failed');
-- Previous Day
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '00', 1, 650, current_time - INTERVAL '1' DAY - INTERVAL '22' HOUR - INTERVAL '15' MINUTE - INTERVAL '10' SECOND, 'Refund', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '00', 4, 200, current_time - INTERVAL '1' DAY - INTERVAL '16' HOUR - INTERVAL '14' MINUTE - INTERVAL '39' SECOND, 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '00', 2, 300, current_time - INTERVAL '1' DAY - INTERVAL '12' HOUR - INTERVAL '49' MINUTE - INTERVAL '26' SECOND, 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '00', 4, 150, current_time - INTERVAL '1' DAY - INTERVAL '8' HOUR - INTERVAL '15' MINUTE - INTERVAL '28' SECOND, 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '51', 2, 14000, current_time - INTERVAL '1' DAY - INTERVAL '6' HOUR - INTERVAL '27' MINUTE - INTERVAL '49' SECOND, 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '14', 2, 3000, current_time - INTERVAL '1' DAY - INTERVAL '3' HOUR - INTERVAL '57' MINUTE - INTERVAL '36' SECOND, 'Withdrawal from ATM','Failed');

-- Last hour transactions
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '00', 3, 800, current_time - INTERVAL '21' MINUTE - INTERVAL '48' SECOND, 'Transfer Made', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '00', 4, 200, current_time - INTERVAL '20' MINUTE - INTERVAL '41' SECOND, 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '00', 2, 300, current_time - INTERVAL '19' MINUTE - INTERVAL '59' SECOND, 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '00', 4, 300, current_time - INTERVAL '18' MINUTE - INTERVAL '1' SECOND, 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '51', 2, 15450, current_time - INTERVAL '17' MINUTE - INTERVAL '15' SECOND, 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(104, '00', 1, 1600, current_time - INTERVAL '12' MINUTE - INTERVAL '36' SECOND, 'Deposit at Branch','Completed');
    
-- Account 5
-- Initial balance: 0
-- Final balance: 25000
-- Day 1
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '00', 1, 31000, TO_TIMESTAMP('2023-03-09 01:39:52', 'YYYY-MM-DD HH24:MI:SS'), 'Deposit at Branch','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '00', 2, 2000, TO_TIMESTAMP('2023-03-09 10:39:47', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '00', 4, 250, TO_TIMESTAMP('2023-03-09 11:29:16', 'YYYY-MM-DD HH24:MI:SS'), 'Online Shopping','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '00', 3, 500, TO_TIMESTAMP('2023-03-09 11:39:59', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '14', 2, 7000, TO_TIMESTAMP('2023-03-09 12:40:47', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '51', 2, 35000, TO_TIMESTAMP('2023-03-09 14:35:21', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
-- Day 2
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '00', 2, 500, TO_TIMESTAMP('2023-03-10 14:57:39', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '00', 4, 500, TO_TIMESTAMP('2023-03-10 15:10:53', 'YYYY-MM-DD HH24:MI:SS'), 'Online Subscription','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '54', 4, 200, TO_TIMESTAMP('2023-03-10 16:54:25', 'YYYY-MM-DD HH24:MI:SS'), 'Expired Card', 'Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '00', 1, 750, TO_TIMESTAMP('2023-03-10 16:59:31', 'YYYY-MM-DD HH24:MI:SS'), 'Refund from Online Shopping','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '06', 3, 7000, TO_TIMESTAMP('2023-03-10 19:12:35', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Failed');
-- Day 3
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '00', 1, 2500, TO_TIMESTAMP('2023-03-11 01:25:09', 'YYYY-MM-DD HH24:MI:SS'), 'Salary Deposit','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '00', 4, 200, TO_TIMESTAMP('2023-03-11 07:09:12', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '00', 2, 2800, TO_TIMESTAMP('2023-03-11 10:15:27', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '00', 4, 1000, TO_TIMESTAMP('2023-03-11 11:49:32', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '51', 2, 35000, TO_TIMESTAMP('2023-03-11 12:41:29', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '14', 2, 2000, TO_TIMESTAMP('2023-03-11 13:55:21', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '00', 3, 1500, TO_TIMESTAMP('2023-03-11 21:23:45', 'YYYY-MM-DD HH24:MI:SS'), 'Outward Transfer','Completed');
-- Day 4, 5, 6, and 7
-- Add similar transactions to the above pattern for the remaining days.
-- Day 4
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '00', 1, 900, TO_TIMESTAMP('2023-03-12 05:52:23', 'YYYY-MM-DD HH24:MI:SS'), 'Refund', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '00', 4, 200, TO_TIMESTAMP('2023-03-12 09:34:21', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '00', 2, 400, TO_TIMESTAMP('2023-03-12 10:29:23', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '00', 4, 300, TO_TIMESTAMP('2023-03-12 19:51:09', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '51', 2, 30000, TO_TIMESTAMP('2023-03-12 22:45:32', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '06', 3, 5000, TO_TIMESTAMP('2023-03-12 23:45:56', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Failed');
-- Day 5
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '00', 1, 650, TO_TIMESTAMP('2023-03-13 09:55:29', 'YYYY-MM-DD HH24:MI:SS'), 'Deposit at Branch','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '00', 4, 200, TO_TIMESTAMP('2023-03-13 11:51:13', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '00', 2, 300, TO_TIMESTAMP('2023-03-13 13:32:46', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '00', 4, 150, TO_TIMESTAMP('2023-03-13 17:45:54', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '51', 2, 56444, TO_TIMESTAMP('2023-03-13 23:01:23', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '14', 2, 1000, TO_TIMESTAMP('2023-03-13 23:34:21', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
-- Day 6
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '00', 1, 900, TO_TIMESTAMP('2023-03-14 13:35:31', 'YYYY-MM-DD HH24:MI:SS'), 'Deposit at Branch','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '00', 4, 200, TO_TIMESTAMP('2023-03-14 13:59:21', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '00', 2, 400, TO_TIMESTAMP('2023-03-14 15:34:21', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '00', 4, 300, TO_TIMESTAMP('2023-03-14 15:55:39', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '51', 2, 34100, TO_TIMESTAMP('2023-03-14 20:23:16', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '06', 3, 250, TO_TIMESTAMP('2023-03-14 21:34:11', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Failed');
-- Previous Day
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '00', 1, 650, current_time - INTERVAL '1' DAY - INTERVAL '22' HOUR - INTERVAL '38' MINUTE - INTERVAL '37' SECOND, 'Refund', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '00', 4, 200, current_time - INTERVAL '1' DAY - INTERVAL '16' HOUR - INTERVAL '10' MINUTE - INTERVAL '9' SECOND, 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '00', 2, 300, current_time - INTERVAL '1' DAY - INTERVAL '12' HOUR - INTERVAL '54' MINUTE - INTERVAL '35' SECOND, 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '00', 4, 150, current_time - INTERVAL '1' DAY - INTERVAL '8' HOUR - INTERVAL '29' MINUTE - INTERVAL '15' SECOND, 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '51', 2, 56000, current_time - INTERVAL '1' DAY - INTERVAL '6' HOUR - INTERVAL '5' MINUTE - INTERVAL '39' SECOND, 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '14', 2, 3000, current_time - INTERVAL '1' DAY - INTERVAL '3' HOUR - INTERVAL '36' MINUTE - INTERVAL '6' SECOND, 'Withdrawal from ATM','Failed');

-- Last hour transactions
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '00', 3, 900, current_time - INTERVAL '21' MINUTE - INTERVAL '49' SECOND, 'Transfer Made', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '00', 4, 200, current_time - INTERVAL '21' MINUTE - INTERVAL '1' SECOND, 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '00', 2, 400, current_time - INTERVAL '20' MINUTE - INTERVAL '19' SECOND, 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '00', 4, 300, current_time - INTERVAL '18' MINUTE - INTERVAL '48' SECOND, 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '51', 2, 32000, current_time - INTERVAL '17' MINUTE - INTERVAL '4' SECOND, 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(105, '00', 1, 1800, current_time - INTERVAL '17' MINUTE - INTERVAL '1' SECOND, 'Deposit at Branch','Completed');
    
-- Account 6
-- Initial balance: 0
-- Final balance: 18000
-- Day 1
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '00', 1, 24000, TO_TIMESTAMP('2023-03-09 04:39:52', 'YYYY-MM-DD HH24:MI:SS'), 'Deposit at Branch','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '00', 2, 2000, TO_TIMESTAMP('2023-03-09 11:39:47', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '00', 4, 250, TO_TIMESTAMP('2023-03-09 11:59:16', 'YYYY-MM-DD HH24:MI:SS'), 'Online Shopping','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '00', 3, 500, TO_TIMESTAMP('2023-03-09 12:39:59', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '14', 2, 7000, TO_TIMESTAMP('2023-03-09 12:50:47', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '51', 2, 35000, TO_TIMESTAMP('2023-03-09 14:35:21', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
-- Day 2
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '00', 2, 500, TO_TIMESTAMP('2023-03-10 15:57:39', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '00', 4, 500, TO_TIMESTAMP('2023-03-10 16:10:53', 'YYYY-MM-DD HH24:MI:SS'), 'Online Subscription','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '54', 4, 200, TO_TIMESTAMP('2023-03-10 16:54:25', 'YYYY-MM-DD HH24:MI:SS'), 'Expired Card', 'Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '00', 1, 750, TO_TIMESTAMP('2023-03-10 17:59:31', 'YYYY-MM-DD HH24:MI:SS'), 'Refund from Online Shopping','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '06', 3, 7000, TO_TIMESTAMP('2023-03-10 20:12:35', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Failed');
-- Day 3
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '00', 1, 2500, TO_TIMESTAMP('2023-03-11 10:25:09', 'YYYY-MM-DD HH24:MI:SS'), 'Salary Deposit','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '00', 4, 200, TO_TIMESTAMP('2023-03-11 12:09:12', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '00', 2, 2800, TO_TIMESTAMP('2023-03-11 13:15:27', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '00', 4, 1000, TO_TIMESTAMP('2023-03-11 17:49:32', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '51', 2, 35000, TO_TIMESTAMP('2023-03-11 18:41:29', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '14', 2, 2000, TO_TIMESTAMP('2023-03-11 19:55:21', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '00', 3, 1500, TO_TIMESTAMP('2023-03-11 20:24:45', 'YYYY-MM-DD HH24:MI:SS'), 'Outward Transfer','Completed');
-- Day 4, 5, 6, and 7
-- Add similar transactions to the above pattern for the remaining days.
-- Day 4
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '00', 1, 900, TO_TIMESTAMP('2023-03-12 02:52:23', 'YYYY-MM-DD HH24:MI:SS'), 'Refund', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '00', 4, 200, TO_TIMESTAMP('2023-03-12 05:34:21', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '00', 2, 400, TO_TIMESTAMP('2023-03-12 09:29:23', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '00', 4, 300, TO_TIMESTAMP('2023-03-12 10:51:09', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '51', 2, 30000, TO_TIMESTAMP('2023-03-12 20:45:32', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '06', 3, 5000, TO_TIMESTAMP('2023-03-12 22:21:56', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Failed');
-- Day 5
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '00', 1, 650, TO_TIMESTAMP('2023-03-13 05:55:29', 'YYYY-MM-DD HH24:MI:SS'), 'Deposit at Branch','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '00', 4, 200, TO_TIMESTAMP('2023-03-13 10:51:13', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '00', 2, 300, TO_TIMESTAMP('2023-03-13 14:32:46', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '00', 4, 150, TO_TIMESTAMP('2023-03-13 16:45:54', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '51', 2, 56444, TO_TIMESTAMP('2023-03-13 20:01:23', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '14', 2, 1000, TO_TIMESTAMP('2023-03-13 22:34:21', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
-- Day 6
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '00', 1, 900, TO_TIMESTAMP('2023-03-14 00:35:31', 'YYYY-MM-DD HH24:MI:SS'), 'Deposit at Branch','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '00', 4, 200, TO_TIMESTAMP('2023-03-14 05:59:21', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '00', 2, 400, TO_TIMESTAMP('2023-03-14 11:34:21', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '00', 4, 300, TO_TIMESTAMP('2023-03-14 15:55:39', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '51', 2, 34100, TO_TIMESTAMP('2023-03-14 22:23:16', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '06', 3, 250, TO_TIMESTAMP('2023-03-14 23:34:11', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Failed');
-- Previous Day
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '00', 1, 650, current_time - INTERVAL '1' DAY - INTERVAL '18' HOUR - INTERVAL '38' MINUTE - INTERVAL '37' SECOND, 'Refund', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '00', 4, 200, current_time - INTERVAL '1' DAY - INTERVAL '11' HOUR - INTERVAL '10' MINUTE - INTERVAL '9' SECOND, 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '00', 2, 300, current_time - INTERVAL '1' DAY - INTERVAL '7' HOUR - INTERVAL '54' MINUTE - INTERVAL '35' SECOND, 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '00', 4, 150, current_time - INTERVAL '1' DAY - INTERVAL '5' HOUR - INTERVAL '29' MINUTE - INTERVAL '15' SECOND, 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '51', 2, 56000, current_time - INTERVAL '1' DAY - INTERVAL '6' HOUR - INTERVAL '5' MINUTE - INTERVAL '39' SECOND, 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '14', 2, 3000, current_time - INTERVAL '1' DAY - INTERVAL '1' HOUR - INTERVAL '36' MINUTE - INTERVAL '6' SECOND, 'Withdrawal from ATM','Failed');

-- Last hour transactions
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '00', 3, 900, current_time - INTERVAL '21' MINUTE - INTERVAL '59' SECOND, 'Transfer Made', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '00', 4, 200, current_time - INTERVAL '21' MINUTE - INTERVAL '5' SECOND, 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '00', 2, 400, current_time - INTERVAL '20' MINUTE - INTERVAL '49' SECOND, 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '00', 4, 300, current_time - INTERVAL '18' MINUTE - INTERVAL '48' SECOND, 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '51', 2, 32000, current_time - INTERVAL '17' MINUTE - INTERVAL '15' SECOND, 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(106, '00', 1, 1800, current_time - INTERVAL '11' MINUTE - INTERVAL '36' SECOND, 'Deposit at Branch','Completed');
    
-- Account 7
-- Initial balance: 0
-- Final balance: 9000
-- Day 1
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '00', 1, 16000, TO_TIMESTAMP('2023-03-09 01:39:52', 'YYYY-MM-DD HH24:MI:SS'), 'Deposit at Branch','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '00', 2, 3000, TO_TIMESTAMP('2023-03-09 10:39:47', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '00', 4, 250, TO_TIMESTAMP('2023-03-09 11:29:16', 'YYYY-MM-DD HH24:MI:SS'), 'Online Shopping','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '00', 3, 500, TO_TIMESTAMP('2023-03-09 11:39:59', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '14', 2, 7000, TO_TIMESTAMP('2023-03-09 12:40:47', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '51', 2, 35000, TO_TIMESTAMP('2023-03-09 14:35:21', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
-- Day 2
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '00', 2, 500, TO_TIMESTAMP('2023-03-10 14:57:39', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '00', 4, 500, TO_TIMESTAMP('2023-03-10 15:10:53', 'YYYY-MM-DD HH24:MI:SS'), 'Online Subscription','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '54', 4, 200, TO_TIMESTAMP('2023-03-10 16:54:25', 'YYYY-MM-DD HH24:MI:SS'), 'Expired Card', 'Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '00', 1, 750, TO_TIMESTAMP('2023-03-10 16:59:31', 'YYYY-MM-DD HH24:MI:SS'), 'Refund from Online Shopping','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '06', 3, 7000, TO_TIMESTAMP('2023-03-10 19:12:35', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Failed');
-- Day 3
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '00', 1, 2500, TO_TIMESTAMP('2023-03-11 01:25:09', 'YYYY-MM-DD HH24:MI:SS'), 'Salary Deposit','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '00', 4, 200, TO_TIMESTAMP('2023-03-11 07:09:12', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '00', 2, 2800, TO_TIMESTAMP('2023-03-11 10:15:27', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '00', 4, 1000, TO_TIMESTAMP('2023-03-11 11:49:32', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '51', 2, 35000, TO_TIMESTAMP('2023-03-11 12:41:29', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '14', 2, 2000, TO_TIMESTAMP('2023-03-11 13:55:21', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '00', 3, 1500, TO_TIMESTAMP('2023-03-11 21:23:45', 'YYYY-MM-DD HH24:MI:SS'), 'Outward Transfer','Completed');
-- Day 4, 5, 6, and 7
-- Add similar transactions to the above pattern for the remaining days.
-- Day 4
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '00', 1, 900, TO_TIMESTAMP('2023-03-12 05:52:23', 'YYYY-MM-DD HH24:MI:SS'), 'Refund', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '00', 4, 200, TO_TIMESTAMP('2023-03-12 09:34:21', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '00', 2, 400, TO_TIMESTAMP('2023-03-12 10:29:23', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '00', 4, 300, TO_TIMESTAMP('2023-03-12 19:51:09', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '51', 2, 30000, TO_TIMESTAMP('2023-03-12 22:45:32', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '06', 3, 5000, TO_TIMESTAMP('2023-03-12 23:45:56', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Failed');
-- Day 5
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '00', 1, 650, TO_TIMESTAMP('2023-03-13 09:55:29', 'YYYY-MM-DD HH24:MI:SS'), 'Deposit at Branch','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '00', 4, 200, TO_TIMESTAMP('2023-03-13 11:51:13', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '00', 2, 300, TO_TIMESTAMP('2023-03-13 13:32:46', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '00', 4, 150, TO_TIMESTAMP('2023-03-13 17:45:54', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '51', 2, 56444, TO_TIMESTAMP('2023-03-13 23:01:23', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '14', 2, 1000, TO_TIMESTAMP('2023-03-13 23:34:21', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
-- Day 6
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '00', 1, 900, TO_TIMESTAMP('2023-03-14 13:35:31', 'YYYY-MM-DD HH24:MI:SS'), 'Deposit at Branch','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '00', 4, 200, TO_TIMESTAMP('2023-03-14 13:59:21', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '00', 2, 400, TO_TIMESTAMP('2023-03-14 15:34:21', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '00', 4, 300, TO_TIMESTAMP('2023-03-14 15:55:39', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '51', 2, 34100, TO_TIMESTAMP('2023-03-14 20:23:16', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '06', 3, 250, TO_TIMESTAMP('2023-03-14 21:34:11', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Failed');
-- Previous Day
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '00', 1, 650, current_time - INTERVAL '1' DAY - INTERVAL '18' HOUR - INTERVAL '38' MINUTE - INTERVAL '37' SECOND, 'Refund', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '00', 4, 200, current_time - INTERVAL '1' DAY - INTERVAL '11' HOUR - INTERVAL '10' MINUTE - INTERVAL '9' SECOND, 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '00', 2, 300, current_time - INTERVAL '1' DAY - INTERVAL '7' HOUR - INTERVAL '54' MINUTE - INTERVAL '35' SECOND, 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '00', 4, 150, current_time - INTERVAL '1' DAY - INTERVAL '5' HOUR - INTERVAL '29' MINUTE - INTERVAL '15' SECOND, 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '51', 2, 56000, current_time - INTERVAL '1' DAY - INTERVAL '6' HOUR - INTERVAL '5' MINUTE - INTERVAL '39' SECOND, 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '14', 2, 3000, current_time - INTERVAL '1' DAY - INTERVAL '1' HOUR - INTERVAL '36' MINUTE - INTERVAL '6' SECOND, 'Withdrawal from ATM','Failed');

-- Last hour transactions
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '00', 3, 1500, current_time - INTERVAL '22' MINUTE - INTERVAL '54' SECOND, 'Transfer Made', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '00', 4, 500, current_time - INTERVAL '20' MINUTE - INTERVAL '51' SECOND, 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '00', 2, 600, current_time - INTERVAL '16' MINUTE - INTERVAL '20' SECOND, 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '00', 4, 400, current_time - INTERVAL '14' MINUTE - INTERVAL '41' SECOND, 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '51', 2, 32000, current_time - INTERVAL '13' MINUTE - INTERVAL '49' SECOND, 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(107, '00', 1, 3000, current_time - INTERVAL '11' MINUTE - INTERVAL '36' SECOND, 'Deposit at Branch','Completed');
    
-- Account 8
-- Initial balance: 0
-- Final balance: 30000
-- Day 1
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '00', 1, 36000, TO_TIMESTAMP('2023-03-09 11:39:52', 'YYYY-MM-DD HH24:MI:SS'), 'Deposit at Branch','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '00', 2, 2000, TO_TIMESTAMP('2023-03-09 14:39:47', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '00', 4, 250, TO_TIMESTAMP('2023-03-09 16:29:16', 'YYYY-MM-DD HH24:MI:SS'), 'Online Shopping','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '00', 3, 500, TO_TIMESTAMP('2023-03-09 16:39:59', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '14', 2, 7000, TO_TIMESTAMP('2023-03-09 18:40:47', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '51', 2, 40000, TO_TIMESTAMP('2023-03-09 23:35:21', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
-- Day 2
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '00', 2, 500, TO_TIMESTAMP('2023-03-10 11:57:39', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '00', 4, 500, TO_TIMESTAMP('2023-03-10 16:10:53', 'YYYY-MM-DD HH24:MI:SS'), 'Online Subscription','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '54', 4, 200, TO_TIMESTAMP('2023-03-10 16:54:25', 'YYYY-MM-DD HH24:MI:SS'), 'Expired Card', 'Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '00', 1, 750, TO_TIMESTAMP('2023-03-10 17:59:31', 'YYYY-MM-DD HH24:MI:SS'), 'Refund from Online Shopping','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '06', 3, 7000, TO_TIMESTAMP('2023-03-10 19:12:35', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Failed');
-- Day 3
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '00', 1, 2500, TO_TIMESTAMP('2023-03-11 01:25:09', 'YYYY-MM-DD HH24:MI:SS'), 'Salary Deposit','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '00', 4, 200, TO_TIMESTAMP('2023-03-11 10:09:12', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '00', 2, 2800, TO_TIMESTAMP('2023-03-11 15:15:27', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '00', 4, 1000, TO_TIMESTAMP('2023-03-11 16:49:32', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '51', 2, 45000, TO_TIMESTAMP('2023-03-11 20:41:29', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '14', 2, 2000, TO_TIMESTAMP('2023-03-11 22:55:21', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '00', 3, 1500, TO_TIMESTAMP('2023-03-11 23:23:45', 'YYYY-MM-DD HH24:MI:SS'), 'Outward Transfer','Completed');
-- Day 4, 5, 6, and 7
-- Add similar transactions to the above pattern for the remaining days.
-- Day 4
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '00', 1, 900, TO_TIMESTAMP('2023-03-12 00:52:23', 'YYYY-MM-DD HH24:MI:SS'), 'Refund', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '00', 4, 200, TO_TIMESTAMP('2023-03-12 09:34:21', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '00', 2, 400, TO_TIMESTAMP('2023-03-12 10:29:23', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '00', 4, 300, TO_TIMESTAMP('2023-03-12 20:51:09', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '51', 2, 56000, TO_TIMESTAMP('2023-03-12 21:45:32', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '06', 3, 5000, TO_TIMESTAMP('2023-03-12 23:45:56', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Failed');
-- Day 5
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '00', 1, 650, TO_TIMESTAMP('2023-03-13 11:55:29', 'YYYY-MM-DD HH24:MI:SS'), 'Deposit at Branch','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '00', 4, 200, TO_TIMESTAMP('2023-03-13 15:51:13', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '00', 2, 300, TO_TIMESTAMP('2023-03-13 17:32:46', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '00', 4, 150, TO_TIMESTAMP('2023-03-13 17:45:54', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '51', 2, 56444, TO_TIMESTAMP('2023-03-13 20:01:23', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '14', 2, 1000, TO_TIMESTAMP('2023-03-13 21:34:21', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
-- Day 6
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '00', 1, 900, TO_TIMESTAMP('2023-03-14 03:35:31', 'YYYY-MM-DD HH24:MI:SS'), 'Deposit at Branch','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '00', 4, 200, TO_TIMESTAMP('2023-03-14 09:59:21', 'YYYY-MM-DD HH24:MI:SS'), 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '00', 2, 400, TO_TIMESTAMP('2023-03-14 20:34:21', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '00', 4, 300, TO_TIMESTAMP('2023-03-14 21:55:39', 'YYYY-MM-DD HH24:MI:SS'), 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '51', 2, 43000, TO_TIMESTAMP('2023-03-14 22:23:16', 'YYYY-MM-DD HH24:MI:SS'), 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '06', 3, 250, TO_TIMESTAMP('2023-03-14 22:34:11', 'YYYY-MM-DD HH24:MI:SS'), 'Transfer', 'Failed');
-- Previous Day
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '00', 1, 650, current_time - INTERVAL '1' DAY - INTERVAL '18' HOUR - INTERVAL '38' MINUTE - INTERVAL '37' SECOND, 'Refund', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '00', 4, 200, current_time - INTERVAL '1' DAY - INTERVAL '8' HOUR - INTERVAL '10' MINUTE - INTERVAL '9' SECOND, 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '00', 2, 300, current_time - INTERVAL '1' DAY - INTERVAL '7' HOUR - INTERVAL '54' MINUTE - INTERVAL '35' SECOND, 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '00', 4, 150, current_time - INTERVAL '1' DAY - INTERVAL '3' HOUR - INTERVAL '29' MINUTE - INTERVAL '15' SECOND, 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '51', 2, 56000, current_time - INTERVAL '1' DAY - INTERVAL '2' HOUR - INTERVAL '5' MINUTE - INTERVAL '39' SECOND, 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '14', 2, 3000, current_time - INTERVAL '1' DAY - INTERVAL '23' MINUTE - INTERVAL '6' SECOND, 'Withdrawal from ATM','Failed');

-- Last hour transactions
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '00', 3, 1200, current_time - INTERVAL '22' MINUTE - INTERVAL '49' SECOND, 'Transfer Made', 'Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '00', 4, 600, current_time - INTERVAL '21' MINUTE - INTERVAL '1' SECOND, 'Utility Bill Payment','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '00', 2, 400, current_time - INTERVAL '20' MINUTE - INTERVAL '18' SECOND, 'Withdrawal from ATM','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '00', 4, 200, current_time - INTERVAL '15' MINUTE - INTERVAL '48' SECOND, 'Mobile Recharge','Completed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '51', 2, 32000, current_time - INTERVAL '14' MINUTE - INTERVAL '4' SECOND, 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '14', 2, 2000, current_time - INTERVAL '13' MINUTE - INTERVAL '59' SECOND, 'Withdrawal from ATM','Failed');
    TRANSACTION_MGMT_PKG.ADD_TRANSACTION(108, '00', 1, 2400, current_time - INTERVAL '11' MINUTE - INTERVAL '36' SECOND, 'Deposit at Branch','Completed');