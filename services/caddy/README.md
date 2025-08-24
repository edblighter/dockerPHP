# Caddy Service

This service provides a powerful and easy-to-use web server called [Caddy](https://caddyserver.com/). It's a modern, open-source web server with automatic HTTPS, making it an excellent choice for secure and efficient web hosting.

## Key Features

- **Automatic HTTPS:** Caddy automatically enables HTTPS for your sites, ensuring secure connections without the hassle of manual certificate management.
- **Simple Configuration:** With a human-readable Caddyfile, configuring your web server is straightforward and intuitive.
- **Extensible:** Caddy can be extended with a variety of plugins to add new features and functionality.

## Standalone Usage

To run the Caddy service as a standalone container, execute the following command from the project's root directory:

```bash
docker-compose -f services/caddy/docker-compose.yml up -d
```

This will start the Caddy container with the default configuration values.

### Customization

For advanced customization, you can use the `.env.caddy` file. To apply your custom settings, run the following command:

```bash
docker-compose -f services/caddy/docker-compose.yml --env-file services/caddy/.env.caddy up -d
```

The following variables can be customized in the `.env.caddy` file:

| Variable                   | Description                                       | Default Value       |
| -------------------------- | ------------------------------------------------- | ------------------- |
| `CADDY_IMAGE`              | The Docker image for Caddy.                       | `caddy`             |
| `CADDY_VERSION`            | The version of the Caddy image.                   | `alpine`            |
| `APP_CADDY_CONTAINER_NAME` | The name of the Caddy container.                  | `app_caddy`         |
| `CADDY_MEM_LIMIT`          | The memory limit for the Caddy container.         | `300M`              |
| `APP_HTTP_PORT`            | The HTTP port for Caddy.                          | `8000`              |
| `APP_HTTPS_PORT`           | The HTTPS port for Caddy.                         | `443`               |
| `APP_TIMEZONE`             | The timezone for the container.                   | `America/Manaus`    |
| `APP_NETWORK_NAME`         | The name of the Docker network.                   | `app_network`       |

### Configuration

The Caddy configuration is managed through the `Caddyfile` located in `services/caddy/conf/`. You can also create virtual hosts in the `services/caddy/conf/sites/` directory and use snippets from `services/caddy/conf/snippets/`.

To disable the automatic HTTPS redirect, you can add `{ auto_https off }` at the beginning of the `Caddyfile`.