# Adminer Service

## Overview
This service provides [Adminer](https://www.adminer.org/), a lightweight, user-friendly database management tool that's a single PHP file alternative to phpMyAdmin.

## Features
- **Simplicity:** Clean, intuitive interface for easy deployment.
- **Multi-Database Support:** Connects to MySQL, MariaDB, PostgreSQL, SQLite, MS SQL, Oracle, etc.
- **Security:** Built-in protection against SQL injection, XSS, and CSRF.
- **Single File:** No complex installation required.

## Prerequisites
- Docker and Docker Compose installed.
- Database service running for connection.

## Quick Start
1. Run: `docker-compose -f services/adminer/docker-compose.yml up -d`
2. Access at `http://dbadmin.localhost:8000` (with proxy) or standalone port.

## Configuration
Customize via `.env.adminer`:

| Variable                  | Description                                       | Default Value     |
| ------------------------- | ------------------------------------------------- | ----------------- |
| `DBADMIN_CONTAINER_NAME`  | The name of the Adminer container.                | `app_dbadmin`     |
| `ADMINER_IMAGE`           | The Docker image for Adminer.                     | `wodby/adminer`   |
| `ADMINER_VERSION`         | The version of the Adminer image.                 | `latest`          |
| `ADMINER_EXTERNAL_PORT`   | The external port to access Adminer.              | `8088`            |
| `ADMINER_DEFAULT_DRIVER`  | The default database driver to use.               | `pgsql`           |
| `DB_HOST`                 | The hostname of the database server.              | `db`              |
| `APP_DATABASE_NAME`       | The name of the database to connect to.           | `laravel`         |
| `APP_NETWORK_NAME`        | The name of the Docker network.                   | `app_network`     |

## Usage
- **Access:** Web interface at configured URL.
- **Connection:** Use database credentials to connect.
- **Features:** Browse tables, run queries, manage data.
- **Drivers:** Supports multiple database drivers.

## Troubleshooting
- **Connection Failed:** Ensure database service is running and credentials are correct.
- **Port Issues:** Check if `ADMINER_EXTERNAL_PORT` is available.
- **Driver Mismatch:** Set `ADMINER_DEFAULT_DRIVER` to match your database (e.g., `mysql` for MySQL).
- **Access Denied:** Verify network and firewall settings.

## Links
- [Adminer Documentation](https://www.adminer.org/en/)
- [Supported Databases](https://www.adminer.org/en/drivers/)