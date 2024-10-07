FROM debian:buster

RUN apt-get update
RUN apt-get install -y mariadb-server \
    mariadb-client \ 
    vim \
    && rm -rf /var/lib/apt/lists/*


#Allow to run mysql
#purge and recreate /var/lib/mysql with correct ownership
#and make sure that /var/run/mysql (used for socket and lock files)
#is writable regardles the UID of mysql

RUN mkdir -p /var/run/mysql \
&& chown -R mysql:mysql /var/run/mysql \
&& chmod 777 /var/run/mysql

#exposes posrt 3306 on the container (which is default port)
#MariaDB/MySQL listens on for incoming connections and access outside via port
EXPOSE 3306

#copying ./conf/mysql.conf `/my.cnf
#copying ./conf/mysql.conf `/etc/mysql/my.cnf
#copying ./conf/mysql.conf `/etc/my.cnf

#copint from the .sh and .sql in the /bin of the container to be able to run the program 
COPY ./tools/mariadb.sh  /usr/local/bin/
Copy ./conf/wordpress.sql /usr/local/bin
RUN chmod +x /usr/local/bin/mariadb.sh
RUN chmod +x /usr/local/bin/wordpress.sql

#everypoint directive sets the default program to be executed
#so simply everypoint set the env and CMD starts the actual mariadb service
ENTRYPOINT [ "/usr/local/bin/mariadb.sh" ]

#the command to lunch the mariadb and enable the database and lsitning globaly
CMD ["mysqld", "--bind-address=0.0.0.0"]

