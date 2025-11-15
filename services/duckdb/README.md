# DuckDB Service

DuckDB is an in-process analytical database designed for OLAP queries. It's like SQLite but for analytical workloads.

## Configuration

- **Image**: `duckdb/duckdb:latest`
- **Port**: `8086` (for HTTP API access), `5432` (PostgreSQL compatible)
- **Volume**: Persists data in `docker-data/duckdb/data` directory

## Usage

To run queries against DuckDB, you can access it through client applications or use tools like Beekeeper Studio which supports DuckDB connections. DuckDB can be queried via PostgreSQL-compatible interface.

## Connection Details

- **Host**: `duckdb` (inside Docker network)
- **Port**: `5432` (PostgreSQL compatible interface)
- **HTTP API**: `8086`
- **Database**: Stored in the mounted volume

Note: DuckDB typically runs as an embedded database, but this container provides a server-like interface.