#!/bin/bash

# service cron start
mv /usr/local/etc/php/php.ini-development /usr/local/etc/php/php.ini

exec "$@"

