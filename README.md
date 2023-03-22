# Bank Management System - DAMG6210 Final Project


## Submission 3
### Execution Instructions
- The folder [Phase 3 Submission](Phase%203%20Submission) contains two SQL scripts that create users, sequences, tables, and views. It also handles all the required cleanup activities along with user privilege grants.
- Trigger the pre-requisite SQL script [1_User_Creation.sql](Phase%203%20Submission/1_User_Creation.sql) using the default Oracle database `ADMIN` user to create required users and grant them connect permissions
- Trigger the next SQL script [2_Table_View_Creation.sql](Phase%203%20Submission/2_Table_View_Creation.sql) using the newly created admin user (name: DATABASE_ADMIN, password: [in script](Phase%203%20Submission/1_User_Creation.sql?plain=83)) to create required sequences, tables and views. The relevant users are also granted required privileges in the same script.
