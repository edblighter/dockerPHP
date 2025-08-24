# Nginx Service

This service provides a high-performance web server, reverse proxy, and load balancer called [Nginx](https://www.nginx.com/). It is known for its stability, rich feature set, and low resource consumption.

## Key Features

- **High Performance:** Nginx is designed for high-concurrency and can handle thousands of simultaneous connections with a small memory footprint.
- **Reverse Proxy:** Use Nginx as a reverse proxy to distribute traffic across multiple backend servers, improving scalability and reliability.
- **Load Balancing:** Nginx can be configured as a load balancer to distribute traffic across a group of servers, ensuring high availability and performance.

## Standalone Usage

To run the Nginx service as a standalone container, execute the following command from the project's root directory:

```bash
docker-compose -f services/nginx/docker-compose.yml up -d
```

This will start the Nginx container with the default configuration values.

### Customization

For advanced customization, you can use the `.env.nginx` file. To apply your custom settings, run the following command:

```bash
docker-compose -f services/nginx/docker-compose.yml --env-file services/nginx/.env.nginx up -d
```

The following variables can be customized in the `.env.nginx` file:

| Variable                   | Description                                       | Default Value         |
| -------------------------- | ------------------------------------------------- | --------------------- |
| `APP_NGINX_CONTAINER_NAME` | The name of the Nginx container.                  | `app_nginx`           |
| `APP_HTTP_PORT`            | The HTTP port for Nginx.                          | `8000`                |
| `NGINX_IMAGE`              | The Docker image for Nginx.                       | `nginx`               |
| `NGINX_VERSION`            | The version of the Nginx image.                   | `stable-alpine`       |
| `APP_TIMEZONE`             | The timezone for the container.                   | `America/Manaus`      |
| `APP_NETWORK_NAME`         | The name of the Docker network.                   | `app_network`         |

### Configuration

The Nginx configuration is managed through the files in `services/nginx/conf/`. You can create virtual hosts in the `services/nginx/conf/sites-enabled/` directory.