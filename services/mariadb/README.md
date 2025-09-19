# MariaDB Service

## Overview
This service provides [MariaDB](https://mariadb.org/), a robust, open-source relational database that's a MySQL fork, known for performance, security, and compatibility.

## Features
- **MySQL Compatibility:** Drop-in replacement for easy migration.
- **Performance:** Advanced optimizer and storage engines.
- **Security:** Encryption, authentication, and access controls.
- **Management:** Includes phpMyAdmin for web-based administration.

## Prerequisites
- Docker and Docker Compose installed.
- Generate root password: `openssl rand -base64 20 > docker-data/mariadb/db_root_password.txt`

## Quick Start
1. Generate password file as above.
2. Run: `docker-compose -f services/mariadb/docker-compose.yml --env-file services/mariadb/.env.mariadb up -d`
3. Connect at `127.0.0.1:3306` with created credentials.

## Configuration
Customize via `.env.mariadb`:

| Variable                    | Description                                       | Default Value         |
| --------------------------- | ------------------------------------------------- | --------------------- |
| `MARIADB_CONTAINER_NAME`    | The name of the MariaDB container.                | `app_mariadb`         |
| `MARIADB_IMAGE`             | The Docker image for MariaDB.                     | `mariadb`             |
| `MARIADB_VERSION`           | The version of the MariaDB image.                 | `lts`                 |
| `MYSQL_PORT`                | The external port for MariaDB.                    | `3306`                |
| `MYSQL_MEM_LIMIT`           | Memory limit for MariaDB.                         | `1G`                  |
| `APP_DATABASE_NAME`         | The name of the database to create.               | `laravel`             |
| `APP_MYSQL_USER`            | The user for the database.                        | `laravel`             |
| `APP_MYSQL_PASSWORD`        | The password for the database user.               | `secret`              |
| `MARIADBDATA_PATH`          | The path to the MariaDB data directory.           | `$PWD/docker-data/mariadb/mysqldata` |
| `APP_TIMEZONE`              | The timezone for the container.                   | `America/Manaus`      |
| `APP_NETWORK_NAME`          | The name of the Docker network.                   | `app_network`         |
| `PHPMYADMIN_CONTAINER_NAME` | The name of the phpMyAdmin container.             | `app_phpmyadmin`      |
| `PHPMYADMIN_IMAGE`          | The Docker image for phpMyAdmin.                  | `phpmyadmin`          |
| `PHPMYADMIN_VERSION`        | The version of the phpMyAdmin image.              | `latest`              |
| `PHPMYADMIN_URL`            | The URL for phpMyAdmin.                           | `http://dbadmin.localhost/` |
| `PHPMYADMIN_ARBITRARY`      | Set to 0 to auto login to phpMyAdmin.             | `1`                   |

## Usage
- **Connection:** Host `db`, Port 3306 (internal), or `127.0.0.1:3306` (external).
- **phpMyAdmin:** Access at `http://dbadmin.localhost:8000` (with proxy).
- **Data Persistence:** Stored in `docker-data/mariadb/mysqldata`.
- **Healthcheck:** Monitors MariaDB ping.

## Troubleshooting
- **Connection Refused:** Check if container is running and ports are open.
- **Permission Denied:** Ensure data directory permissions.
- **Memory Issues:** Increase `MYSQL_MEM_LIMIT`.
- **phpMyAdmin Login:** Set `PHPMYADMIN_ARBITRARY=0` for auto-login.

## Links
- [MariaDB Documentation](https://mariadb.com/kb/en/documentation/)
- [phpMyAdmin Documentation](https://docs.phpmyadmin.net/en/latest/)