#!/bin/bash

mkdir -p ${POSTGRES_DATA_FOLDER}
chown postgres:postgres ${POSTGRES_DATA_FOLDER}
chmod 700 ${POSTGRES_DATA_FOLDER}

# Check if data folder is empty. If it is, start the dataserver
if ! ["$(ls -A ${POSTGRES_DATA_FOLDER})" ]; then
    su postgres -c "/usr/pgsql-9.0/bin/initdb  --encoding=${ENCODING} --locale=${LOCALE}.${ENCODING} --lc-collate=${LOCALE}.${ENCODING}  --lc-monetary=${LOCALE}.${ENCODING}  --lc-numeric=${LOCALE}.${ENCODING}  --lc-time=${LOCALE}.${ENCODING}  -D ${POSTGRES_DATA_FOLDER}"

    # Modify basic configutarion
    su postgres -c "echo \"host all all 0.0.0.0/0 md5\" >> $POSTGRES_DATA_FOLDER/pg_hba.conf"
    su postgres -c "echo \"host all all ::0/0 md5\" >> $POSTGRES_DATA_FOLDER/pg_hba.conf"
    su postgres -c "echo \"listen_addresses='*'\" >> $POSTGRES_DATA_FOLDER/postgresql.conf"

    # Establish postgres user password and run the database
    su postgres -c "/usr/pgsql-9.0/bin/pg_ctl -w -D ${POSTGRES_DATA_FOLDER} start"
    su postgres -c "/usr/pgsql-9.0/bin/psql -h localhost -U postgres -p 5432 -c \"alter role postgres password '${POSTGRES_PASSWD}';\""
    su postgres -c "/usr/pgsql-9.0/bin/pg_ctl -w -D ${POSTGRES_DATA_FOLDER} stop"
fi

echo "Start postgres"
# Start the database
su postgres -c "/usr/pgsql-9.0/bin/postgres -D $POSTGRES_DATA_FOLDER"
