# Configuração Docker para Desenvolvimento PHP

Um ambiente Docker completo para desenvolvimento PHP local, oferecendo uma seleção de servidores web, bancos de dados e ferramentas de desenvolvimento essenciais.

> Também disponível em [EN](./README.md)

---

## Funcionalidades

- **Múltiplas Versões do PHP:** Alterne entre PHP 5.6, 7.4, 8.2, 8.3 e 8.4.
- **Servidores Web Flexíveis:** Escolha entre Nginx (padrão) ou Caddy com HTTPS automático.
- **Variedade de Bancos de Dados:** Suporta MySQL (padrão), MariaDB, PostgreSQL, MongoDB, DuckDB e ClickHouse.
- **Ferramentas Essenciais:** Inclui Redis para cache e Mailpit para teste de e-mails.
- **Gerenciamento Fácil:** Use `run.sh` para operações de linha de comando ou `menu.sh` para uma experiência interativa.
- **Serviços Auxiliares:** Inclui serviços opcionais como Portainer, Traefik e Jenkins para gerenciamento avançado e CI/CD.

---

## ✅ Requisitos

- [Docker](https://docs.docker.com/engine/install/)
- [Docker Compose](https://docs.docker.com/compose/install/)
- Permissões de `sudo`

---

## 🚀 Início Rápido

1.  **Clone o repositório e navegue para o diretório do projeto.**

2.  **Coloque os arquivos do seu projeto PHP no diretório `app/`.**
    O diretório `app/` é montado como a raiz do servidor web:
    - Nginx: `/var/www`
    - Caddy: `/srv`

3.  **Execute o menu de configuração interativo:**
    ```bash
    ./menu.sh
    ```
    Alternativamente, use o script `run.sh` para uma configuração não interativa. Por exemplo, para iniciar com Nginx e MySQL:
    ```bash
    ./run.sh -w nginx -d mysql up
    ```

4.  **Acesse sua aplicação:**
    - **Nginx:** [http://info.localhost:8000](http://info.localhost:8000)
    - **Caddy:** [https://info.localhost](https://info.localhost) (ignore o aviso de certificado autoassinado)

---

## 📦 Uso

Este ambiente é gerenciado por dois scripts principais: `run.sh` e `menu.sh`.

### Menu Interativo (`menu.sh`)

Para uma configuração guiada, simplesmente execute:
```bash
./menu.sh
```
Este script irá guiá-lo na seleção de um servidor web, banco de dados e outras opções.

### Script de Linha de Comando (`run.sh`)

O script `run.sh` fornece uma maneira direta de gerenciar o ambiente.

**Sintaxe:**
```bash
./run.sh [opções] [comando]
```

**Opções:**
| Opção | Descrição | Padrão |
|---|---|---|
| `-w`, `--web <servidor>` | Escolha um servidor web (`nginx` ou `caddy`). | `nginx` |
| `-d`, `--database <db>` | Escolha um banco de dados (`mysql`, `mariadb`, `postgres`, `mongodb`, `duckdb` ou `clickhouse`). | `mysql` |
| `-H`, `--help` | Exibe a tela de ajuda. | |

**Comandos:**
| Comando | Descrição |
|---|---|
| `up` | Inicia e constrói os serviços. |
| `down` | Para os serviços. |
| `clear` | Para e remove todos os contêineres, volumes e dados. **Aviso: Esta ação é destrutiva.** |

**Exemplos:**
```bash
# Iniciar com Nginx e MySQL
./run.sh -w nginx -d mysql up

# Iniciar com Nginx e MongoDB
./run.sh -w nginx -d mongodb up

# Iniciar com Caddy e ClickHouse
./run.sh -w caddy -d clickhouse up

# Parar o ambiente
./run.sh down

# Limpar todo o ambiente
./run.sh clear
```

---

## 🔧 Serviços

Esta configuração inclui uma variedade de serviços que podem ser combinados para atender às suas necessidades.

### Serviços Principais
| Serviço | Descrição |
|---|---|
| **PHP-FPM** | Interpretador PHP com versões de 5.6 a 8.4. |
| **Servidor Web** | Nginx ou Caddy. |
| **Banco de Dados** | MySQL, MariaDB, PostgreSQL, MongoDB, DuckDB ou ClickHouse. |
| **Redis** | Armazenamento de dados em memória para cache. |
| **Mailpit** | Ferramenta de teste de e-mail. |

### Ferramentas Auxiliares
Estes serviços são opcionais e podem ser iniciados independentemente.

| Serviço | Descrição | Acesso |
|---|---|---|
| **DBAdmin** | phpMyAdmin para MySQL/MariaDB ou Adminer para PostgreSQL, MongoDB, DuckDB e ClickHouse. | [http://dbadmin.localhost:8000](http://dbadmin.localhost:8000) |
| **Portainer** | UI de gerenciamento do Docker. | [http://manager.localhost:9000](http://manager.localhost:9000) |
| **Traefik** | Proxy reverso e balanceador de carga. | [http://localhost:8080](http://localhost:8080) (Dashboard) |
| **Jenkins** | Servidor de automação de CI/CD. | [http://localhost:8085](http://localhost:8085) |

---

## 📚 Documentação dos Serviços

Para informações detalhadas sobre cada serviço, incluindo configuração e uso avançado, consulte os respectivos arquivos `README.md`:

- [PHP](./services/php/README.md)
- [Nginx](./services/nginx/README.md)
- [Caddy](./services/caddy/README.md)
- [MySQL](./services/mysql/README.md)
- [MariaDB](./services/mariadb/README.md)
- [PostgreSQL](./services/postgres/README.md)
- [MongoDB](./services/mongodb/README.md)
- [DuckDB](./services/duckdb/README.md)
- [ClickHouse](./services/clickhouse/README.md)
- [Redis](./services/redis/README.md)
- [Mailpit](./services/mailpit/README.md)
- [PHPMyAdmin](./services/phpmyadmin/README.md)
- [Adminer](./services/adminer/README.md)
- [Portainer](./services/portainer/README.md)
- [Traefik](./services/traefik/README.md)
- [Jenkins](./services/jenkins/README.md)

---

## ⚙️ Configuração

- **Variáveis de Ambiente:** Personalize versões, portas e outras configurações em `.env.app`.
- **Ambientes Específicos de Serviços:** Serviços individuais podem ter seus próprios arquivos `.env` (ex: `.env.mongodb`, `.env.duckdb`, `.env.clickhouse`, `.env.jenkins`) para configurações específicas.
- **Configuração do PHP:** Ajuste as configurações do PHP em `services/php/conf/php.ini` e `www.conf`.
- **Configuração dos Serviços:** Modifique os arquivos `docker-compose.yml` e os arquivos `.env` dentro do diretório de cada serviço para alterações mais avançadas.

---

## 💡 Solução de Problemas

- **Conflitos de Porta:** Se um serviço não iniciar, verifique se as portas necessárias já estão em uso. Você pode alterar as portas nos arquivos `.env` correspondentes.
- **Erros de Permissão:** Certifique-se de que o usuário que executa os comandos do Docker tenha as permissões necessárias para acessar o daemon do Docker e os arquivos do projeto.
- **Logs:** Para inspecionar os logs de um contêiner específico, use `docker logs <nome_do_container>`.
- **Resetando o Ambiente:** Se encontrar problemas persistentes, você pode resetar todo o ambiente com `./run.sh clear`. **Aviso: Isso excluirá todos os dados.**
