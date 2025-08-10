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
    app_redis
    app_phpmyadmin
    app_dbadmin
    app_nginx
    app_caddy
    app_mailpit
    app_mariadb
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
  -d, --database <db>     Choose a database (mysql, mariadb, or postgres). Default: ${DATABASE}
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
    # Ensure the directory exists before writing to the file
    mkdir -p "docker-data/${DATABASE}"
    openssl rand -base64 20 | sudo tee "docker-data/${DATABASE}/db_root_password.txt" > /dev/null

    echo "Running docker-compose up and building services..."
    sudo PWD="${PWD}" WEB_SERVER="$WEBSERVER" DATABASE="$DATABASE" COMPOSE_BAKE=true docker compose --env-file .env.app up -d --build
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
        [[ "${DATABASE}" =~ ^(mysql|mariadb|postgres)$ ]] || { echo "Invalid database: ${DATABASE}"; usage; }
        run_up
        ;;
    down)
        [[ "${WEBSERVER}" =~ ^(caddy|nginx)$ ]] || { echo "Invalid web server: ${WEBSERVER}"; usage; }
        [[ "${DATABASE}" =~ ^(mysql|mariadb|postgres)$ ]] || { echo "Invalid database: ${DATABASE}"; usage; }
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