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