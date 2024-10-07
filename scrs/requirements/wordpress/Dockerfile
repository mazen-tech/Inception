FROM debian:buster

RUN apt-get update && apt-get -y install \
    wget \
    curl \
    bash \
    php \
    php-cgi \
    php-mysql \
    php-fpm \
    php-pdo \
    php-gd php-cli \
    php-mbstring \
    redis \
    php-redis \
    && rm -rf /var/lib/apt/lists/*

#after atuomizing the installation prosses of wordpress.sh 
#now we nee to insall wp-cli command and put it in the right directory 
#/usr/local/bin

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

#copy the .conf in the html directory
COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d/

#create the folder to enable 
RUN mkdir /run/php

#copy the create_wordpress script and giving premision to lunch
COPY ./tools/wordpress.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/wordpress.sh
ENTRYPOINT ["/usr/local/bin/wordpress.sh"]

WORKDIR /var/www/html/

#we will expose the port 9000
EXPOSE 9000

CMD ["/usr/sbin/php-fpm7.3", "-F"]