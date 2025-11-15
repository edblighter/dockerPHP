# ClickHouse Service

ClickHouse is a fast open-source column-oriented database management system that allows generating analytical data reports in real-time.

## Configuration

- **Image**: `clickhouse/clickhouse-server:latest`
- **Ports**:
  - `8123` for HTTP interface
  - `9000` for native interface
  - `9009` for replication
- **Volumes**: Persists data in `/var/lib/clickhouse` and config in `docker-data/clickhouse/config`

## Usage

ClickHouse can be accessed via:
- HTTP: `http://localhost:8123`
- Native client: `clickhouse-client --host localhost --port 9000`
- Through SQL clients like Beekeeper Studio

## Connection Details

- **Host**: `clickhouse` (inside Docker network)
- **Port**: `9000` (native), `8123` (HTTP)
- **User**: `admin`
- **Password**: `change_this_password`
- **Database**: `default`