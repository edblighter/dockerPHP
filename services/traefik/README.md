# Traefik Service

## Overview
This service provides [Traefik](https://traefik.io/), a modern reverse proxy and load balancer designed for microservices and container-native deployments.

## Features
- **Container-Native:** Auto-discovers services via container labels.
- **Automatic Discovery:** No manual configuration needed for services.
- **Let's Encrypt:** Automatic SSL certificate generation and renewal.
- **Load Balancing:** Distributes traffic across backend services.

## Prerequisites
- Docker and Docker Compose installed.
- Services with proper Traefik labels for auto-discovery.

## Quick Start
1. Run: `docker-compose -f services/traefik/docker-compose.yml up -d`
2. Access dashboard at `http://127.0.0.1:8080`

## Configuration
Customize via `.env.traefik`:

| Variable                     | Description                                       | Default Value    |
| ---------------------------- | ------------------------------------------------- | ---------------- |
| `APP_TRAEFIK_CONTAINER_NAME` | The name of the Traefik container.                | `tools_traefik`  |
| `TRAEFIK_IMAGE`              | The Docker image for Traefik.                     | `traefik`        |
| `TRAEFIK_VERSION`            | The version of the Traefik image.                 | `latest`         |
| `TRAEFIK_MEM_LIMIT`          | Memory limit for Traefik.                         | `256M`           |
| `APP_NETWORK_NAME`           | The name of the Docker network.                   | `app_network`    |

## Usage
- **Dashboard:** Monitor routes, services, and middleware at dashboard URL.
- **Labels:** Use Traefik labels on containers for routing.
- **Middleware:** Apply rate limiting, authentication, etc.
- **Providers:** Supports Docker, Kubernetes, and more.

## Troubleshooting
- **Services Not Discovered:** Check Traefik labels on containers.
- **SSL Issues:** Ensure ports 80/443 are available for Let's Encrypt.
- **Dashboard Inaccessible:** Verify port 8080 is not blocked.
- **Config Errors:** Check Traefik logs for configuration issues.

## Links
- [Traefik Documentation](https://doc.traefik.io/traefik/)
- [Docker Provider](https://doc.traefik.io/traefik/providers/docker/)