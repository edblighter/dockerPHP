# Traefik Service

This service provides a modern reverse proxy and load balancer called [Traefik](https://traefik.io/). It is designed to make deploying microservices easy and integrates with your existing infrastructure components.

## Key Features

- **Container-Native:** Traefik is designed to work with containers and automatically discovers and configures itself based on your container labels.
- **Automatic Service Discovery:** Traefik automatically discovers and configures itself based on your container labels, so you don't have to manually configure your reverse proxy.
- **Let's Encrypt Integration:** Traefik can automatically generate and renew SSL certificates from Let's Encrypt, so you can easily secure your services with HTTPS.

## Standalone Usage

To run the Traefik service as a standalone container, execute the following command from the project's root directory:

```bash
docker-compose -f services/traefik/docker-compose.yml up -d
```

This will start the Traefik container with the default configuration values.

### Customization

For advanced customization, you can use the `.env.traefik` file. To apply your custom settings, run the following command:

```bash
docker-compose -f services/traefik/docker-compose.yml --env-file services/traefik/.env.traefik up -d
```

The following variables can be customized in the `.env.traefik` file:

| Variable                     | Description                                       | Default Value    |
| ---------------------------- | ------------------------------------------------- | ---------------- |
| `APP_TRAEFIK_CONTAINER_NAME` | The name of the Traefik container.                | `tools_traefik`  |
| `TRAEFIK_IMAGE`              | The Docker image for Traefik.                     | `traefik`        |
| `TRAEFIIK_VERSION`            | The version of the Traefik image.                 | `latest`         |
| `APP_NETWORK_NAME`           | The name of the Docker network.                   | `app_network`    |

### Accessing Traefik

Once the service is running, you can access the Traefik dashboard at `http://127.0.0.1:8080`.