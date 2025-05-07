# Laravel Docker Setup

Complete Docker environment for Laravel development, including support for multiple databases, web servers, and auxiliary services.

> Also avaiable in [pt_BR](./README.pt_BR.md)

---

## 🔧 Available Services

- **PHP-FPM 8.3**
- **MySQL 8 and PHPMyAdmin**
- **PostgreSQL 17 and Adminer**
- **Redis**
- **MailHog**

---

## 🌐 Available Web Servers

Choose between:

- **Nginx (Alpine)** – lightweight and widely used
- **Caddy** – with automatic local SSL support (self-signed)

---

## ✅ Requirements

Make sure the following software is installed:

- `sudo`
- [Docker](https://docs.docker.com/engine/install/)
- [Docker Compose](https://docs.docker.com/compose/install/)

---

## 📦 Commands to Run

Choose the web server (**nginx** or **caddy**) and the database (**mysql** or **postgres**) to spin up the services:

```bash
./run.sh caddy mysql up
```

> This command will create the containers: **app_php**, **app_caddy**, **app_redis**, **app_mysql**, **app_mailhog**, **app_phpmyadmin**; along with the volume **redis_cache** and the network **app_network**.

To remove the services, run:

```bash
./run.sh caddy mysql down
# or
./run.sh clear
```

> 💡 Docker commands use `sudo` by default. To execute commands inside containers, use:

```bash
sudo docker exec <container_name> <command>
```

---

## 📥 Installing Project Dependencies

Clone your Laravel project into the `app` folder:

```bash
git clone <url> app
```

The `app` folder will be mounted as:

- `/var/www` (for Nginx)
- `/srv` (for Caddy)

Then run:

```bash
sudo docker exec app_php composer install --no-dev --optimize-autoloader
cp ./app/.env.example ./app/.env
sudo docker exec app_php php artisan key:generate
sudo docker exec app_php php artisan migrate
```

Access your app via:

- **Nginx**: [http://app.localhost:8000](http://app.localhost:8000)
- **Caddy**: [https://app.localhost](https://app.localhost) _(ignore the security warning — it's common with self-signed certificates)_

---

## 🛠️ Permission Issues

If you encounter permission errors while accessing the system, run:

```bash
sudo docker exec -it app_php sh
chmod 755 -R *
exit
```

> ⚠️ Permission and network issues have been observed when using WSL. It's recommended to run on a native Linux machine.

---

## ✅ Running Tests

```bash
sudo docker exec app_php composer install
cp ./app/.env.example ./app/.env
sudo docker exec app_php php artisan key:generate
sudo docker exec app_php php artisan migrate
sudo docker exec app_php php artisan test
```

---

## 🧪 Auxiliary Tools

- **DBAdmin**: [http://dbadmin.localhost:8000](http://dbadmin.localhost:8000) _(phpMyAdmin for MySQL or Adminer for PostgreSQL)_

- **MailHog**: [http://mailhog.localhost:8000](http://mailhog.localhost:8000)

---

> Designed to streamline local Laravel development with Docker.  
> Customize the .env.app as needed for your project and don't forget to mirror the changes in your project's Laravel .env
