# PHP-FPM Docker image for Laravel

Docker image for a php-fpm container crafted to run Laravel based applications.

## Specifications:

* PHP 7.0
* OpenSSL PHP Extension
* PDO PHP Extension
* Mbstring PHP Extension
* Tokenizer PHP Extension
* XML PHP Extension
* PCNTL PHP Extension
* ZIP PHP Extension
* MCRYPT PHP Extension
* GD PHP Extension
* Memcached
* Composer
* Laravel Cron Job for the [task scheduling](https://laravel.com/docs/5.4/scheduling#introduction) setup
* PHP ini values for Laravel (see [`laravel.ini`](https://github.com/Cyber-Duck/php-fpm-laravel/blob/master/laravel.ini))
* xDebug (PHPStorm friendly, see [`xdebug.ini`](https://github.com/Cyber-Duck/php-fpm-laravel/blob/master/xdebug.ini))
* `t` alias created to run unit tests `vendor/bin/phpunit` with `docker-compose exec [service_name] t`

## docker-compose usage:

```yml
version: '2'
services:
    php-fpm:
        image: cyberduck/php-fpm-laravel
        volumes:
            - ./:/var/www/
            - ~/.ssh:/root/.ssh # can be useful for composer if you use private CVS
        networks:
            - my_net #if you're using networks between containers
```
