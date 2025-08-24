# MariaDB Service

This service provides a robust and reliable relational database management system called [MariaDB](https://mariadb.org/). It's a community-developed fork of MySQL and is known for its performance, security, and open-source nature.

## Key Features

- **MySQL Compatibility:** MariaDB is a drop-in replacement for MySQL, making it easy to migrate existing applications.
- **Performance:** With its advanced query optimizer and storage engines, MariaDB delivers high performance for demanding workloads.
- **Security:** MariaDB includes a range of security features to protect your data, including encryption, authentication, and access control.

## Standalone Usage

Before running the service, you need to create a root password for the database. Execute the following command from the project's root directory:

```bash
openssl rand -base64 20 > docker-data/mariadb/db_root_password.txt
```

To run the MariaDB service as a standalone container, execute the following command:

```bash
docker-compose -f services/mariadb/docker-compose.yml --env-file services/mariadb/.env.mariadb up -d
```

This will start the MariaDB container with the values from the `.env.mariadb` file.

### Customization

You can customize the service by editing the `.env.mariadb` file. The following variables can be customized:

| Variable                    | Description                                       | Default Value         |
| --------------------------- | ------------------------------------------------- | --------------------- |
| `MARIADB_CONTAINER_NAME`    | The name of the MariaDB container.                | `app_mariadb`         |
| `MYSQL_PORT`                | The external port for MariaDB.                    | `3306`                |
| `DB_HOST`                   | The hostname of the database server.              | `db`                  |
| `MARIADB_IMAGE`             | The Docker image for MariaDB.                     | `mariadb`             |
| `MARIADB_VERSION`           | The version of the MariaDB image.                 | `lts`                 |
| `APP_TIMEZONE`              | The timezone for the container.                   | `America/Manaus`      |
| `APP_NETWORK_NAME`          | The name of the Docker network.                   | `app_network`         |
| `APP_DATABASE_NAME`         | The name of the database to create.               | `laravel`             |
| `APP_MYSQL_USER`            | The user for the database.                        | `laravel`             |
| `APP_MYSQL_PASSWORD`        | The password for the database user.               | `secret`              |
| `MARIADBDATA_PATH`          | The path to the MariaDB data directory.           | `$PWD/docker-data/mysql/mysqldata` |
| `PHPMYADMIN_CONTAINER_NAME` | The name of the phpMyAdmin container.             | `app_phpmyadmin`      |
| `PHPMYADMIN_IMAGE`          | The Docker image for phpMyAdmin.                  | `phpmyadmin`          |
| `PHPMYADMIN_VERSION`        | The version of the phpMyAdmin image.              | `latest`              |
| `PHPMYADMIN_URL`            | The URL for phpMyAdmin.                           | `http://dbadmin.localhost/` |
| `PHPMYADMIN_ARBITRARY`      | Set to 0 to auto login to phpMyAdmin.             | `1`                   |

### Accessing MariaDB

Once the service is running, you can connect to the MariaDB server at `127.0.0.1:3306`.

This service also includes phpMyAdmin for database management. You can access it at:

- **Standalone:** `http://127.0.0.1:9000`
- **With Proxy:** `http://dbadmin.localhost:8000` (requires the proxy service to be running)