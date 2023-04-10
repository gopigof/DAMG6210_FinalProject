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