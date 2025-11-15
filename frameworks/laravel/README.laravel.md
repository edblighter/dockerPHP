# Using with Laravel

## Before start

Clone your Laravel project into the `app` folder:

```bash
git clone <url> app/<project_name>
```

## 📥 Installing Project Dependencies

run:

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

> Designed to streamline local Laravel development with Docker.  
> Customize the .env.app as needed for your project and don't forget to mirror the changes in your project's Laravel .env