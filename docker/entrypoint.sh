#!/bin/sh

mysql_install_db -u mysql --datadir=/var/lib/mysql || true

chown -R mysql:mysql /var/lib/mysql

mariadbd-safe -u mysql --datadir=/var/lib/mysql

# Wait for any process to exit
wait -n
# Exit with status of process that exited first
exit $?

