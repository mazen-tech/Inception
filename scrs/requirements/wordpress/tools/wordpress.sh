#!/bin/sh

#check if wp-config.php exist so we will print msg if not so we will
#atuomize the downeloading prosses
if [ -f ./wp-config.php ]
then
    echo "wordpress already downloaded"

else

    wget http://wordpress.org/latest.tar.gz #download the latest wordpress
    tar xfz latest.tar.gz #extract the content of latest.tar.gz (xfz)x->extract f->specify z->handle gzip compression
    mv wordpress/* . #move all extracted files from wordpress to currenr dir
    rm -rf latest.tar.gz #delete tar
    rm -rf wordpress #delet wordpress

    #Inport env variable in which are in the config file 
    sed -i "s/username_here/$MYSQL_USER/g" wp-config-sample.php
    sed -i "s/password_here/$MYSQL_PASSWORD/g" wp-config-sample.php
    sed -i "s/localhost/$MYSQL_HOSTNAME/g" wp-config-sample.php
    sed -i "s/database_name_hare/$MYSQL_DATABASE/g" wp-config-sample.php
    cp wp-config-sample.php wp-config.php

fi 

exec "$@"