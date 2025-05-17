# CONTAINERS NAME
APP_CONTAINER_NAME=app_php  # Container running the php-fpm(Default port 9000)
MYSQL_CONTAINER_NAME=app_mysql  # Container running the MySQL intance(Default port 3306 - Change at MYSQL_PORT variable)
MARIADB_CONTAINER_NAME=app_mariadb  # Container running the MariaDB intance(Default port 3306 - Change at MYSQL_PORT variable)
PHPMYADMIN_CONTAINER_NAME=app_phpmyadmin    # Container running the phpmyadmin to administer the MySQL/MariaDB when selected(Default address http://dbadmin.localhost:8000)
POSTGRES_CONTAINER_NAME=app_postgres    # Container running the PostgreSQL intance(Default port 5432 - Change at POSTGRES_PORT)
DBADMIN_CONTAINER_NAME=app_dbadmin  # Container running the Adminer instance used the administer the PostgreSQL when selected(Default address http://dbadmin.localhost:8000)
APP_MAILPIT_CONTAINER=app_mailpit   # Container running the Mailpit instance to simulate SMTP sends (Default address http://smtp.localhost:8000)
REDIS_CONTAINER=app_redis   # Container running the Redis instance (Default port 6379 - Change at APP_REDIS_PORT variable)
APP_NGINX_CONTAINER_NAME=app_nginx  # Container running the Caddy web server (Default to HTTP_PORT = 8000 and HTTPS available)
APP_CADDY_CONTAINER_NAME=app_caddy  # Container running the Nginx web server (Default to HTTP_PORT = 8000)

# MAPPED PORTS
APP_HTTP_PORT=8000 # Default port to be used for http access(if your port 80 is free consider changing)
APP_HTTPS_PORT=443 # Default port to be used for https access(if your port 443 is free consider changing)
MYSQL_PORT=3306     # Default mysql/mariadb port
POSTGRES_PORT=5432  # Default postgresql port
APP_REDIS_PORT=6379 # Defaul redis port
APP_MAILPIT_SMTP_PORT=1025  # Default smtp port to send emails to mailpit
APP_MAILPIT_WEB_PORT=8025   # Default port to access the mailpit UI

# MISC
APP_TIMEZONE="America/Manaus"       # Define the a timezone to adjust de date/time of logs inside containers

# NETWORK RELATED
APP_NETWORK_NAME=app_network    # Default docker network name used between services

# COMMON DATABASE NAME
APP_DATABASE_NAME=laravel   # Database created at start of the database containers

# PHP ENV
PHP_VERSION=8.3        # Supported Versions [8.3, 8.2, 8.1, 7.4, 5.6]

# MYSQL ENV
MYSQL_IMAGE=mysql
MYSQL_VERSION=lts      # RECOMMENDED TAGS[latest, lts, 5.7]
MARIADB_IMAGE=mariadb
MARIADB_VERSION=lts      # RECOMMENDED TAGS[latest, lts, 10]

APP_MYSQL_USER=laravel
APP_MYSQL_PASSWORD=secret
MYSQLDATA_PATH="$PWD/docker-data/mysql/mysqldata"

# PHPMYADMIN
PHPMYADMIN_IMAGE=phpmyadmin     # RECOMMENDED IMAGE [phpmyadmin, phpmyadmin/phpmyadmin]
PHPMYADMIN_VERSION=latest   # RECOMMENDED TAGS[latest, fpm-alpine]
PHPMYADMIN_URL="http://dbadmin.localhost/"

# POSTGRES ENV
POSTGRES_IMAGE=postgres
POSTGRES_VERSION=alpine       # RECOMMENDED TAGS[latest, alpine, 16-bookwom, 16-alpine, 15-bookworm, 15-alpine, 14-bookworm, 14-alpine, 13-bookworm, 13-alpine]
APP_POSTGRES_USER=laravel
APP_POSTGRES_PASSWORD=secret
POSTGRESDATA_PATH="$PWD/docker-data/postgres/data"

# DBADMIN
ADMINER_IMAGE=wodby/adminer
ADMINER_VERSION=latest    # RECOMMENDED TAGS[latest, 5, 5-4.2.1]

# REDIS ENV
REDIS_IMAGE=redis      
REDIS_VERSION=alpine    # RECOMMENDED TAGS[latest, alpine,  8-bookworm, 8-alpine]

# MAILPIT ENV
MAILPIT_IMAGE=axllent/mailpit
MAILPIT_VERSION=latest  # RECOMMENDED TAGS[latest]

# NGINX ENV
NGINX_IMAGE=nginx
NGINX_VERSION=stable-alpine    # RECOMMENDED TAGS[latest, alpine, stable-bookworm, stable-alpine]

# CADDY ENV
CADDY_IMAGE=caddy
CADDY_VERSION=alpine    # RECOMMENDED TAGS[latest, alpine]