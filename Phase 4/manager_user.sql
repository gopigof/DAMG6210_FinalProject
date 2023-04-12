SET SERVEROUTPUT ON;

BEGIN
    DATABASE_ADMIN.MANAGER_PKG.VIEW_EMPLOYEE_DETAILS(620); --mention employee_id
END;
/

BEGIN
    DATABASE_ADMIN.MANAGER_PKG.VIEW_CUSTOMERS(608); --mention employee_id. Only customer and their respective accounts present in the employee's branch will be displayed
END;
/

BEGIN
    DATABASE_ADMIN.MANAGER_PKG.VIEW_CUSTOMER_BY_ID(620, 1850); --input employee_id and customer_id to retrieve the accounts details if that customer has an account in the employee branch
END;
/

BEGIN
    DATABASE_ADMIN.MANAGER_PKG.INSERT_CUSTOMER('Kylo', 'Ren', TO_DATE('1990-09-20', 'YYYY-MM-DD'), 'kylo.ren@email.com', '4204204201',
        TO_DATE('2023-01-05', 'YYYY-MM-DD'), 55000, 'kyloren', 'def123xyz456', '234 Elm St', 'Boston', 'Massachusetts');
END;
/

BEGIN
    DATABASE_ADMIN.MANAGER_PKG.INSERT_ACCOUNT(
        P_EMPLOYEE_ID => 620, -- Replace with the employee_id
        P_CUSTOMER_ID => 1855, -- Replace with the customer_id
        P_ACCOUNT_TYPE => 2, -- Replace with the account_type_id
        P_CREATED_DATE => SYSDATE,
        P_BALANCE => 10000,
        P_CARD_DETAILS => 1231214355, -- Replace with the card_details
        P_PROOF => 'Passport'
    );
END;
/


BEGIN
    DATABASE_ADMIN.MANAGER_PKG.UPDATE_CUSTOMER(
        P_EMPLOYEE_ID => 620,
        P_CUSTOMER_ID => 1805, -- Replace with the customer_id you want to update
        P_PHONE_NUMBER => '3244459789'
    );
END;
/

BEGIN
    DATABASE_ADMIN.MANAGER_PKG.VIEW_ACCOUNTS(608);
END;
/


BEGIN
    DATABASE_ADMIN.MANAGER_PKG.UPDATE_ACCOUNT(
        P_EMPLOYEE_ID => 623, -- Replace with a valid employee_id
        P_ACCOUNT_ID => 101, -- Replace with a valid account_id
        P_ACCOUNT_TYPE => 4, -- Replace with a valid account_type_id (or NULL to keep the existing value)
        P_BALANCE => 15000, -- Replace with a new balance (or NULL to keep the existing value)
        P_CARD_DETAILS => 1234567891, -- Replace with new card_details (or NULL to keep the existing value)
        P_PROOF => 'Driver License' -- Replace with a new proof (or NULL to keep the existing value)
    );
END;
/

BEGIN
    DBMS_OUTPUT.ENABLE(1000000);
END;
/


BEGIN
    DATABASE_ADMIN.MANAGER_PKG.VIEW_TRANSACTIONS(P_EMPLOYEE_ID => 623); -- Replace with the employee_id
END;
/

BEGIN
    DATABASE_ADMIN.MANAGER_PKG.INSERT_TRANSACTION(
        P_EMPLOYEE_ID => 623, -- Replace with the employee_id
        P_ACCOUNT_ID => 101, -- Replace with the account_id
        P_STATUS_CODE => '00', -- Replace with the status_code
        P_TRANSACTION_TYPE => 1, -- Replace with the transaction_type_id
        P_AMOUNT => 1000,
        P_TIME_STAMP => SYSTIMESTAMP,
        P_TRANSACTION_DETAILS => 'Online Shopping',
        P_STATUS => 'Completed'
    );
END;
/

BEGIN
    DATABASE_ADMIN.MANAGER_PKG.VIEW_LOANS(P_EMPLOYEE_ID => 623); -- Replace with the employee_id
END;
/

BEGIN
    DATABASE_ADMIN.MANAGER_PKG.ADD_LOAN(623, 1855, 1, 15000, 6.0, 48, TO_DATE('2023-01-15', 'YYYY-MM-DD'));
END;
/

BEGIN
   DATABASE_ADMIN.MANAGER_PKG.ADD_EMPLOYEE(
        P_EMPLOYEE_ID => 620,
        P_BRANCH_ID => 3601,
        P_ROLE_ID => 1,
        P_FIRST_NAME => 'Luke',
        P_LAST_NAME => 'Skywalker',
        P_DATE_OF_BIRTH => TO_DATE('1994-11-05', 'YYYY-MM-DD'),
        P_EMAIL_ID => 'darthson@gmail.com',
        P_PHONE_NUMBER => '5555544444',
        P_DATE_REGISTERED => TO_DATE('2023-01-20', 'YYYY-MM-DD'),
        P_LOGIN => 'lukesky',
        P_PASSWORD_HASH => 'abcdefg123123',
        P_ADDRESS => '980 Elm St',
        P_CITY => 'Boston',
        P_STATE_NAME => 'Massachusetts',
        P_MANAGER_ID => 620);
END;
/

BEGIN
   DATABASE_ADMIN.MANAGER_PKG.ADD_EMPLOYEE(
        P_EMPLOYEE_ID => 620,
        P_BRANCH_ID => 3600,
        P_ROLE_ID => 1,
        P_FIRST_NAME => 'Luke',
        P_LAST_NAME => 'Skywalker',
        P_DATE_OF_BIRTH => TO_DATE('1994-11-05', 'YYYY-MM-DD'),
        P_EMAIL_ID => 'darthson@gmail.com',
        P_PHONE_NUMBER => '5555544444',
        P_DATE_REGISTERED => TO_DATE('2023-01-20', 'YYYY-MM-DD'),
        P_LOGIN => 'lukesky',
        P_PASSWORD_HASH => 'abcdefg123123',
        P_ADDRESS => '980 Elm St',
        P_CITY => 'Boston',
        P_STATE_NAME => 'Massachusetts',
        P_MANAGER_ID => 620);
END;
/

BEGIN
   DATABASE_ADMIN.MANAGER_PKG.UPDATE_EMPLOYEE(
        P_EMPLOYEE_ID => 620,
        P_TARGET_EMPLOYEE_ID => 608,
        P_LOGIN => 'luketest');
END;
/

BEGIN
   DATABASE_ADMIN.MANAGER_PKG.DELETE_CUSTOMER_ACCOUNT(102,623);
END;
/

BEGIN
   DATABASE_ADMIN.MANAGER_PKG.DELETE_EMPLOYEE(620,623);
END;
/

COMMIT;