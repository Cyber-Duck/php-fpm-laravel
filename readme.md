# PHP-FPM Docker image for Laravel

Docker image for a php-fpm container crafted to run Laravel based applications.

## Specifications:

* PHP 7.2 / 7.1 / 7.0 / 5.6 / 5.4
* OpenSSL PHP Extension
* PDO PHP Extension
* SOAP PHP Extension
* Mbstring PHP Extension
* Tokenizer PHP Extension
* XML PHP Extension
* PCNTL PHP Extension
* ZIP PHP Extension
* MCRYPT PHP Extension
* GD PHP Extension
* BCMath PHP Extension
* Imagick PHP Extension
* Memcached
* Composer
* Laravel Cron Job for the [task scheduling](https://laravel.com/docs/5.4/scheduling#introduction) setup
* PHP ini values for Laravel (see [`laravel.ini`](laravel.ini))
* xDebug (PHPStorm friendly, see [`xdebug.ini`](xdebug.ini))
* `t` alias created to run unit tests `vendor/bin/phpunit` with `docker-compose exec [service_name] t`
* `d` alias created to run Laravel Dusk browser tests `artisan dusk` with `docker-compose exec [service_name] d`
* `art` alias created to run the Laravel `artisan` command
* `fresh` alias created to migrate the database fresh and seed the seeders `artisan migrate:fresh --seed`

## Tags available:

When calling the image you want to use within your `docker-compose.yml` file,
you can specify a tag for the image. Tags are used for various versions of a
given Docker image.

* [`7.2`](https://github.com/Cyber-Duck/php-fpm-laravel/tree/7.2)
* [`7.1`](https://github.com/Cyber-Duck/php-fpm-laravel/tree/7.1)
* [`7.0`](https://github.com/Cyber-Duck/php-fpm-laravel/tree/7.0)
* [`5.6`](https://github.com/Cyber-Duck/php-fpm-laravel/tree/5.6)
* [`5.4`](https://github.com/Cyber-Duck/php-fpm-laravel/tree/5.4)

**Note:** the `master` branch is not used for generating images, used for documentation instead. Only tags/branches are. 

## docker-compose usage:

```yml
version: '2'
services:
    php-fpm:
        image: cyberduck/php-fpm-laravel(:<version-tag>)
        volumes:
            - ./:/var/www/
            - ~/.ssh:/root/.ssh # can be useful for composer if you use private CVS
        networks:
            - my_net #if you're using networks between containers
```
