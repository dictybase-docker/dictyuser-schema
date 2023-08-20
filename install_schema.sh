#!/bin/sh
export PGPASSWORD=${PASS}
psql -U ${USER} -h ${HOST} --port ${PORT} -f ${sql} -d $1 -c "CREATE EXTENSION IF NOT EXISTS citext;"
for sql in /usr/src/appdata/*.sql; do 
	psql -U ${USER} -h ${HOST} --port ${PORT} -f ${sql} -d $1
done
