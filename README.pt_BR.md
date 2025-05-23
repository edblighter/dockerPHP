
# Configuração Docker para Desenvolvimento PHP

Ambiente Docker completo para desenvolvimento PHP (projeto originalmente voltado ao Laravel), incluindo suporte a múltiplos bancos de dados, servidores web e serviços auxiliares.

> Also avaiable in [EN](./README.md)

---

## 🔧 Serviços Disponíveis

- **PHP-FPM** - Versões [8.4, 8.3, 8.2, 7.4 e 5.6] disponíveis com módulos comuns embutidos e ferramentas como Bun e Composer.
- **MySQL/MariaDB e PHPMyAdmin** - A variante pode ser escolhida na inicialização e as versões podem ser alteradas via variável de ambiente.
- **PostgreSQL e Adminer** - Múltiplas versões do PostgreSQL disponíveis via variáveis de ambiente.
- **Redis**
- **MailHog**

---

## 🌐 Servidores Web Disponíveis

Escolha entre:

- **Nginx** – leve e amplamente utilizado
- **Caddy** – com suporte a SSL local automático (autoassinado)

---

## ✅ Requisitos

Certifique-se de que os seguintes softwares estão instalados:

- `sudo`
- [Docker](https://docs.docker.com/engine/install/)
- [Docker Compose](https://docs.docker.com/compose/install/)

## Antes de começar

A pasta `app` será montada como:

- `/var/www` (para Nginx)
- `/srv` (para Caddy)

Ela já contém a pasta `public` com um `index.html` e um `index.php` para testar o servidor web após a inicialização.

---

## 📦 Comandos para Executar

Escolha o servidor web (**nginx** ou **caddy**) e o banco de dados (**mysql**, **mariadb** ou **postgres**) para iniciar os serviços:

```bash
./run.sh caddy mysql up
```
> Este comando criará os containers: **app_php**, **app_caddy**, **app_redis**, **app_mysql**, **app_mailhog**, **app_phpmyadmin**; juntamente com o volume **redis_cache** e a rede **app_network**.

Ao final do processo de inicialização, você pode testar o servidor web em:

- **Nginx**: [http://info.localhost:8000](http://info.localhost:8000)
- **Caddy**: [https://info.localhost](https://info.localhost) _(ignore o aviso de segurança — é comum com certificados autoassinados)_

Para remover os serviços, execute:

```bash
./run.sh caddy mysql down
# ou
./run.sh clear  # isso removerá todos os containers com valor padrão e perguntará se deseja limpar o cache.
```

> 💡 Os comandos Docker usam `sudo` por padrão. Para executar comandos dentro dos containers, use:

```bash
sudo docker exec <nome_do_container> <comando>
```

---

## 🧪 Ferramentas Auxiliares

- **DBAdmin**: [http://dbadmin.localhost:8000](http://dbadmin.localhost:8000) _(phpMyAdmin para MySQL/MariaDB ou Adminer para PostgreSQL)_

- **MailHog**: [http://mailhog.localhost:8000](http://mailhog.localhost:8000)

---
