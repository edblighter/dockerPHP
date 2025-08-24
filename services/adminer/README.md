# Adminer Service

This service provides a lightweight and user-friendly database management tool called [Adminer](https://www.adminer.org/). It's a single PHP file that offers a full-featured alternative to phpMyAdmin.

## Key Features

- **Simplicity:** Easy to deploy and use, with a clean and intuitive interface.
- **Wide Database Support:** Connect to various database systems, including MySQL, MariaDB, PostgreSQL, SQLite, MS SQL, Oracle, and more.
- **Security:** Built-in protection against common web vulnerabilities like SQL injection, XSS, and CSRF.

## Standalone Usage

To run the Adminer service as a standalone container, execute the following command from the project's root directory:

```bash
docker-compose -f services/adminer/docker-compose.yml up -d
```

This will start the Adminer container with the default configuration values.

### Customization

For advanced customization, you can use the `.env.adminer` file. To apply your custom settings, run the following command:

```bash
docker-compose -f services/adminer/docker-compose.yml --env-file services/adminer/.env.adminer up -d
```

The following variables can be customized in the `.env.adminer` file:

| Variable                  | Description                                       | Default Value     |
| ------------------------- | ------------------------------------------------- | ----------------- |
| `ADMINER_EXTERNAL_PORT`   | The external port to access Adminer.              | `8088`            |
| `DBADMIN_CONTAINER_NAME`  | The name of the Adminer container.                | `app_dbadmin`     |
| `DB_HOST`                 | The hostname of the database server.              | `db`              |
| `ADMINER_IMAGE`           | The Docker image for Adminer.                     | `wodby/adminer`   |
| `ADMINER_VERSION`         | The version of the Adminer image.                 | `latest`          |
| `ADMINER_DEFAULT_DRIVER`  | The default database driver to use.               | `pgsql`           |
| `APP_DATABASE_NAME`       | The name of the database to connect to.           | `laravel`         |
| `APP_NETWORK_NAME`        | The name of the Docker network.                   | `app_network`     |

### Accessing Adminer

Once the service is running, you can access the Adminer web interface through the following URLs:

- **Standalone:** `http://127.0.0.1:8088`
- **With Proxy:** `http://dbadmin.localhost:8000` (requires the proxy service to be running)