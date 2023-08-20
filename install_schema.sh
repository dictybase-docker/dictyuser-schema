#!/bin/sh
psql -c "CREATE EXTENSION IF NOT EXISTS citext;"
for sql in /usr/src/appdata/*.sql; do 
	psql -f ${sql}
done
