#!/bin/bash
# Docker entrypoint script.

DATABASE_HOST=$(echo $DATABASE_URL | sed 's/[^@]*@\([^:/]*\).*/\1/')
DATABASE_DB=$(echo $DATABASE_URL | cut -d/ -f 4)
DATABASE_USER=$(echo $DATABASE_URL | sed 's/mysql:\/\/\([^:]*\).*/\1/')
DATABASE_PASSWORD=$(echo $DATABASE_URL | sed 's/mysql:\/\/[^:]*:\([^@]*\).*/\1/')

# Wait until Database is ready
while ! mysql -h$DATABASE_HOST -u$DATABASE_USER -p$DATABASE_PASSWORD -e ";"
do
  echo "$(date) - waiting for database to start"
  sleep 2
done

cp deps/elph/priv/repo/migrations/* priv/repo/migrations/
mix ecto.migrate

exec "$@"
