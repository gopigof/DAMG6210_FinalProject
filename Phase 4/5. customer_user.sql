SET SERVEROUTPUT ON;

BEGIN
   DATABASE_ADMIN.CUSTOMER_PKG.view_customer_info(1800);
END;
/

BEGIN
   DATABASE_ADMIN.CUSTOMER_PKG.view_accounts(1800);
END;
/

BEGIN
   DATABASE_ADMIN.CUSTOMER_PKG.view_loans(1800);
END;
/

BEGIN
   DATABASE_ADMIN.CUSTOMER_PKG.view_transactions(1800);
END;
/

BEGIN
   DATABASE_ADMIN.CUSTOMER_PKG.view_transactions_by_account_id_only(116);
END;
/

BEGIN
   DATABASE_ADMIN.CUSTOMER_PKG.view_latest_5_transactions(116);
END;
/

BEGIN
   DATABASE_ADMIN.CUSTOMER_PKG.view_last_transaction(116);
END;
/

BEGIN
   DATABASE_ADMIN.CUSTOMER_PKG.view_customer_latest_5_transactions(1800);
END;
/

BEGIN
   DATABASE_ADMIN.CUSTOMER_PKG.view_customer_last_transaction(1800);
END;
/
