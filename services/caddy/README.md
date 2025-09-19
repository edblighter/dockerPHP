# Caddy Service

## Overview
This service provides [Caddy](https://caddyserver.com/), a modern, open-source web server with automatic HTTPS. It's designed for simplicity and security in web hosting.

## Features
- **Automatic HTTPS:** Zero-config SSL/TLS certificates via Let's Encrypt.
- **Simple Config:** Human-readable Caddyfile syntax.
- **Extensible:** Plugin system for additional features.
- **Reverse Proxy:** Built-in support for proxying to backend services.

## Prerequisites
- Docker and Docker Compose installed.
- Ports 80 and 443 available for HTTP/HTTPS.
- Domain name for automatic HTTPS (optional).

## Quick Start
1. Run: `docker-compose -f services/caddy/docker-compose.yml up -d`
2. Access at `https://info.localhost` (ignore self-signed cert warning).

## Configuration
Customize via `.env.caddy`:

| Variable                   | Description                                       | Default Value       |
| -------------------------- | ------------------------------------------------- | ------------------- |
| `APP_CADDY_CONTAINER_NAME` | The name of the Caddy container.                  | `app_caddy`         |
| `CADDY_IMAGE`              | The Docker image for Caddy.                       | `caddy`             |
| `CADDY_VERSION`            | The version of the Caddy image.                   | `alpine`            |
| `CADDY_MEM_LIMIT`          | The memory limit for the Caddy container.         | `300M`              |
| `APP_HTTP_PORT`            | The HTTP port for Caddy.                          | `8000`              |
| `APP_HTTPS_PORT`           | The HTTPS port for Caddy.                         | `443`               |
| `APP_TIMEZONE`             | The timezone for the container.                   | `America/Manaus`    |
| `APP_NETWORK_NAME`         | The name of the Docker network.                   | `app_network`       |

## Usage
- **Caddyfile:** Main config in `services/caddy/conf/Caddyfile`.
- **Sites:** Virtual hosts in `services/caddy/conf/sites/`.
- **Snippets:** Reusable configs in `services/caddy/conf/snippets/`.
- **Mount Point:** `/srv` maps to host `app` folder.
- **Logs:** View with `docker logs app_caddy`.

## Troubleshooting
- **HTTPS Issues:** Add `{ auto_https off }` to Caddyfile for local dev.
- **Port Conflicts:** Ensure 80/443 are free or change ports.
- **Config Errors:** Validate Caddyfile syntax.
- **Permissions:** Check file permissions in mounted directories.

## Links
- [Caddy Documentation](https://caddyserver.com/docs/)
- [Caddyfile Syntax](https://caddyserver.com/docs/caddyfile)