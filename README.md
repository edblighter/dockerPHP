# Docker Setup for PHP Development

A complete Docker environment for local PHP development, offering a selection of web servers, databases, and essential development tools.

> Also available in [pt_BR](./README.pt_BR.md)

---

## Features

- **Multiple PHP Versions:** Switch between PHP 5.6, 7.4, 8.2, 8.3, and 8.4.
- **Flexible Web Servers:** Choose between Nginx (default) or Caddy with automatic HTTPS.
- **Database Variety:** Supports MySQL (default), MariaDB, and PostgreSQL.
- **Essential Tools:** Comes with Redis for caching and Mailpit for email testing.
- **Easy Management:** Use `run.sh` for command-line operations or `menu.sh` for an interactive experience.
- **Auxiliary Services:** Includes optional services like Portainer, Traefik, and Jenkins for advanced management and CI/CD.

---

## ✅ Requirements

- [Docker](https://docs.docker.com/engine/install/)
- [Docker Compose](https://docs.docker.com/compose/install/)
- `sudo` permissions

---

## 🚀 Quick Start

1.  **Clone the repository and navigate to the project directory.**

2.  **Place your PHP project files in the `app/` directory.**
    The `app/` directory is mounted as the web server's root:
    - Nginx: `/var/www`
    - Caddy: `/srv`

3.  **Run the interactive setup menu:**
    ```bash
    ./menu.sh
    ```
    Alternatively, use the `run.sh` script for a non-interactive setup. For example, to start with Nginx and MySQL:
    ```bash
    ./run.sh -w nginx -d mysql up
    ```

4.  **Access your application:**
    - **Nginx:** [http://info.localhost:8000](http://info.localhost:8000)
    - **Caddy:** [https://info.localhost](https://info.localhost) (ignore the self-signed certificate warning)

---

## 📦 Usage

This environment is managed by two main scripts: `run.sh` and `menu.sh`.

### Interactive Menu (`menu.sh`)

For a guided setup, simply run:
```bash
./menu.sh
```
This script will walk you through selecting a web server, database, and other options.

### Command-Line Script (`run.sh`)

The `run.sh` script provides a direct way to manage the environment.

**Syntax:**
```bash
./run.sh [options] [command]
```

**Options:**
| Option | Description | Default |
|---|---|---|
| `-w`, `--web <server>` | Choose a web server (`nginx` or `caddy`). | `nginx` |
| `-d`, `--database <db>` | Choose a database (`mysql`, `mariadb`, or `postgres`). | `mysql` |
| `-H`, `--help` | Display the help screen. | |

**Commands:**
| Command | Description |
|---|---|
| `up` | Start and build the services. |
| `down` | Stop the services. |
| `clear` | Stop and remove all containers, volumes, and data. **Warning: This is destructive.** |

**Examples:**
```bash
# Start with Nginx and MySQL
./run.sh -w nginx -d mysql up

# Stop the environment
./run.sh down

# Clear the entire environment
./run.sh clear
```

---

## 🔧 Services

This setup includes a variety of services that can be combined to fit your needs.

### Core Services
| Service | Description |
|---|---|
| **PHP-FPM** | PHP interpreter with versions 5.6 to 8.4. |
| **Web Server** | Nginx or Caddy. |
| **Database** | MySQL, MariaDB, or PostgreSQL. |
| **Redis** | In-memory data store for caching. |
| **Mailpit** | Email testing tool. |

### Auxiliary Tools
These services are optional and can be started independently.

| Service | Description | Access |
|---|---|---|
| **DBAdmin** | phpMyAdmin for MySQL/MariaDB or Adminer for PostgreSQL. | [http://dbadmin.localhost:8000](http://dbadmin.localhost:8000) |
| **Portainer** | Docker management UI. | [http://manager.localhost:9000](http://manager.localhost:9000) |
| **Traefik** | Reverse proxy and load balancer. | [http://localhost:8080](http://localhost:8080) (Dashboard) |
| **Jenkins** | CI/CD automation server. | [http://localhost:8085](http://localhost:8085) |

---

## 📚 Service Documentation

For detailed information on each service, including configuration and advanced usage, please refer to their individual `README.md` files:

- [PHP](./services/php/README.md)
- [Nginx](./services/nginx/README.md)
- [Caddy](./services/caddy/README.md)
- [MySQL](./services/mysql/README.md)
- [MariaDB](./services/mariadb/README.md)
- [PostgreSQL](./services/postgres/README.md)
- [Redis](./services/redis/README.md)
- [Mailpit](./services/mailpit/README.md)
- [PHPMyAdmin](./services/phpmyadmin/README.md)
- [Adminer](./services/adminer/README.md)
- [Portainer](./services/portainer/README.md)
- [Traefik](./services/traefik/README.md)
- [Jenkins](./services/jenkins/README.md)

---

## ⚙️ Configuration

- **Environment Variables:** Customize versions, ports, and other settings in `.env.app`.
- **PHP Configuration:** Adjust PHP settings in `services/php/conf/php.ini` and `www.conf`.
- **Service Configuration:** Modify the `docker-compose.yml` files and `.env` files within each service's directory for more advanced changes.

---

## 💡 Troubleshooting

- **Port Conflicts:** If a service fails to start, check if the required ports are already in use. You can change the ports in the corresponding `.env` files.
- **Permission Errors:** Ensure that the user running the Docker commands has the necessary permissions to access the Docker daemon and the project files.
- **Logs:** To inspect the logs of a specific container, use `docker logs <container_name>`.
- **Resetting the Environment:** If you encounter persistent issues, you can reset the entire environment with `./run.sh clear`. **Warning: This will delete all data.**
