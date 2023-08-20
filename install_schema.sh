#!/bin/sh
export PGPASSWORD=${PASS}
for sql in /usr/src/appdata/*.sql; do 
	psql -U ${USER} -h ${HOST} --port ${PORT} -f ${sql} -d $1
done
