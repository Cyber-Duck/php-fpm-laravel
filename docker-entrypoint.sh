#!/bin/bash

# service cron start
mv /usr/local/etc/php/php.ini-develop /usr/local/etc/php/php.ini

exec "$@"
