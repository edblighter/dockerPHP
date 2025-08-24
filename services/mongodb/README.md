# MongoDB Service

This service provides a powerful and flexible NoSQL database called [MongoDB](https://www.mongodb.com/). It's a document-oriented database that stores data in JSON-like documents, making it easy to work with and scale.

## Key Features

- **Flexible Data Model:** Store data in flexible, JSON-like documents that can evolve over time.
- **Scalability:** Scale your database horizontally across multiple servers to handle growing amounts of data and traffic.
- **Rich Query Language:** Use a powerful query language to perform complex queries and aggregations on your data.

## Standalone Usage

To run the MongoDB service as a standalone container, execute the following command from the project's root directory:

```bash
docker-compose -f services/mongodb/docker-compose.yml up -d
```

This will start the MongoDB container with the default configuration values.

### Customization

For advanced customization, it is recommended to use environment variables. You can create a `.env.mongodb` file with the following content:

```
MONGODB_IMAGE=mongo
MONGODB_VERSION=latest
MONGODB_CONTAINER_NAME=app_mongodb
MONGODB_PORT=27017
MONGO_INITDB_ROOT_USERNAME=admin
MONGO_INITDB_ROOT_PASSWORD=change_this_password
MONGODB_DATA_DIR=mongo_data
APP_NETWORK_NAME=app_network
```

Then, update the `docker-compose.yml` to use these variables:

```yaml
services:
  mongodb:
    image: ${MONGODB_IMAGE:-mongo}:${MONGODB_VERSION:-latest}
    container_name: ${MONGODB_CONTAINER_NAME:-app_mongodb}
    environment:
      MONGO_INITDB_ROOT_USERNAME: ${MONGO_INITDB_ROOT_USERNAME:-admin}
      MONGO_INITDB_ROOT_PASSWORD: ${MONGO_INITDB_ROOT_PASSWORD:-change_this_password}
    ports:
      - "${MONGODB_PORT:-27017}:27017"
    volumes:
      - ${MONGODB_DATA_DIR:-mongo_data}:/data/db
    networks:
      - ${APP_NETWORK_NAME:-app_network}
networks:
  app_network:
    name: ${APP_NETWORK_NAME:-app_network}
    driver: bridge
    external: true
```

### Healthcheck

To ensure the container is running correctly, you can add a healthcheck to the service in the `docker-compose.yml` file:

```yaml
healthcheck:
  test: echo 'db.runCommand("ping").ok' | mongo localhost:27017/test --quiet
  interval: 10s
  timeout: 5s
  retries: 5
```

### Accessing MongoDB

Once the service is running, you can connect to the MongoDB server at `mongodb://admin:change_this_password@127.0.0.1:27017`.