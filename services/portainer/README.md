# Portainer Service

## Overview
This service provides [Portainer](https://www.portainer.io/), a lightweight, user-friendly management UI for Docker environments.

## Features
- **Web-Based Management:** Manage Docker from any web browser.
- **Multi-Environment:** Supports local and remote Docker environments.
- **User-Friendly:** Intuitive interface for beginners and experts.
- **Container Management:** Deploy, monitor, and manage containers easily.

## Prerequisites
- Docker and Docker Compose installed.
- Docker socket access for management.

## Quick Start
1. Run: `docker-compose -f services/portainer/docker-compose.yml up -d`
2. Access at `http://127.0.0.1:9000` or `http://manager.localhost` (with proxy).
3. Set up admin user on first login.

## Configuration
Customize via `.env.portainer`:

| Variable                       | Description                                       | Default Value              |
| ------------------------------ | ------------------------------------------------- | -------------------------- |
| `APP_PORTAINER_CONTAINER_NAME` | The name of the Portainer container.              | `app_manager`              |
| `PORTAINER_IMAGE`              | The Docker image for Portainer.                   | `portainer/portainer-ce`   |
| `PORTAINER_VERSION`            | The version of the Portainer image.               | `latest`                   |
| `PORTAINER_MEM_LIMIT`          | Memory limit for Portainer.                       | `256M`                    |
| `APP_NETWORK_NAME`             | The name of the Docker network.                   | `app_network`              |

## Usage
- **Dashboard:** Overview of containers, images, networks.
- **Container Management:** Start, stop, logs, exec into containers.
- **Stacks:** Deploy with Docker Compose.
- **Registries:** Manage Docker registries.
- **Users:** Role-based access control.

## Troubleshooting
- **Access Denied:** Ensure Docker socket is accessible.
- **Port Conflicts:** Check if port 9000 is available.
- **First Login:** Create admin user if prompted.
- **Permissions:** Run with appropriate Docker group permissions.

## Links
- [Portainer Documentation](https://docs.portainer.io/)
- [Getting Started](https://docs.portainer.io/start/intro)