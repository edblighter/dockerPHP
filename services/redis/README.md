# Redis Service

## Overview
This service provides [Redis](https://redis.io/), an in-memory data structure store used as a database, cache, and message broker. It's known for high performance and versatility.

## Features
- **In-Memory Storage:** Extremely fast read/write operations.
- **Data Structures:** Supports strings, hashes, lists, sets, sorted sets, etc.
- **Persistence:** Optional disk persistence for data durability.
- **Clustering:** Supports high availability with Redis Cluster.

## Prerequisites
- Docker and Docker Compose installed.
- Ensure port 6379 is available if exposing externally.

## Quick Start
1. Run: `docker-compose -f services/redis/docker-compose.yml up -d`
2. Connect at `127.0.0.1:6379` or internal `redis:6379`.

## Configuration
Customize via `.env.redis`:

| Variable          | Description                                       | Default Value    |
| ----------------- | ------------------------------------------------- | ---------------- |
| `REDIS_CONTAINER` | The name of the Redis container.                  | `app_redis`      |
| `REDIS_IMAGE`     | The Docker image for Redis.                       | `redis`          |
| `REDIS_VERSION`   | The version of the Redis image.                   | `alpine`         |
| `APP_REDIS_PORT`  | The external port for Redis.                      | `6379`           |
| `REDIS_MEM_LIMIT` | The memory limit for the Redis container.         | `500M`           |
| `APP_TIMEZONE`    | The timezone for the container.                   | `America/Manaus` |
| `APP_NETWORK_NAME`| The name of the Docker network.                   | `app_network`    |

## Usage
- **Connection:** Host `redis`, Port 6379 (internal), or `127.0.0.1:6379` (external).
- **Persistence:** Data stored in named volume `cache`.
- **Healthcheck:** Monitors Redis ping.
- **CLI Access:** `docker exec -it app_redis redis-cli`

## Troubleshooting
- **Connection Failed:** Check if container is running and network is correct.
- **Memory Full:** Increase `REDIS_MEM_LIMIT` or configure eviction policies.
- **Persistence Issues:** Ensure volume permissions.
- **Performance:** Monitor with `redis-cli info` for stats.

## Links
- [Redis Documentation](https://redis.io/documentation)
- [Redis Commands](https://redis.io/commands)