# Laravel Docker Setup

Serviços docker para desenvolvimento em Laravel:

- **PHP-FPM (8.3)**
- **MySQL (8)**
- **PostgreSQL (17)**
- **Redis**
- **MailHog**

Voçê pode escolher entre 2 tipos de servidor web

- **Nginx (Alpine)**
- **Caddy** (Possui suporte automatico a SSL local)

---

## Software obrigatório

- sudo
- [docker](https://docs.docker.com/engine/install/)
- [docker compose](https://docs.docker.com/compose/install/)

## 📦 Comandos a serem executados

Escolha entre o nginx ou caddy para servir como servidor web e mysql ou postgres como banco de dados para criação dos serviços:

```bash
./run.sh caddy mysql up
```

> Para esse exemplo serão gerados os containers **app_php, app_caddy, app_redis, app_mysql, app_mailhog, app_phpmyadmin**, o volume **redis_cache** e a rede **app_network**

e para remover os serviços digite:

```bash
./run.sh caddy mysql down
ou
./run.sh clear
```

> O script foi escrito utilizando sudo como prefixo para rodar os comandos docker então caso precise executar comandos dentro do docker utilize **sudo docker exec <nome_container>**

---

Instalando as dependências do projeto:

- clone seu projeto na pasta app `git clone <url> app` e execute os comandos a seguir
  > a pasta app está linkada ao `/var/www` do servidor web **nginx** ou `/srv` do servidor web **caddy**

```bash
sudo docker exec app_php composer install --no-dev --optimize-autoloader
cp ./app/.env.example ./app/.env
sudo docker exec app_php php artisan key:generate
sudo docker exec app_php php artisan migrate
```

Assim que finalizado o migrate o sistema estará disponivel em [http://app.localhost:8000](http://app.localhost:8000).

> Para o servidor web caddy a url será reescrita para [https://app.localhost](https://app.localhost) e irá emitir que a conexão não é segura e basta ignorar pois é comum para certificados self-signed.

---

Caso apareça algum problema de permissão ao acessar o sistema rode os comandos:

```bash
sudo docker exec -it app_php sh
chmod 755 -R *
exit
```

> Foram encontrados erros de permissão usando o WSL tanto nos arquivos como na parte de network. É recomendado rodar em uma maquina linux.

---

Para rodar os testes seguem os comandos

```bash
sudo docker exec app_php composer install
cp ./app/.env.example ./app/.env
sudo docker exec app_php php artisan key:generate
sudo docker exec app_php php artisan migrate
sudo docker exec app_php php artisan test
```

---

Outros endereços que podem ser utilizados para auxiliar no desenvolvimento com o laravel.

- [DBAdmin](http://dbadmin.localhost:8000) - Aqui dependendo da escolha do banco pode ser o **phpmyadmin** para o MySQL ou **adminer** para o PostgreSQL
- [MailHog](http://mailhog.localhost:8000)
