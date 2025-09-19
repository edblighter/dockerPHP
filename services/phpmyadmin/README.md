# phpMyAdmin Service

## Overview
This service provides [phpMyAdmin](https://www.phpmyadmin.net/), a free, open-source web-based administration tool for MySQL and MariaDB databases.

## Features
- **Web-Based Management:** Manage databases from any web browser.
- **Full-Featured:** Database/table management, SQL queries, import/export.
- **User-Friendly:** Intuitive interface suitable for beginners and experts.
- **Multi-Language:** Supports multiple languages.

## Prerequisites
- Docker and Docker Compose installed.
- MySQL or MariaDB service running.

## Quick Start
1. Run: `docker-compose -f services/phpmyadmin/docker-compose.yml up -d`
2. Access at `http://dbadmin.localhost:8000` (with proxy) or standalone port.

## Configuration
Customize via `.env.phpmyadmin`:

| Variable                    | Description                                       | Default Value         |
| --------------------------- | ------------------------------------------------- | --------------------- |
| `PHPMYADMIN_CONTAINER_NAME` | The name of the phpMyAdmin container.             | `app_phpmyadmin`      |
| `PHPMYADMIN_IMAGE`          | The Docker image for phpMyAdmin.                  | `phpmyadmin`          |
| `PHPMYADMIN_VERSION`        | The version of the phpMyAdmin image.              | `latest`              |
| `PHPMYADMIN_ARBITRARY`      | Set to 0 to auto login.                           | `1`                   |
| `PHPMYADMIN_URL`            | The URL for phpMyAdmin.                           | `http://dbadmin.localhost/` |
| `DB_HOST`                   | The hostname of the database server.              | `db`                  |
| `MYSQL_PORT`                | The port of the database server.                  | `3306`                |
| `APP_MYSQL_USER`            | The user for the database.                        | `laravel`             |
| `APP_MYSQL_PASSWORD`        | The password for the database user.               | `secret`              |
| `APP_TIMEZONE`              | The timezone for the container.                   | `America/Manaus`      |
| `APP_NETWORK_NAME`          | The name of the Docker network.                   | `app_network`         |

**Note:** User/password are used only when `PHPMYADMIN_ARBITRARY=0` for auto-login.

## Usage
- **Access:** Web interface at configured URL.
- **Login:** Use database credentials or set auto-login.
- **Features:** Browse databases, run queries, manage users.
- **Import/Export:** Support for SQL, CSV, and other formats.

## Troubleshooting
- **Login Failed:** Verify database credentials and connection.
- **Connection Refused:** Ensure MySQL/MariaDB is running and accessible.
- **Auto-Login Issues:** Set `PHPMYADMIN_ARBITRARY=0` and provide credentials.
- **Performance:** Monitor with phpMyAdmin's status page.

## Links
- [phpMyAdmin Documentation](https://docs.phpmyadmin.net/en/latest/)
- [User Guide](https://docs.phpmyadmin.net/en/latest/user.html)