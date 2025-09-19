# MongoDB Service

## Overview
This service provides [MongoDB](https://www.mongodb.com/), a powerful and flexible NoSQL database. It's a document-oriented database that stores data in JSON-like documents, making it easy to work with and scale.

## Features
- **Flexible Data Model:** Store data in flexible, JSON-like documents that can evolve over time.
- **Scalability:** Scale your database horizontally across multiple servers to handle growing amounts of data and traffic.
- **Rich Query Language:** Use a powerful query language to perform complex queries and aggregations on your data.

## Prerequisites
- Docker and Docker Compose installed.

## Quick Start
1. Run: `docker-compose -f services/mongodb/docker-compose.yml up -d`
2. Connect to the MongoDB server at `mongodb://admin:change_this_password@127.0.0.1:27017`.

## Configuration
Customize via `.env.mongodb`:

| Variable | Description | Default Value |
|---|---|---|
| `MONGODB_IMAGE` | The Docker image for MongoDB. | `mongo` |
| `MONGODB_VERSION` | The version of the MongoDB image. | `latest` |
| `MONGODB_CONTAINER_NAME`| The name of the MongoDB container. | `app_mongodb` |
| `MONGODB_PORT` | The external port for MongoDB. | `27017` |
| `MONGO_INITDB_ROOT_USERNAME`| The root username for the database. | `admin` |
| `MONGO_INITDB_ROOT_PASSWORD`| The root password for the database. | `change_this_password`|
| `MONGODB_DATA_DIR` | The directory for MongoDB data. | `mongo_data` |
| `APP_NETWORK_NAME` | The name of the Docker network. | `app_network` |

## Usage
- **Connection:** Host `mongodb`, Port `27017` (internal), or `127.0.0.1:27017` (external).
- **Data Persistence:** Stored in the `mongo_data` volume.
- **Healthcheck:** Monitors MongoDB connection.

## Troubleshooting
- **Connection Refused:** Check if the container is running and the ports are open.
- **Authentication Failed:** Verify the username and password.
- **Data Loss:** Ensure the `MONGODB_DATA_DIR` volume is correctly mounted.

## Links
- [MongoDB Documentation](https://docs.mongodb.com/)
- [MongoDB Docker Hub](https://hub.docker.com/_/mongo)
