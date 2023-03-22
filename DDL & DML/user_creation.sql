-- Create Admin role
CREATE USER admin_user IDENTIFIED BY AdminPasscod1234$;

-- Create Customer role
CREATE USER customer_user IDENTIFIED BY CustomerPasscod1234$;

-- Create Manager role
CREATE USER manager_user IDENTIFIED BY ManagerPasscod1234$;

-- Create Employee role
CREATE USER employee_user IDENTIFIED BY EmployeePasscod1234$;

-- Grant privilege to create sessions
DECLARE
    users_list SYS.DBMS_DEBUG_VC2COLL := SYS.DBMS_DEBUG_VC2COLL('admin_user', 'customer_user', 'manager_user', 'employee_user');
BEGIN
    FOR i IN users_list.FIRST..users_list.LAST LOOP
        EXECUTE IMMEDIATE('GRANT CREATE SESSION TO ' || users_list(i));
        EXECUTE IMMEDIATE('GRANT CONNECT TO ' || users_list(i));
    END LOOP;
END;


-- Grant unlimited size to upper roles
GRANT UNLIMITED TABLESPACE TO admin_user;
GRANT UNLIMITED TABLESPACE TO manager_user;
GRANT UNLIMITED TABLESPACE TO employee_user;


-- Create a new user named 'database_admin' and set a password
CREATE USER database_admin IDENTIFIED BY DatabaseAdmin12;

-- Grant the user the ability to connect to the database
GRANT CONNECT TO database_admin;

-- Grant the user the ability to create sessions, tables, and sequences
GRANT CREATE SESSION, CREATE TABLE, CREATE SEQUENCE TO database_admin;

-- Grant the user the ability to drop any table and sequence
GRANT DROP ANY TABLE, DROP ANY SEQUENCE TO database_admin;
COMMIT;