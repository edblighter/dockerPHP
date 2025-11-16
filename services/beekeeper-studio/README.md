# Beekeeper Studio Service

This service provides Beekeeper Studio, a modern and easy-to-use database management tool that supports multiple databases including PostgreSQL, MySQL, MariaDB, SQLite, Redis, and more.

## Configuration

The service can be configured using environment variables. You can use the `.env.beekeeper-studio` file to override default values.

### Environment Variables

- `BEEKEEPER_CONTAINER_NAME`: Container name (default: `app_beekeeper`)
- `BEEKEEPER_EXTERNAL_PORT`: External port to access Beekeeper Studio via noVNC (default: `8080`)
- `BEEKEEPER_INTERNAL_PORT`: Internal port used by Beekeeper Studio container (default: `8080`)
- `BEEKEEPER_VNC_RESOLUTION`: Resolution for the VNC session (default: `1280x800`)
- `BEEKEEPER_VNC_COLOR_DEPTH`: Color depth for the VNC session (default: `24`)
- `BEEKEEPER_MEM_LIMIT`: Memory limit for the Beekeeper Studio container (default: `512M`)

## Usage

### Standalone

To run Beekeeper Studio standalone:

```bash
docker compose -f services/beekeeper-studio/docker-compose.yml up -d
```

Or with custom environment:

```bash
docker compose -f services/beekeeper-studio/docker-compose.yml --env-file services/beekeeper-studio/.env.beekeeper-studio up -d
```

Access Beekeeper Studio at `http://127.0.0.1:8080` or via Traefik at `http://beekeeper.localhost:8080` (if you have the proper DNS resolution setup).

### Integrated

Beekeeper Studio is also available as part of the integrated tools stack. When you run:

```bash
docker compose -f docker-compose.tools.yml up -d
```

Beekeeper Studio will be available at `http://beekeeper.localhost:8080` (if you have the proper DNS resolution setup).

## Access

Beekeeper Studio runs in a VNC session accessible through noVNC in your browser. The interface allows you to connect to various databases including those in your Docker setup.

## Notes

- The default VNC password is `securepass` (defined in the Dockerfile)
- Beekeeper Studio supports connections to PostgreSQL, MySQL, MariaDB, SQLite, Redis, and other databases
- The container runs a lightweight XFCE desktop environment with Beekeeper Studio automatically started