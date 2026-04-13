#!/bin/sh

# Bootstrapping
[[ -n "$STATIC_DIR" ]] && { mkdir -pv "$STATIC_DIR"; chown -R spring:spring "$STATIC_DIR"; }
[[ -n "$PRIV_DIR" ]] && { mkdir -pv "$PRIV_DIR"; chown -R spring:spring "$PRIV_DIR"; }
until
  echo 'Waiting for postgres...' &&
  nc -vz -w 2 $POSTGRES_HOST 5432 &&
  echo 'Waiting for redis...' &&
  nc -vz -w 2 $REDIS_HOST 6379
do
  echo 'Looping forever...'
  sleep 2
done

# Starting the server
su -s /bin/sh -c "exec /opt/java/openjdk/bin/java -jar /server.jar" spring
