sudo apt install postgresql-client-common

psql -h <host> -U <user> -d <dbname>
docker run -it --rm postgres psql -h <hostname> -p 5432 -U <user> -d <db-name>

docker exec -t <container-name> pg_dump -U <user> -d <db-name> -Fc -f /tmp/db.dump
docker cp <container-name>:/tmp/db.dump ./db.dump
pg_restore -h <hostname> -U <user> -d <db-name> -Fc --no-owner --role=<user> db.dump

\l List all databases
\c dbname	Connect to another database
\dt	List tables in current schema
\d tablename	Show table structure
\dn	List schemas
\df	List functions
\du	List roles/users
\x	Toggle expanded output (pretty)
\q	Quit psql

# Check connections
BEGIN;
SELECT COUNT(*) FROM pg_stat_activity WHERE state='active'; # idle
ABORT;

# List all databases with owners
SELECT datname, pg_catalog.pg_get_userbyid(datdba) AS owner
FROM pg_database;
