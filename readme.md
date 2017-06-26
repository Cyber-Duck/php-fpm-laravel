# PHP-FPM Docker image for Laravel

Docker image for a php-fpm container crafted to run Laravel based applications.

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

* This will install the latest version of composer within the container so you can run `docker-compose exec [service_name] composer`.
* This will set the Laravel Cron Job for the [task scheduling](https://laravel.com/docs/5.4/scheduling#introduction).
* This will install and configure XDebug so you can use it with PHPStorm too.
