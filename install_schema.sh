#!/bin/sh
export PGPASSWORD=${PASS}
psql -U ${USER} -h ${HOST} --port ${PORT} -f ${sql} -c "CREATE EXTENSION IF NOT EXISTS citext;" $1
for sql in /usr/src/appdata/*.sql; do 
	psql -U ${USER} -h ${HOST} --port ${PORT} -f ${sql} -d $1
done
