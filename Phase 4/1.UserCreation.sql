-------------------------------------------------------------------------------------------
SET SERVEROUTPUT ON;

BEGIN
    FOR s IN (SELECT sid, serial# FROM v$session WHERE username = 'DATABASE_ADMIN') LOOP
        DBMS_OUTPUT.PUT_LINE('Killing session: ' || s.sid || ',' || s.serial#);
        EXECUTE IMMEDIATE 'ALTER SYSTEM KILL SESSION ''' || s.sid || ',' || s.serial# || ''' IMMEDIATE';
    END LOOP;
END;
/

-- Kill sessions for customer_user
BEGIN
    FOR s IN (SELECT sid, serial# FROM v$session WHERE username = 'CUSTOMER_USER') LOOP
        DBMS_OUTPUT.PUT_LINE('Killing session: ' || s.sid || ',' || s.serial#);
        EXECUTE IMMEDIATE 'ALTER SYSTEM KILL SESSION ''' || s.sid || ',' || s.serial# || ''' IMMEDIATE';
    END LOOP;
END;
/

-- Kill sessions for manager_user
BEGIN
    FOR s IN (SELECT sid, serial# FROM v$session WHERE username = 'MANAGER_USER') LOOP
        DBMS_OUTPUT.PUT_LINE('Killing session: ' || s.sid || ',' || s.serial#);
        EXECUTE IMMEDIATE 'ALTER SYSTEM KILL SESSION ''' || s.sid || ',' || s.serial# || ''' IMMEDIATE';
    END LOOP;
END;
/

-- Kill sessions for employee_user
BEGIN
    FOR s IN (SELECT sid, serial# FROM v$session WHERE username = 'EMPLOYEE_USER') LOOP
        DBMS_OUTPUT.PUT_LINE('Killing session: ' || s.sid || ',' || s.serial#);
        EXECUTE IMMEDIATE 'ALTER SYSTEM KILL SESSION ''' || s.sid || ',' || s.serial# || ''' IMMEDIATE';
    END LOOP;
END;
/

-- Drop the user if already exists
BEGIN
    EXECUTE IMMEDIATE 'DROP USER database_admin CASCADE';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -1918 THEN
            RAISE;
        END IF;
END;
/

-- Drop the user if already exists
BEGIN
    EXECUTE IMMEDIATE 'DROP USER customer_user CASCADE';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -1918 THEN
            RAISE;
        END IF;
END;
/

-- Drop the user if already exists
BEGIN
    EXECUTE IMMEDIATE 'DROP USER manager_user CASCADE';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -1918 THEN
            RAISE;
        END IF;
END;
/

-- Drop the user if already exists
BEGIN
    EXECUTE IMMEDIATE 'DROP USER employee_user CASCADE';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -1918 THEN
            RAISE;
        END IF;
END;
/

-- Create a new user named 'database_admin' and set a password
CREATE USER database_admin IDENTIFIED BY DatabaseAdmin12;

-- Create Customer role
CREATE USER customer_user IDENTIFIED BY CustomerPasscode1234$;

-- Create Manager role
CREATE USER manager_user IDENTIFIED BY ManagerPasscode1234$;

-- Create Employee role
CREATE USER employee_user IDENTIFIED BY EmployeePasscode1234$;


-- Grant the user the ability to connect to the database
GRANT CONNECT TO database_admin;

GRANT CONNECT TO customer_user;

GRANT CONNECT TO manager_user;

GRANT CONNECT TO employee_user;

-- Grant the user the ability to create sessions, tables, and sequences
GRANT CREATE SESSION, CREATE TABLE, CREATE SEQUENCE TO database_admin;

GRANT CREATE SESSION TO customer_user;

GRANT CREATE SESSION TO manager_user;

GRANT CREATE SESSION TO employee_user;

-- Grant the user the ability to drop any table and sequence
GRANT DROP ANY TABLE, DROP ANY SEQUENCE TO database_admin;
 
BEGIN
    FOR t IN (SELECT table_name FROM all_tables WHERE owner = 'DATABASE_ADMIN') LOOP
        EXECUTE IMMEDIATE 'GRANT ALL PRIVILEGES ON DATABASE_ADMIN.' || t.table_name || ' TO database_admin';
    END LOOP;
END;
/

-- Grant the user unlimited tablespace quota
GRANT UNLIMITED TABLESPACE TO database_admin;

GRANT UNLIMITED TABLESPACE TO manager_user;

GRANT UNLIMITED TABLESPACE TO employee_user;

GRANT CREATE VIEW TO database_admin;

GRANT CREATE PROCEDURE TO database_admin;

GRANT CREATE TRIGGER TO database_admin;

-- Save the changes to the database
COMMIT;
-------------------------------------------------------------------------------------------