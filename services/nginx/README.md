# Nginx Service

## Overview
This service provides [Nginx](https://www.nginx.com/), a high-performance web server, reverse proxy, and load balancer known for stability, rich features, and low resource consumption.

## Features
- **High Performance:** Handles thousands of concurrent connections with minimal memory.
- **Reverse Proxy:** Distributes traffic to backend servers for scalability.
- **Load Balancing:** Ensures high availability and performance across servers.
- **SSL/TLS Support:** Built-in support for secure connections.

## Prerequisites
- Docker and Docker Compose installed.
- Ensure port 8000 is available.

## Quick Start
1. Run: `docker-compose -f services/nginx/docker-compose.yml up -d`
2. Access at `http://info.localhost:8000`

## Configuration
Customize via `.env.nginx`:

| Variable                   | Description                                       | Default Value         |
| -------------------------- | ------------------------------------------------- | --------------------- |
| `APP_NGINX_CONTAINER_NAME` | The name of the Nginx container.                  | `app_nginx`           |
| `NGINX_IMAGE`              | The Docker image for Nginx.                       | `nginx`               |
| `NGINX_VERSION`            | The version of the Nginx image.                   | `stable-alpine`       |
| `NGINX_MEM_LIMIT`          | Memory limit for Nginx.                           | `256M`                |
| `APP_HTTP_PORT`            | The HTTP port for Nginx.                          | `8000`                |
| `APP_TIMEZONE`             | The timezone for the container.                   | `America/Manaus`      |
| `APP_NETWORK_NAME`         | The name of the Docker network.                   | `app_network`         |

## Usage
- **Config Files:** Main config in `services/nginx/conf/nginx.conf`.
- **Sites:** Virtual hosts in `services/nginx/conf/conf.d/`.
- **Mount Point:** `/var/www` maps to host `app` folder.
- **SSL:** Configure certificates in config files.
- **Logs:** View with `docker logs app_nginx`.

## Troubleshooting
- **Config Errors:** Check syntax with `nginx -t` inside container.
- **Permission Issues:** Ensure file permissions in mounted directories.
- **Port Conflicts:** Change `APP_HTTP_PORT` if needed.
- **Performance:** Monitor with `nginx -s reload` for config reload.

## Links
- [Nginx Documentation](https://nginx.org/en/docs/)
- [Nginx Configuration Guide](https://nginx.org/en/docs/beginners_guide.html)