#!/bin/sh

if [ ! -f /var/lib/mysql/initialized.txt ]
then
    mysql_install_db -u mysql --datadir=/var/lib/mysql
    chown -R mysql:mysql /var/lib/mysql
fi

mariadbd-safe -u mysql --datadir=/var/lib/mysql &

if [ ! -f /var/lib/mysql/initialized.txt ]
then
    touch /var/lib/mysql/initialized.txt
    apk add expect

    MYSQL_ROOT_PASSWORD=$APP_SET_ROOT_PASSWORD

    echo "Initializing..."

    SECURE_MYSQL=$(expect -c "
    spawn mysql_secure_installation
    expect \"Enter current password for root (enter for none):\"
    send \"$MYSQL\r\"
    expect \"Change the root password?\"
    send \"n\r\"
    expect \"Remove anonymous users?\"
    send \"y\r\"
    expect \"Disallow root login remotely?\"
    send \"${APP_SET_DISALLOW_ROOT_LOGIN_REMOTELY:-y}\r\"
    expect \"Remove test database and access to it?\"
    send \"y\r\"
    expect \"Reload privilege tables now?\"
    send \"y\r\"
    expect eof
    ")

    apk del expect

    if [ "$APP_SET_DISALLOW_ROOT_LOGIN_REMOTELY" == "n" ]
    then
        mariadb -u root -e "CREATE USER 'root'@'%' IDENTIFIED BY '$APP_SET_ROOT_PASSWORD'; GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;";
    fi

    echo "Initialized"
fi

# Wait for any process to exit
wait < <(jobs -p)
# Exit with status of process that exited first
exit $?

