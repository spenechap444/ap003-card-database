\echo '== master.sql starting =='
\set ON_ERROR_STOP 1
\timing on

-- Define your absolute root directory for clarity
\set root 'ap003-card-database/master'

BEGIN;
\i :root/ACCOUNT_DBO/ONETIME_SCRIPTS/ACCOUNT_DBO_SCHEMA_CREATE.sql --schema and user creation
\i :root/ACCOUNT_API_DBO/ONETIME_SCRIPTS/ACCOUNT_API_DBO_SCHEMA_CREATE.sql --schema and user creation
\i :root/ACCOUNT_DBO/TABLES/USERS.sql 
\i :root/ACCOUNT_API_DBO/PROCS/aip_fetch_user.sql
\i :root/ACCOUNT_API_DBO/PROCS/aip_store_new_user.sql
COMMIT;

-- For any statements that must run outside a transaction:
\echo '== post-transaction scripts (non-transactional) =='
\i :root/90_verify.sql

\echo '== master.sql completed successfully =='
