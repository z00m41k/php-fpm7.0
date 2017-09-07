## PHP-FPM Image

 **Helpful PHP-FPM image from official ubuntu:xenial**
 >
 > PHP-FPM version - 7.0.22

 > DateTime - Europe/Kiev

 > Composer installed globally

## Tags
 * z00m41k/php-fpm7.0:stable

### Extensions:

 * php7.0-pgsql
 * php7.0-mysql
 * php7.0-opcache
 * php7.0-common
 * php7.0-mbstring
 * php7.0-mcrypt
 * php7.0-soap
 * php7.0-cli
 * php7.0-intl
 * php7.0-json
 * php7.0-xsl
 * php7.0-imap
 * php7.0-ldap
 * php7.0-curl
 * php7.0-gd
 * php7.0-dev
 * php7.0-fpm
 * php7.0-redis
 * php7.0-memcached
 * php7.0-mongodb
 * php7.0-imagick (`new`)

### In addition

 * Composer (installed globally)
 
### Docker-compose usage (example)

```yaml
version: "2"
services:
 nginx:
   image: nginx:1.11
   depends_on:
    - php-fpm
   links:
    - php-fpm
   environment:
    - NGINX_PORT=80
    - FASTCGI_HOST=php-fpm
    - FASTCGI_PORT=9000
    - DOCUMENT_ROOT=/usr/local/src/app/web # ROOT folder for Symfony framework
   ports:
    - 8600:80
   volumes:
    - ./stack/nginx/templates/default.conf.template:/etc/nginx/conf.d/default.conf.template
    - ./stack/nginx/entrypoint.sh:/entrypoint.sh
   volumes_from:
    - php-fpm
   command: "/bin/bash /entrypoint.sh"

 database:
   image: mysql:5.7
   environment:
     MYSQL_ROOT_PASSWORD: 1fN82Avd7TT5Bad2
     MYSQL_DATABASE: app
     MYSQL_USER: app
     MYSQL_PASSWORD: DDwgLAA3WH2a2k1h
   ports:
    - 3309:3306
   volumes:
    - data:/var/lib/mysql

 php-fpm:
   image: 05a60462f8ba/php-fpm7.0
   depends_on:
    - database
   links:
    - database
   volumes:
    - .:/usr/local/src/app
   working_dir: /usr/local/src/app
   extra_hosts:
    - "app:127.0.0.1"
   environment:
     DB_HOST: database
     DB_PORT: 3306
     DB_DATABASE: app
     DB_USERNAME: app
     DB_PASSWORD: DDwgLAA3WH2a2k1h
volumes:
 data: {}
```