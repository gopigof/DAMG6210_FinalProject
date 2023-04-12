SET SERVEROUTPUT ON;

BEGIN
    DATABASE_ADMIN.EMPLOYEE_PKG.VIEW_EMPLOYEE_DETAILS(638); --mention employee_id
END;
/

BEGIN
    DATABASE_ADMIN.EMPLOYEE_PKG.VIEW_CUSTOMERS(611); --mention employee_id. Only customer and their respective accounts present in the employee's branch will be displayed
END;
/

BEGIN
    DATABASE_ADMIN.EMPLOYEE_PKG.VIEW_CUSTOMER_BY_ID(611, 1825); --input employee_id and customer_id to retrieve the accounts details if that customer has an account in the employee branch
END;
/

BEGIN
    DATABASE_ADMIN.EMPLOYEE_PKG.EMP_INSERT_CUSTOMER('Rey', 'sky', TO_DATE('1990-09-20', 'YYYY-MM-DD'), 'rey.sky@email.com', '9696969699',
        TO_DATE('2023-01-05', 'YYYY-MM-DD'), 55000, 'janedoe', 'def123xyz456', '234 Elm St', 'Boston', 'Massachusetts');
END;
/

BEGIN
    DATABASE_ADMIN.EMPLOYEE_PKG.INSERT_ACCOUNT(
        P_EMPLOYEE_ID => 623, -- Replace with the employee_id
        P_CUSTOMER_ID => 1850, -- Replace with the customer_id
        P_ACCOUNT_TYPE => 2, -- Replace with the account_type_id
        P_CREATED_DATE => SYSDATE,
        P_BALANCE => 10000,
        P_CARD_DETAILS => 1234567890, -- Replace with the card_details
        P_PROOF => 'Passport'
    );
END;
/


BEGIN
    DATABASE_ADMIN.EMPLOYEE_PKG.UPDATE_CUSTOMER(
        P_EMPLOYEE_ID => 623,
        P_CUSTOMER_ID => 1850, -- Replace with the customer_id you want to update
        P_PHONE_NUMBER => '3244459789'
    );
END;
/

BEGIN
    DATABASE_ADMIN.EMPLOYEE_PKG.VIEW_ACCOUNTS(608);
END;
/


BEGIN
    DATABASE_ADMIN.EMPLOYEE_PKG.UPDATE_ACCOUNT(
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
    DATABASE_ADMIN.EMPLOYEE_PKG.VIEW_TRANSACTIONS(P_EMPLOYEE_ID => 623); -- Replace with the employee_id
END;
/

BEGIN
    DATABASE_ADMIN.EMPLOYEE_PKG.INSERT_TRANSACTION(
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
    DATABASE_ADMIN.EMPLOYEE_PKG.VIEW_LOANS(P_EMPLOYEE_ID => 623); -- Replace with the employee_id
END;
/

BEGIN
    DATABASE_ADMIN.EMPLOYEE_PKG.ADD_LOAN(623, 1850, 1, 15000, 6.0, 48, TO_DATE('2023-01-15', 'YYYY-MM-DD'));
END;
/

BEGIN
   DATABASE_ADMIN.EMPLOYEE_PKG.DELETE_CUSTOMER_ACCOUNT(115,617);
END;
/

COMMIT;