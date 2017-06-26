# PHP-FPM Docker image for Laravel

Docker image for a php-fpm container crafted to run Laravel based applications.

## docker-compose usage:

```yml
version: '2'
services:
    php-fpm:
        image: cyberduck/php-fpm-laravel
        environment:
            - INSTALL_XDEBUG=true|false
            - INSTALL_COMPOSER=true|false
            - INSTALL_PYTHON=true|false
            - LARAVEL_SCHEDULE=true|false
        volumes:
            - ./:/var/www/
            - ~/.ssh:/root/.ssh # can be useful for composer if you use private CVS
        networks:
            - my_net #if you're using networks between containers
```

* `INSTALL_XDEBUG` will install and configure XDebug so you can use it with PHPStorm.
* `INSTALL_COMPOSER` will install the latest version of composer within the container so you can run `docker-compose exec [service_name] composer`.
* `LARAVEL_SCHEDULE` will set the Laravel Cron Job for the [task scheduling](https://laravel.com/docs/5.4/scheduling#introduction).
