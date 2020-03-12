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

## Xdebug usage:

The image comes with Xdebug installed but by default it is disabled. Xdebug can be enabled using an environmental
variable. This can either be done using the .env file, passing the envs using docker or passing the envs using 
docker-compose.

### Using .env file

Add the following to the env file and then start/restart the container.

```text
XDEBUG=true
PHP_IDE_CONFIG="serverName=phpstorm-server" # This is required for PhpStorm only for path mappings
REMOTE_HOST="<HOST_IP>" # If not set the default is 'host.docker.internal' which will work on OSX and windows
```
 
### Using docker

Pass the required variables with the run command using the -e option.

```bash
docker run -d \
    -e XDEBUG=true \
    -e PHP_IDE_CONFIG="serverName=phpstorm-server" \ #This is required for PhpStorm only for path mappings
    -e REMOTE_HOST="<HOSTIP>" \ # If not set the default is 'host.docker.internal' which will work on OSX and windows
    -v /root/of/project:/var/www \ 
    -v ~/.ssh:/root/.ssh \
    cyberduck/php-fpm-laravel(:<version-tag>)
```

### Using docker-compose

Pass the variables in the environment section of the service using this image.

```yml
version: '2'
services:
    php-fpm:
        image: cyberduck/php-fpm-laravel(:<version-tag>)
        environment:
            XDEBUG: true
            PHP_IDE_CONFIG: "serverName=phpstorm-server" #This is required for PhpStorm only for path mappings
            REMOTE_HOST: "<HOSTIP>" # If not set the default is 'host.docker.internal' which will work on OSX and windows
        volumes:
            - ./:/var/www/
            - ~/.ssh:/root/.ssh # can be useful for composer if you use private CVS
        networks:
            - my_net #if you're using networks between containers
```

### PhpStorm configuration

For xdebug to work with PhpStorm you will need to create a server. This can be done by going to **Preferences > 
Languages & Frameworks > PHP > Servers** and then follow the steps below.

1, Click the `+` symbol.

2, Create a name for the server. This will be the value of serverName in the PHP_IDE_CONFIG variable e.g
 `PHP_IDE_CONFIG="serverName=<CONFIGURED_SERVER_NAME>"`.
 
3, Set Host to `http://localhost` or if using a virtual host then use that instead e.g `http://myapp.localhost`.

4, Set the port to the port that is being used on the host machine e.g `80`.

5, Set the debugger to Xdebug.

6, Check the `Use path mappings` checkbox.

7, Under the project files section find the root of the project and on the right hand side fill out its location inside
 the container e.g `/var/www`.
 
8, Click apply and close preferences.

9, Start listening for incoming connections by going to **Run > Start listening for PHP debug connections**

10, Xdebug can now be tested by adding a breakpoint or selecting **Run > Break at first line in  PHP scripts** and
 refreshing the browser.  

### Visual studio code configuration

For Xdebug to work in Visual Studio Code a launch.json will need to be added to .vscode folder in the route of the
project. Please see below for an example of a launch.json file

```json
{
    "version": "0.2.0",
    "configurations": [
        {
            "name": "Listen for XDebug",
            "type": "php",
            "request": "launch",
            "port": 9000,
            "pathMappings": {
                "/var/www": "${workspaceFolder}"
            }
        }
    ]
}
```

Once this has been added then you can navigate to the debug section. On the left hand side under the **BREAKPOINTS** 
section uncheck the `Everything` checkbox. Now from the dropdown menu at the top select `listen for Xdebug` then press
the play button.

Xdebug can now be tested by adding a breakpoint and refreshing the browser.  