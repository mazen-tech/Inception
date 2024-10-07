#!/bin/sh

mysql_install_db

/etc/init.d/mysql start


#checking if the database exists
if [ -d "/var/lib/mysql/$MYSQL_DATABASE" ]
then


    echo "Database already exists"
else 
    #set the root option so that connection without root password is not possible

mysql_secure_installation << _EOF_

Y
root4life
root4life
Y
n
Y
Y
_EOF_

#then we will add a root user on 127.0.0.1 to allow remote connection 
#flush privilegs allow to your sql table to be ubdated automaticlly
#mysql -urootlaunch mysql command line client
echo "Grant ALL on *.* TO 'root'@% IDENTIFIED BY '$MYSQL_ROOT_PASSWORD'; FLUSH PRIVILEGES;" | mysql -uroot

echo "CREATE DATABASE IF NOT EXISTES $MYSQL_DATABASE; GRANT ALL ON $MYSQL_DATABASE. *TO '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD'; FLUSH PRIVILEGES;" | mysql -u root

#import database in mysql command line
mysql -uroot -p$MYSQL_ROOT_PASSWORD $MYSQL_DATABASE < /usr/local/bin/wordpress.sql

fi

/etc/init.d/mysql stop

exec "$@"