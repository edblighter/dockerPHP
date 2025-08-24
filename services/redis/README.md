# Redis Service

This service provides an in-memory data structure store called [Redis](https://redis.io/). It can be used as a database, cache, and message broker.

## Key Features

- **In-Memory Data Store:** Redis stores data in memory, which allows for extremely fast read and write operations.
- **Versatile Data Structures:** Redis supports a variety of data structures, including strings, hashes, lists, sets, and sorted sets.
- **High Availability:** Redis can be configured for high availability with Redis Sentinel and Redis Cluster.

## Standalone Usage

To run the Redis service as a standalone container, execute the following command from the project's root directory:

```bash
docker-compose -f services/redis/docker-compose.yml up -d
```

This will start the Redis container with the default configuration values.

### Customization

For advanced customization, you can use the `.env.redis` file. To apply your custom settings, run the following command:

```bash
docker-compose -f services/redis/docker-compose.yml --env-file services/redis/.env.redis up -d
```

The following variables can be customized in the `.env.redis` file:

| Variable          | Description                                       | Default Value    |
| ----------------- | ------------------------------------------------- | ---------------- |
| `REDIS_CONTAINER` | The name of the Redis container.                  | `app_redis`      |
| `REDIS_IMAGE`     | The Docker image for Redis.                       | `redis`          |
| `REDIS_VERSION`   | The version of the Redis image.                   | `alpine`         |
| `APP_REDIS_PORT`  | The external port for Redis.                      | `6379`           |
| `APP_TIMEZONE`    | The timezone for the container.                   | `America/Manaus` |
| `APP_NETWORK_NAME`| The name of the Docker network.                   | `app_network`    |
| `REDIS_MEM_LIMIT` | The memory limit for the Redis container.         | `500M`           |

### Accessing Redis

Once the service is running, you can connect to the Redis server at `127.0.0.1:6379`.