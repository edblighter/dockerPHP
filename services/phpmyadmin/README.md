# phpMyAdmin Service

This service provides a free and open-source administration tool for MySQL and MariaDB called [phpMyAdmin](https://www.phpmyadmin.net/). It is a web-based tool that allows you to manage your databases from a graphical interface.

## Key Features

- **Web-Based Management:** Manage your databases from anywhere with a web browser.
- **Full-Featured:** phpMyAdmin provides a wide range of features, including database and table management, SQL queries, and data import/export.
- **Easy to Use:** With its intuitive interface, phpMyAdmin is easy to learn and use, even for beginners.

## Standalone Usage

To run the phpMyAdmin service as a standalone container, execute the following command from the project's root directory:

```bash
docker-compose -f services/phpmyadmin/docker-compose.yml up -d
```

This will start the phpMyAdmin container with the default configuration values.

### Customization

For advanced customization, you can use the `.env.phpmyadmin` file. To apply your custom settings, run the following command:

```bash
docker-compose -f services/phpmyadmin/docker-compose.yml --env-file services/phpmyadmin/.env.phpmyadmin up -d
```

The following variables can be customized in the `.env.phpmyadmin` file:

| Variable                    | Description                                       | Default Value         |
| --------------------------- | ------------------------------------------------- | --------------------- |
| `PHPMYADMIN_CONTAINER_NAME` | The name of the phpMyAdmin container.             | `app_phpmyadmin`      |
| `PHPMYADMIN_ARBITRARY`      | Set to 0 to auto login.                           | `1`                   |
| `PHPMYADMIN_IMAGE`          | The Docker image for phpMyAdmin.                  | `phpmyadmin`          |
| `PHPMYADMIN_VERSION`        | The version of the phpMyAdmin image.              | `latest`              |
| `PHPMYADMIN_URL`            | The URL for phpMyAdmin.                           | `http://dbadmin.localhost/` |
| `APP_MYSQL_USER`            | The user for the database.                        | `laravel`             |
| `APP_MYSQL_PASSWORD`        | The password for the database user.               | `secret`              |
| `DB_HOST`                   | The hostname of the database server.              | `db`                  |
| `MYSQL_PORT`                | The port of the database server.                  | `3306`                |
| `APP_TIMEZONE`              | The timezone for the container.                   | `America/Manaus`      |
| `APP_NETWORK_NAME`          | The name of the Docker network.                   | `app_network`         |

**Note:** The `APP_MYSQL_USER` and `APP_MYSQL_PASSWORD` variables are only used when `PHPMYADMIN_ARBITRARY` is set to `0`.

### Accessing phpMyAdmin

Once the service is running, you can access phpMyAdmin at the following URLs:

- **Standalone:** `http://127.0.0.1:9000`
- **With Proxy:** `http://dbadmin.localhost:8000` (requires the proxy service to be running)