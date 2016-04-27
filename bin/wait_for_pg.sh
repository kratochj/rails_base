#!/bin/bash
counter=0
export PGPASSWORD=$POSTGRES_1_ENV_POSTGRES_PASSWORD
while ! psql -h $POSTGRES_1_PORT_5432_TCP_ADDR -U $POSTGRES_1_ENV_POSTGRES_USER > /dev/null 2>&1;
do
    echo 'Waiting for connection with postgres...'
    sleep 1;
    ((counter++))
    [ $counter -eq 20 ] && exit 1
done;
echo 'Connected to postgres...';