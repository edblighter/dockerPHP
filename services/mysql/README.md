# MySQL Service

This service provides the world's most popular open-source relational database, [MySQL](https://www.mysql.com/). It is a reliable and well-tested database that is used by many of the world's largest companies.

## Key Features

- **Reliability:** MySQL is known for its reliability and has been battle-tested in production environments for many years.
- **Performance:** With its advanced query optimizer and storage engines, MySQL delivers high performance for demanding workloads.
- **Security:** MySQL includes a range of security features to protect your data, including encryption, authentication, and access control.

## Standalone Usage

Before running the service, you need to create a root password for the database. Execute the following command from the project's root directory:

```bash
openssl rand -base64 20 > docker-data/mysql/db_root_password.txt
```

To run the MySQL service as a standalone container, execute the following command:

```bash
docker-compose -f services/mysql/docker-compose.yml --env-file services/mysql/.env.mysql up -d
```

This will start the MySQL container with the values from the `.env.mysql` file.

### Customization

You can customize the service by editing the `.env.mysql` file. The following variables can be customized:

| Variable                    | Description                                       | Default Value         |
| --------------------------- | ------------------------------------------------- | --------------------- |
| `MYSQL_CONTAINER_NAME`      | The name of the MySQL container.                  | `app_mysql`           |
| `DB_HOST`                   | The hostname of the database server.              | `db`                  |
| `APP_DATABASE_NAME`         | The name of the database to create.               | `laravel`             |
| `APP_MYSQL_USER`            | The user for the database.                        | `laravel`             |
| `APP_MYSQL_PASSWORD`        | The password for the database user.               | `secret`              |
| `MYSQLDATA_PATH`            | The path to the MySQL data directory.             | `$PWD/docker-data/mysql/mysqldata` |
| `MYSQL_IMAGE`               | The Docker image for MySQL.                       | `mysql`               |
| `MYSQL_VERSION`             | The version of the MySQL image.                   | `lts`                 |
| `MYSQL_PORT`                | The external port for MySQL.                      | `3306`                |
| `APP_TIMEZONE`              | The timezone for the container.                   | `America/Manaus`      |
| `APP_NETWORK_NAME`          | The name of the Docker network.                   | `app_network`         |
| `PHPMYADMIN_CONTAINER_NAME` | The name of the phpMyAdmin container.             | `app_phpmyadmin`      |
| `PHPMYADMIN_IMAGE`          | The Docker image for phpMyAdmin.                  | `phpmyadmin`          |
| `PHPMYADMIN_VERSION`        | The version of the phpMyAdmin image.              | `latest`              |
| `PHPMYADMIN_URL`            | The URL for phpMyAdmin.                           | `http://dbadmin.localhost/` |
| `PHPMYADMIN_ARBITRARY`      | Set to 0 to auto login to phpMyAdmin.             | `1`                   |

### Accessing MySQL

Once the service is running, you can connect to the MySQL server at `127.0.0.1:3306`.

This service also includes phpMyAdmin for database management. You can access it at:

- **Standalone:** `http://127.0.0.1:9000`
- **With Proxy:** `http://dbadmin.localhost:8000` (requires the proxy service to be running)