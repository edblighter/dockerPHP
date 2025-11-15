#!/usr/bin/env bash
#set -x
# Docker Containers for web development
#
# Optimized version of the script.

# --- Configuration ---
# Default values for options
WEBSERVER="nginx"
DATABASE="mysql"
MODE=""

# List of containers to manage.
# Assuming 'app_' prefix is correct for services based on original script.
APP_CONTAINERS=(
    app_manager
    app_traefik
    app_php
    app_mysql
    app_postgres
    app_mariadb
    app_mongodb
    app_duckdb
    app_clickhouse
    tools_jenkins
    app_redis
    app_phpmyadmin
    app_dbadmin
    app_nginx
    app_caddy
    app_mailpit
)
APP_VOLUMES=(redis_cache app_volume)
APP_NETWORK="app_network"

# --- Functions ---

# Function to display help message
usage() {
    cat <<EOF
Usage: $0 [options] [command]

Docker Containers for web development.

Options:
  -w, --web <server>      Choose a webserver (nginx or caddy). Default: ${WEBSERVER}
  -d, --database <db>     Choose a database (mysql, mariadb, postgres, mongodb, duckdb, or clickhouse). Default: ${DATABASE}
  -H, --help              Display this screen.

Commands:
  up                      Start and build the services.
  down                    Stop the services.
  clear                   Stop and remove all containers, volumes, and data.

Examples:
  $0 -w nginx -d mysql up
  $0 down
  $0 clear
EOF
    exit 1
}

# Function to completely clear the environment
clear_env() {
    echo "Clearing environment..."

    echo "Stopping and removing containers..."
    sudo docker rm -f "${APP_CONTAINERS[@]}" 2>/dev/null || true

    echo "Removing volumes..."
    sudo docker volume rm "${APP_VOLUMES[@]}" 2>/dev/null || true

    echo "Removing network..."
    sudo docker network rm "${APP_NETWORK}" 2>/dev/null || true

    echo "Removing data directories..."
    sudo rm -rf docker-data

    echo "##### ATTENTION: The following commands will erase all stopped Docker containers, networks, and images not associated with a container. Proceed with caution. ###"
    sudo docker system prune --all --force

    echo "##### ATTENTION: The following command will erase all unused local volumes. Proceed with caution. ###"
    sudo docker volume prune --all --force

    echo "Environment cleared."
    exit 0
}

# Function to print a summary of environment variables in a colorful table
print_summary() {
    # Colors
    GREEN='\033[0;32m'
    YELLOW='\033[1;33m'
    NC='\033[0m' # No Color

    echo -e "\n${GREEN}==============================================================${NC}"
    echo -e "                ${GREEN}Environment Variables Summary${NC}"
    echo -e "${GREEN}==============================================================${NC}"
    printf "| %-25s | %-35s |\n" "Variable" "Value"
    echo -e "|---------------------------|-------------------------------------|"

    print_var() {
        if [ -n "$2" ]; then
            # Remove comments and trim whitespace
            value=$(echo "$2" | sed 's/#.*//' | sed 's/ *$//')
            printf "| ${YELLOW}%-25s${NC} | %-35s |\n" "$1" "$value"
        fi
    }

    print_var "WEBSERVER" "$WEBSERVER"
    print_var "DATABASE" "$DATABASE"

    # General
    while IFS='=' read -r key value; do
        case "$key" in
            APP_HOST|APP_HTTP_PORT|APP_HTTPS_PORT|APP_NETWORK_NAME|APP_TIMEZONE|PHP_VERSION|PHP_VARIANT)
                print_var "$key" "$value"
                ;;
        esac
    done < <(grep -v '^#' .env.app | grep '=')

    # Database
    if [ "$DATABASE" = "mysql" ]; then
        while IFS='=' read -r key value; do
            case "$key" in
                MYSQL_IMAGE|MYSQL_VERSION|APP_MYSQL_USER|APP_MYSQL_PASSWORD|MYSQLDATA_PATH|PHPMYADMIN_IMAGE|PHPMYADMIN_VERSION|PHPMYADMIN_URL|PHPMYADMIN_ARBITRARY)
                    print_var "$key" "$value"
                    ;;
            esac
        done < <(grep -v '^#' .env.app | grep '=')
    elif [ "$DATABASE" = "mariadb" ]; then
        while IFS='=' read -r key value; do
            case "$key" in
                MARIADB_IMAGE|MARIADB_VERSION|APP_MYSQL_USER|APP_MYSQL_PASSWORD|MARIADBDATA_PATH|PHPMYADMIN_IMAGE|PHPMYADMIN_VERSION|PHPMYADMIN_URL|PHPMYADMIN_ARBITRARY)
                    print_var "$key" "$value"
                    ;;
            esac
        done < <(grep -v '^#' .env.app | grep '=')
    elif [ "$DATABASE" = "postgres" ]; then
        while IFS='=' read -r key value; do
            case "$key" in
                POSTGRES_IMAGE|POSTGRES_VERSION|APP_POSTGRES_USER|APP_POSTGRES_PASSWORD|POSTGRESDATA_PATH|ADMINER_IMAGE|ADMINER_VERSION|ADMINER_DEFAULT_DRIVER)
                    print_var "$key" "$value"
                    ;;
            esac
        done < <(grep -v '^#' .env.app | grep '=')
    fi

    # Web server
    if [ "$WEBSERVER" = "nginx" ]; then
        while IFS='=' read -r key value; do
            case "$key" in
                NGINX_IMAGE|NGINX_VERSION)
                    print_var "$key" "$value"
                    ;;
            esac
        done < <(grep -v '^#' .env.app | grep '=')
    elif [ "$WEBSERVER" = "caddy" ]; then
        while IFS='=' read -r key value; do
            case "$key" in
                CADDY_IMAGE|CADDY_VERSION|CADDY_MEM_LIMIT)
                    print_var "$key" "$value"
                    ;;
            esac
        done < <(grep -v '^#' .env.app | grep '=')
    fi

    # Other services
    while IFS='=' read -r key value; do
        case "$key" in
            JENKINS_IMAGE|JENKINS_VERSION|JENKINS_DATA_PATH|REDIS_IMAGE|REDIS_VERSION|REDIS_MEM_LIMIT|MAILPIT_IMAGE|MAILPIT_VERSION|PORTAINER_IMAGE|PORTAINER_VERSION|TRAEFIK_IMAGE|TRAEFIK_VERSION)
                print_var "$key" "$value"
                ;;
        esac
    done < <(grep -v '^#' .env.app | grep '=')

    echo -e "${GREEN}==============================================================${NC}"
}

