# PHP Service

## Overview
This service provides the [PHP](https://www.php.net/) interpreter, a popular general-purpose scripting language that is especially suited to web development. FastCGI Process Manager (FPM) is used for better performance and resource management.

## Features
- **Multiple Versions:** Supports PHP 5.6, 7.4, 8.2, 8.3, and 8.4 with variants (.alpine, .debian, .distro for 8.4).
- **Extensions:** Includes common extensions like PDO, mbstring, zip, intl, and more.
- **Tools:** Integrated Composer for dependency management and Bun for JavaScript tooling (versions 8.2+).
- **Performance:** Optimized for web applications with FPM.

## Prerequisites
- Docker and Docker Compose installed.
- Project code in the `app` folder.

## Quick Start
1. Ensure your PHP project is in the `app` folder.
2. Run: `docker-compose -f services/php/docker-compose.yml up -d`
3. Access via web server at configured ports.

## Configuration
Customize via `.env.php` file:

| Variable           | Description                                       | Default Value    |
| ------------------ | ------------------------------------------------- | ---------------- |
| `APP_CONTAINER_NAME` | The name of the PHP container.                    | `app_php`        |
| `PHP_VERSION`      | The version of PHP to use.                        | `8.4`            |
| `PHP_VARIANT`      | The variant of the PHP image to use.              | `.alpine`        |
| `PHP_MEM_LIMIT`    | Memory limit for PHP.                             | `1G`             |
| `APP_TIMEZONE`     | The timezone for the container.                   | `America/Manaus` |
| `APP_NETWORK_NAME` | The name of the Docker network.                   | `app_network`    |

**Note:** PHP_VARIANT is only for 8.4 (.alpine, .debian, .distro).

## Usage
- **Mount Point:** `/var/www/` maps to the host `app` folder.
- **Port:** Internal port 9000 on `app_network`.
- **Healthcheck:** Monitors PHP-FPM status.
- **Logs:** View with `docker logs <container_name>`.

## Troubleshooting
- **Permission Issues:** Ensure user ID matches host (default 1000).
- **Extensions Missing:** Check Dockerfile for available extensions.
- **Memory Errors:** Increase `PHP_MEM_LIMIT`.
- **Composer Issues:** Run `docker exec -it app_php composer install`.

## Links
- [PHP Official Documentation](https://www.php.net/docs.php)
- [Composer Documentation](https://getcomposer.org/doc/)
- [Bun Documentation](https://bun.sh/docs)