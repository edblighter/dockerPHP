# MySQL Service

## Overview
This service provides [MySQL](https://www.mysql.com/), the world's most popular open-source relational database. It's reliable, performant, and widely used for web applications.

## Features
- **Reliability:** Battle-tested in production with ACID compliance.
- **Performance:** Advanced query optimizer and InnoDB storage engine.
- **Security:** Encryption, authentication, and access controls.
- **Management:** Includes phpMyAdmin for web-based administration.

## Prerequisites
- Docker and Docker Compose installed.
- Generate root password: `openssl rand -base64 20 > docker-data/mysql/db_root_password.txt`

## Quick Start
1. Generate password file as above.
2. Run: `docker-compose -f services/mysql/docker-compose.yml --env-file services/mysql/.env.mysql up -d`
3. Connect at `127.0.0.1:3306` with created credentials.

## Configuration
Customize via `.env.mysql`:

| Variable                    | Description                                       | Default Value         |
| --------------------------- | ------------------------------------------------- | --------------------- |
| `MYSQL_CONTAINER_NAME`      | The name of the MySQL container.                  | `app_mysql`           |
| `MYSQL_IMAGE`               | The Docker image for MySQL.                       | `mysql`               |
| `MYSQL_VERSION`             | The version of the MySQL image.                   | `lts`                 |
| `MYSQL_PORT`                | The external port for MySQL.                      | `3306`                |
| `MYSQL_MEM_LIMIT`           | Memory limit for MySQL.                           | `1G`                  |
| `APP_DATABASE_NAME`         | The name of the database to create.               | `laravel`             |
| `APP_MYSQL_USER`            | The user for the database.                        | `laravel`             |
| `APP_MYSQL_PASSWORD`        | The password for the database user.               | `secret`              |
| `MYSQLDATA_PATH`            | The path to the MySQL data directory.             | `$PWD/docker-data/mysql/mysqldata` |
| `APP_TIMEZONE`              | The timezone for the container.                   | `America/Manaus`      |
| `APP_NETWORK_NAME`          | The name of the Docker network.                   | `app_network`         |
| `PHPMYADMIN_CONTAINER_NAME` | The name of the phpMyAdmin container.             | `app_phpmyadmin`      |
| `PHPMYADMIN_IMAGE`          | The Docker image for phpMyAdmin.                  | `phpmyadmin`          |
| `PHPMYADMIN_VERSION`        | The version of the phpMyAdmin image.              | `latest`              |
| `PHPMYADMIN_URL`            | The URL for phpMyAdmin.                           | `http://dbadmin.localhost/` |
| `PHPMYADMIN_ARBITRARY`      | Set to 0 to auto login to phpMyAdmin.             | `1`                   |

## Usage
- **Connection:** Host `db`, Port 3306 (internal), or `127.0.0.1:3306` (external).
- **phpMyAdmin:** Access at `http://dbadmin.localhost:8000` (with proxy) or standalone port.
- **Data Persistence:** Stored in `docker-data/mysql/mysqldata`.
- **Healthcheck:** Monitors MySQL ping.

## Troubleshooting
- **Connection Refused:** Check if container is running and ports are open.
- **Permission Denied:** Ensure data directory permissions.
- **Memory Issues:** Increase `MYSQL_MEM_LIMIT`.
- **phpMyAdmin Login:** Set `PHPMYADMIN_ARBITRARY=0` for auto-login.

## Links
- [MySQL Documentation](https://dev.mysql.com/doc/)
- [phpMyAdmin Documentation](https://docs.phpmyadmin.net/en/latest/)