# Function to start the services
run_up() {
    echo "Creating minimal data folders..."
    mkdir -p "docker-data/php" "docker-data/${DATABASE}" "docker-data/${WEBSERVER}"

    if [[ "${DATABASE}" = "postgres" ]]; then
        echo "Adjusting permissions for the postgres log folder..."
        mkdir -p "docker-data/${DATABASE}/logs"
        sudo chown :70 "docker-data/${DATABASE}/logs"
        sudo chmod 770 "docker-data/${DATABASE}/logs"
        sudo chmod g+s "docker-data/${DATABASE}/logs"
    fi

    echo "Generating the database root password file..."
    mkdir -p "docker-data/${DATABASE}"
    openssl rand -base64 20 | sudo tee "docker-data/${DATABASE}/db_root_password.txt" > /dev/null

    if [[ "${WEBSERVER}" = "nginx" ]]; then
        SSL_DIR="docker-data/nginx/ssl"
        SSL_KEY="${SSL_DIR}/nginx-selfsigned.key"
        SSL_CERT="${SSL_DIR}/nginx-selfsigned.crt"

        if [ ! -f "${SSL_KEY}" ] || [ ! -f "${SSL_CERT}" ]; then
            echo "Generating self-signed SSL certificate in ${SSL_DIR}..."
            mkdir -p "${SSL_DIR}" && \
            openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
            -keyout "${SSL_KEY}" \
            -out "${SSL_CERT}" \
            -subj "/C=BR/ST=YourState/L=YourCity/O=YourOrganization/CN=info.localhost"
        else
            echo "Nginx SSL certificate already exists in ${SSL_DIR}. Skipping generation."
        fi
    fi

    echo "Running docker-compose up and building services..."
    sudo PWD="${PWD}" WEB_SERVER="$WEBSERVER" DATABASE="$DATABASE" COMPOSE_BAKE=true docker compose --env-file .env.app up -d --build

    print_summary
}

# Function to stop the services
run_down() {
    echo "Running docker-compose down..."
    sudo PWD="${PWD}" WEB_SERVER="$WEBSERVER" DATABASE="$DATABASE" docker compose --env-file .env.app down
}

# --- Main script execution ---

# Parse command-line arguments
if [ "$#" -eq 0 ]; then
    usage
fi

while [[ $# -gt 0 ]]; do
    case $1 in
        -w|--web)
            WEBSERVER="$2"
            shift 2
            ;;
        -d|--database)
            DATABASE="$2"
            shift 2
            ;;
        -H|--help)
            usage
            ;;
        up|down|clear)
            if [[ -n "$MODE" ]]; then
                echo "Error: Only one command (up, down, clear) can be specified."
                usage
            fi
            MODE="$1"
            shift 1
            ;;
        *)
            echo "Unknown argument: $1"
            usage
            ;;
    esac
done

# Validate arguments and execute command
case "${MODE}" in
    up)
        [[ "${WEBSERVER}" =~ ^(caddy|nginx)$ ]] || { echo "Invalid web server: ${WEBSERVER}"; usage; }
        [[ "${DATABASE}" =~ ^(mysql|mariadb|postgres|mongodb|duckdb|clickhouse)$ ]] || { echo "Invalid database: ${DATABASE}"; usage; }
        run_up
        ;;
    down)
        [[ "${WEBSERVER}" =~ ^(caddy|nginx)$ ]] || { echo "Invalid web server: ${WEBSERVER}"; usage; }
        [[ "${DATABASE}" =~ ^(mysql|mariadb|postgres|mongodb|duckdb|clickhouse)$ ]] || { echo "Invalid database: ${DATABASE}"; usage; }
        run_down
        ;;
    clear)
        clear_env
        ;;
    *)
        echo "Error: No command specified (up, down, or clear)."
        usage
        ;;
esac

exit 0
