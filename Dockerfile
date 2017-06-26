FROM php:7.0-fpm

MAINTAINER clement@cyber-duck.co.uk

RUN apt-get update

RUN apt-get update && \
    apt-get install -y --force-yes --no-install-recommends \
        libmemcached-dev \
        libz-dev \
        libpq-dev \
        libjpeg-dev \
        libpng12-dev \
        libfreetype6-dev \
        libssl-dev \
        libmcrypt-dev \
        openssh-server \
        git \
        cron \
        nano

# Install the PHP mcrypt extention
RUN docker-php-ext-install mcrypt

# Install the PHP pcntl extention
RUN docker-php-ext-install pcntl

# Install the PHP zip extention
RUN docker-php-ext-install zip

# Install the PHP pdo_mysql extention
RUN docker-php-ext-install pdo_mysql

# Install the PHP pdo_pgsql extention
RUN docker-php-ext-install pdo_pgsql

#####################################
# GD:
#####################################

# Install the PHP gd library
RUN docker-php-ext-install gd && \
    docker-php-ext-configure gd \
        --enable-gd-native-ttf \
        --with-jpeg-dir=/usr/lib \
        --with-freetype-dir=/usr/include/freetype2 && \
    docker-php-ext-install gd

#####################################
# Python:
#####################################

ARG INSTALL_PYTHON=false
RUN if [ ${INSTALL_PYTHON} = true ]; then \
    apt-get -y install python2.7 \
;fi
RUN echo 'alias python="/usr/bin/python2.7"' >> ~/.bashrc

#####################################
# xDebug:
#####################################

ARG INSTALL_XDEBUG=false
RUN if [ ${INSTALL_XDEBUG} = true ]; then \
    # Install the xdebug extension
    pecl install xdebug && \
    docker-php-ext-enable xdebug \
;fi
# Copy xdebug configration for remote debugging
COPY ./xdebug.ini /usr/local/etc/php/conf.d/xdebug.ini

#####################################
# PHP Memcached:
#####################################

ARG INSTALL_MEMCACHED=false
RUN if [ ${INSTALL_MEMCACHED} = true ]; then \
    # Install the php memcached extension
    pecl install memcached && \
    docker-php-ext-enable memcached \
;fi

#####################################
# Composer:
#####################################

ARG INSTALL_COMPOSER=false
RUN if [ ${INSTALL_COMPOSER} = true ]; then \
    # Install composer and add its bin to the PATH.
    curl -s http://getcomposer.org/installer | php && \
        echo "export PATH=${PATH}:/var/www/vendor/bin" >> ~/.bashrc && \
        mv composer.phar /usr/local/bin/composer && \
    # Source the bash
    . ~/.bashrc \
;fi

#####################################
# Laravel Schedule Cron Job:
#####################################

ARG LARAVEL_SCHEDULE=false
RUN if [ ${LARAVEL_SCHEDULE} = true ]; then \
    echo "* * * * * root php /var/www/artisan schedule:run >> /dev/null 2>&1" >> /etc/cron.d/laravel-schedule && \
    chmod 0644 /etc/cron.d/laravel-schedule \
;fi
#
#--------------------------------------------------------------------------
# Final Touch
#--------------------------------------------------------------------------
#

ADD ./laravel.ini /usr/local/etc/php/conf.d

# Ability to run `docker-compose exec php-fpm t` which is an alias to run the tests
RUN echo '#!/bin/bash\n/usr/local/bin/php /var/www/artisan config:clear\n/var/www/vendor/bin/phpunit -d memory_limit=2G --stop-on-error --stop-on-failure --testdox-text=tests/report.txt "$@"' > /usr/bin/t
RUN chmod +x /usr/bin/t

RUN rm -r /var/lib/apt/lists/*

RUN usermod -u 1000 www-data

WORKDIR /var/www

EXPOSE 9000

CMD ["php-fpm"]
