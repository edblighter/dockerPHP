# PostgreSQL Service

## Overview
This service provides [PostgreSQL](https://www.postgresql.org/), a powerful, open-source object-relational database system known for reliability, extensibility, and advanced SQL features.

## Features
- **Reliability:** ACID compliant with robust transaction support.
- **Extensibility:** Custom data types, operators, and functions.
- **Standards Compliance:** Full SQL standard support with advanced features.
- **Management:** Includes Adminer for web-based administration.

## Prerequisites
- Docker and Docker Compose installed.
- Generate root password: `openssl rand -base64 20 > docker-data/postgres/db_root_password.txt`

## Quick Start
1. Generate password file as above.
2. Run: `docker-compose -f services/postgres/docker-compose.yml --env-file services/postgres/.env.postgres up -d`
3. Connect at `127.0.0.1:5432` with created credentials.

## Configuration
Customize via `.env.postgres`:

| Variable                    | Description                                       | Default Value         |
| --------------------------- | ------------------------------------------------- | --------------------- |
| `POSTGRES_CONTAINER_NAME`   | The name of the PostgreSQL container.             | `app_postgres`        |
| `POSTGRES_IMAGE`            | The Docker image for PostgreSQL.                  | `postgres`            |
| `POSTGRES_VERSION`          | The version of the PostgreSQL image.              | `alpine`              |
| `POSTGRES_PORT`             | The external port for PostgreSQL.                 | `5432`                |
| `POSTGRES_MEM_LIMIT`        | Memory limit for PostgreSQL.                      | `1G`                  |
| `APP_DATABASE_NAME`         | The name of the database to create.               | `laravel`             |
| `APP_POSTGRES_USER`         | The user for the database.                        | `laravel`             |
| `APP_POSTGRES_PASSWORD`     | The password for the database user.               | `secret`              |
| `POSTGRESDATA_PATH`         | The path to the PostgreSQL data directory.        | `$PWD/docker-data/postgres/data` |
| `APP_TIMEZONE`              | The timezone for the container.                   | `America/Manaus`      |
| `APP_NETWORK_NAME`          | The name of the Docker network.                   | `app_network`         |
| `DBADMIN_CONTAINER_NAME`    | The name of the Adminer container.                | `app_dbadmin`         |
| `ADMINER_IMAGE`             | The Docker image for Adminer.                     | `wodby/adminer`       |
| `ADMINER_VERSION`           | The version of the Adminer image.                 | `latest`              |
| `ADMINER_DEFAULT_DRIVER`    | The default driver for Adminer.                   | `pgsql`               |

## Usage
- **Connection:** Host `db`, Port 5432 (internal), or `127.0.0.1:5432` (external).
- **Adminer:** Access at `http://dbadmin.localhost:8000` (with proxy).
- **Data Persistence:** Stored in `docker-data/postgres/data`.
- **Healthcheck:** Monitors PostgreSQL connection.

## Troubleshooting
- **Connection Refused:** Check if container is running and ports are open.
- **Permission Denied:** Ensure data directory permissions and ownership.
- **Memory Issues:** Increase `POSTGRES_MEM_LIMIT`.
- **Adminer Issues:** Verify `ADMINER_DEFAULT_DRIVER` is set to `pgsql`.

## Links
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [Adminer Documentation](https://www.adminer.org/en/)