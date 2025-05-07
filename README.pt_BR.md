# Laravel Docker Setup

Ambiente Docker completo para desenvolvimento com Laravel, incluindo suporte a múltiplos bancos de dados, servidores web e serviços auxiliares.

> Tambem disponível em [EN](./README.md)

---

## 🔧 Serviços disponíveis

- **PHP-FPM 8.3**
- **MySQL 8 e PHPMyAdmin**
- **PostgreSQL 17 e Adminer**
- **Redis**
- **MailHog**

---

## 🌐 Servidores Web disponíveis

Escolha entre:

- **Nginx (Alpine)** – leve e amplamente utilizado
- **Caddy** – com suporte automático a SSL local (self-signed)

---

## ✅ Requisitos

Certifique-se de ter os seguintes softwares instalados:

- `sudo`
- [Docker](https://docs.docker.com/engine/install/)
- [Docker Compose](https://docs.docker.com/compose/install/)

---

## 📦 Comandos a serem executados

Escolha o servidor web (**nginx** ou **caddy**) e o banco de dados (**mysql** ou **postgres**) para criação dos serviços:

```bash
./run.sh caddy mysql up
```

> Este comando criará os containers: **app_php**, **app_caddy**, **app_redis**, **app_mysql**, **app_mailhog**, **app_phpmyadmin**; além do volume **redis_cache** e a rede **app_network**.

Para remover os serviços, execute:

```bash
./run.sh caddy mysql down
# ou
./run.sh clear
```

> 💡 Os comandos Docker utilizam `sudo` por padrão. Ao executar comandos dentro dos containers, use:

```bash
sudo docker exec <nome_container> <comando>
```

---

## 📥 Instalando as dependências do projeto

Clone seu projeto Laravel na pasta `app`:

```bash
git clone <url> app
```

A pasta `app` será montada como:

- `/var/www` (servidor Nginx)
- `/srv` (servidor Caddy)

Execute os seguintes comandos:

```bash
sudo docker exec app_php composer install --no-dev --optimize-autoloader
cp ./app/.env.example ./app/.env
sudo docker exec app_php php artisan key:generate
sudo docker exec app_php php artisan migrate
```

Acesse o sistema via:

- **Nginx**: [http://app.localhost:8000](http://app.localhost:8000)
- **Caddy**: [https://app.localhost](https://app.localhost) _(ignore o aviso de certificado não seguro — é comum com certificados self-signed)_

---

## 🛠️ Problemas de permissão

Se ocorrerem erros de permissão ao acessar o sistema, execute:

```bash
sudo docker exec -it app_php sh
chmod 755 -R *
exit
```

> ⚠️ No WSL podem ocorrer erros de permissão em arquivos e redes. É recomendável executar em uma máquina Linux nativa.

---

## ✅ Executando os testes

```bash
sudo docker exec app_php composer install
cp ./app/.env.example ./app/.env
sudo docker exec app_php php artisan key:generate
sudo docker exec app_php php artisan migrate
sudo docker exec app_php php artisan test
```

---

## 🧪 Ferramentas auxiliares

- **DBAdmin**: [http://dbadmin.localhost:8000](http://dbadmin.localhost:8000) _(phpMyAdmin para MySQL ou Adminer para PostgreSQL)_

- **MailHog**: [http://mailhog.localhost:8000](http://mailhog.localhost:8000)

---

> Desenvolvido para facilitar o setup local de ambientes Laravel com Docker.  
> Personalize o .env.app conforme suas necessidades de projeto e não esqueça de refletir as mudanças no .env do seu projeto Laravel.
