# PostgreSQL Service

This service provides a powerful, open-source object-relational database system called [PostgreSQL](https://www.postgresql.org/). It is known for its reliability, feature robustness, and performance.

## Key Features

- **Reliability:** PostgreSQL is known for its reliability and has been battle-tested in production environments for many years.
- **Extensibility:** PostgreSQL is highly extensible and allows you to define your own data types, operators, and functions.
- **Standards Compliance:** PostgreSQL is compliant with the SQL standard and supports a wide range of advanced SQL features.

## Standalone Usage

Before running the service, you need to create a root password for the database. Execute the following command from the project's root directory:

```bash
openssl rand -base64 20 > docker-data/postgres/db_root_password.txt
```

To run the PostgreSQL service as a standalone container, execute the following command:

```bash
docker-compose -f services/postgres/docker-compose.yml --env-file services/postgres/.env.postgres up -d
```

This will start the PostgreSQL container with the values from the `.env.postgres` file.

### Customization

You can customize the service by editing the `.env.postgres` file. The following variables can be customized:

| Variable                    | Description                                       | Default Value         |
| --------------------------- | ------------------------------------------------- | --------------------- |
| `POSTGRES_CONTAINER_NAME`   | The name of the PostgreSQL container.             | `app_postgres`        |
| `DBADMIN_CONTAINER_NAME`    | The name of the Adminer container.                | `app_dbadmin`         |
| `POSTGRES_PORT`             | The external port for PostgreSQL.                 | `5432`                |
| `APP_DATABASE_NAME`         | The name of the database to create.               | `laravel`             |
| `DB_HOST`                   | The hostname of the database server.              | `db`                  |
| `APP_TIMEZONE`              | The timezone for the container.                   | `America/Manaus`      |
| `APP_NETWORK_NAME`          | The name of the Docker network.                   | `app_network`         |
| `POSTGRES_IMAGE`            | The Docker image for PostgreSQL.                  | `postgres`            |
| `POSTGRES_VERSION`          | The version of the PostgreSQL image.              | `alpine`              |
| `APP_POSTGRES_USER`         | The user for the database.                        | `laravel`             |
| `APP_POSTGRES_PASSWORD`     | The password for the database user.               | `secret`              |
| `POSTGRESDATA_PATH`         | The path to the PostgreSQL data directory.        | `$PWD/docker-data/postgres/data` |
| `ADMINER_IMAGE`             | The Docker image for Adminer.                     | `wodby/adminer`       |
| `ADMINER_VERSION`           | The version of the Adminer image.                 | `latest`              |
| `ADMINER_DEFAULT_DRIVER`    | The default driver for Adminer.                   | `pgsql`               |

### Accessing PostgreSQL

Once the service is running, you can connect to the PostgreSQL server at `127.0.0.1:5432`.

This service also includes Adminer for database management. You can access it at:

- **Standalone:** `http://127.0.0.1:8088`
- **With Proxy:** `http://dbadmin.localhost:8000` (requires the proxy service to be running)