# Portainer Service

This service provides a lightweight and easy-to-use management UI for Docker called [Portainer](https://www.portainer.io/). It allows you to manage your Docker environments from a graphical interface, making it easy to deploy, monitor, and manage your containers.

## Key Features

- **Web-Based Management:** Manage your Docker environments from anywhere with a web browser.
- **Multi-Environment Support:** Portainer can manage multiple Docker environments, including local and remote environments.
- **User-Friendly Interface:** With its intuitive interface, Portainer is easy to learn and use, even for beginners.

## Standalone Usage

To run the Portainer service as a standalone container, execute the following command from the project's root directory:

```bash
docker-compose -f services/portainer/docker-compose.yml up -d
```

This will start the Portainer container with the default configuration values.

### Customization

For advanced customization, you can use the `.env.portainer` file. To apply your custom settings, run the following command:

```bash
docker-compose -f services/portainer/docker-compose.yml --env-file services/portainer/.env.portainer up -d
```

The following variables can be customized in the `.env.portainer` file:

| Variable                       | Description                                       | Default Value              |
| ------------------------------ | ------------------------------------------------- | -------------------------- |
| `PORTAINER_IMAGE`              | The Docker image for Portainer.                   | `portainer/portainer-ce`   |
| `PORTAINER_VERSION`            | The version of the Portainer image.               | `latest`                   |
| `APP_PORTAINER_CONTAINER_NAME` | The name of the Portainer container.              | `app_manager`              |
| `APP_NETWORK_NAME`             | The name of the Docker network.                   | `app_network`              |

### Accessing Portainer

Once the service is running, you can access Portainer at the following URLs:

- **Standalone:** `http://127.0.0.1:9000`
- **With Proxy:** `http://manager.localhost` (requires the proxy service to be running)