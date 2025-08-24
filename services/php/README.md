# PHP Service

This service provides the [PHP](https://www.php.net/) interpreter, a popular general-purpose scripting language that is especially suited to web development.

## Key Features

- **Widely Used:** PHP is one of the most popular programming languages for web development, with a large and active community.
- **Easy to Learn:** PHP is known for its gentle learning curve, making it a great choice for beginners.
- **Cross-Platform:** PHP is available on all major operating systems, including Windows, macOS, and Linux.

## Standalone Usage

To run the PHP service as a standalone container, execute the following command from the project's root directory:

```bash
docker-compose -f services/php/docker-compose.yml up -d
```

This will start the PHP container with the default configuration values.

### Customization

For advanced customization, you can use the `.env.php` file. To apply your custom settings, run the following command:

```bash
docker-compose -f services/php/docker-compose.yml --env-file services/php/.env.php up -d
```

The following variables can be customized in the `.env.php` file:

| Variable           | Description                                       | Default Value    |
| ------------------ | ------------------------------------------------- | ---------------- |
| `APP_CONTAINER_NAME` | The name of the PHP container.                    | `app_php`        |
| `PHP_VERSION`      | The version of PHP to use.                        | `5.6`            |
| `PHP_VARIANT`      | The variant of the PHP image to use.              | `.alpine`        |
| `APP_TIMEZONE`     | The timezone for the container.                   | `America/Manaus` |
| `APP_NETWORK_NAME` | The name of the Docker network.                   | `app_network`    |

**Note:** The `PHP_VARIANT` is only applicable for PHP 8.4. For other versions, leave it empty.

### Features

- The `app` folder is shared at `/var/www/`.
- The container has Bun integrated in the versions 8.4, 8.3 and 8.2 and composer to all versions.
- The PHP service runs only in the internal `app_network` at the port 9000.