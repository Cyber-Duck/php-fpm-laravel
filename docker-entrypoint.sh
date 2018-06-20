#!/bin/bash

service cron start

# Toggle xdebug
if [ "false" == "$XDEBUG" ]; then
    sed -i "s/^/;/" /usr/local/etc/php/conf.d/xdebug.ini
    sed -i "s/^/;/" /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
fi

exec "$@"
