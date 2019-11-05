#!/bin/bash
# Stop on error
set -e
# Variables
DATA_DIR=/var/lib/pgsql/data
#start postgreSQL
echo "starting postgreSQL ... "
su postgres -c "pg_ctl -w -D $DATA_DIR -l ${DATA_DIR}/logfile start"
echo "started postgreSQL"
# Create Database and Users
su postgres bash -c "psql -c \"CREATE USER pguser WITH SUPERUSER PASSWORD 'pguser';\""
su postgres bash -c "createdb -O pguser pgdb"
# keep the stdin
/bin/bash
