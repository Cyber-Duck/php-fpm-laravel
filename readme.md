# PHP-FPM Docker image for Laravel

Docker image for a php-fpm container crafted to run Laravel based applications.

## Specifications:

* PHP 5.4
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
* `t` alias created to run unit tests `vendor/bin/phpunit` with `docker-compose exec [service_name] t`

**Note:** PHP versions below 5.5 are not supported by xDebug.

## Tags available:

When calling the image you want to use within your `docker-compose.yml` file,
you can specify a tag for the image. Tags are used for various versions of a
given Docker image. By default, `latest` is the one used when no tag is specified.

* `latest` which is using PHP 7.0
* `5.6`
* `5.4`

## docker-compose usage:

```yml
version: '2'
services:
    php-fpm:
        image: cyberduck/php-fpm-laravel(:<optional-tag>)
        volumes:
            - ./:/var/www/
            - ~/.ssh:/root/.ssh # can be useful for composer if you use private CVS
        networks:
            - my_net #if you're using networks between containers
```
