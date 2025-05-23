# Docker Setup for PHP Development

Complete Docker environment for PHP(Original project intended for Laravel) development, including support for multiple databases, web servers, and auxiliary services.

> Também disponível em [pt_BR](./README.pt_BR.md)

---

## 🔧 Available Services

- **PHP-FPM** - Versions [8.4, 8.3, 8.2, 7.4 and 5.6] available with common built-in modules and tools like Bun and composer.
- **MySQL/MariaDB and PHPMyAdmin** - The variant can be chosen at startup and versions can be altered via env variable.
- **PostgreSQL and Adminer** - Multiple versions of the PostgreSQL available via env variables.
- **Redis** 
- **MailHog**

---

## 🌐 Available Web Servers

Choose between:

- **Nginx** – lightweight and widely used
- **Caddy** – with automatic local SSL support (self-signed)

---

## ✅ Requirements

Make sure the following software is installed:

- `sudo`
- [Docker](https://docs.docker.com/engine/install/)
- [Docker Compose](https://docs.docker.com/compose/install/)

## Before start

The `app` folder will be mounted as:

- `/var/www` (for Nginx)
- `/srv` (for Caddy)

it already contain the folder public with an index.html and an index.php to test the web server after the boot.

---

## 📦 Commands to Run

Choose the web server (**nginx** or **caddy**) and the database (**mysql**, **mariadb** or **postgres**) to spin up the services:

```bash
./run.sh caddy mysql up
```
> This command will create the containers: **app_php**, **app_caddy**, **app_redis**, **app_mysql**, **app_mailhog**, **app_phpmyadmin**; along with the volume **redis_cache** and the network **app_network**.

at the end of the boot process you can test the web server at

- **Nginx**: [http://info.localhost:8000](http://info.localhost:8000)
- **Caddy**: [https://info.localhost](https://info.localhost) _(ignore the security warning — it's common with self-signed certificates)_



To remove the services, run:

```bash
./run.sh caddy mysql down
# or
./run.sh clear  # this will remove all containers with default value and prompt for prune cache.
```

> 💡 Docker commands use `sudo` by default. To execute commands inside containers, use:

```bash
sudo docker exec <container_name> <command>
```

---

## 🧪 Auxiliary Tools

- **DBAdmin**: [http://dbadmin.localhost:8000](http://dbadmin.localhost:8000) _(phpMyAdmin for MySQL/MariaDB or Adminer for PostgreSQL)_

- **MailHog**: [http://mailhog.localhost:8000](http://mailhog.localhost:8000)

---
