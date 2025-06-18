#!/usr/bin/env bash
#set -x 
# Docker Containers for web development
#
# Usage: run.sh [-w webserver] [-d database] up|down
#   clear                    This will clean all default containers and ask to prune all docker containers.
#   -w, --web                Choose a webserver (nginx,caddy or traefik)
#   -d, --database           Choose a database (mysql,mariadb or postgres)
#   -H, --help               Display this screen
#

clear_env() {
    echo "Clearing environment..."
    sudo rm -rf \
        docker-data/caddy/config \
        docker-data/caddy/data \
        docker-data/mysql/mysqldata \
        docker-data/postgres/data \
        docker-data/postgres/logs \
        docker-data/nginx/logs \
        docker-data/postgres/db_root_password.txt \
        docker-data/mysql/db_root_password.txt \
        docker-data/mariadb/db_root_password.txt

    sudo docker stop \
        tools_manager \
        tools_traefik \
        app_php \
        app_mysql \
        app_postgres \
        tools_redis \
        app_phpmyadmin \
        app_dbadmin \
        app_nginx \
        app_caddy \
        tools_mailpit \
        app_mariadb
    sudo docker rm \
        app_manager \
        app_traefik \
        app_php \
        app_mysql \
        app_postgres \
        app_redis \
        app_phpmyadmin \
        app_dbadmin \
        app_nginx \
        app_caddy \
        app_mailpit \
        app_mariadb
    sudo docker volume rm \
        redis_cache \
        app_volume
    sudo docker network rm \
        app_network

    echo "##### ATTENTION the following commands will erase all stopped docker containers and associated volumes. Say NO if you don't know what to do. ###"
    sudo docker system prune --all
    sudo docker volume prune --all
    sudo docker network prune
    echo "Environment cleared."
    exit 0
}

usage() {
    echo "Usage: $0 [clear] [-H | --help] [-w caddy|nginx] [-d mysql|mariadb|postgres] [up|down]"
    echo "ex: $0 -w nginx -d mysql up  # this will set up the necessary services to run a nginx|php|mysql|phpmyadmin|redis|mailpit environment"
    exit 0
}

main() {
    export WEB_SERVER=$1
    export DATABASE=$2
    export MODE=$3

    if [[ -z "$WEB_SERVER" ]]; then
        echo 'You must specify the name of the web server to be utilized - caddy or nginx'
        usage
        exit 1
    elif [[ "$WEB_SERVER" = "caddy" || "$WEB_SERVER" = "nginx" ]]; then
        if [[ -z "$DATABASE" ]]; then
            echo 'You must specify the name of the database server to be utilized - mysql or mariadb or postgres'
            usage
            exit 1
        elif [[ "$DATABASE" = "mysql" || "$DATABASE" = "mariadb" || "$DATABASE" = "postgres" ]]; then
            if [[ -z "$MODE" ]]; then
                echo 'You must specify the mode for the services - up or down'
                usage
                exit 1
            elif [[ "$MODE" = "up" || "$MODE" = "down" ]]; then
                if [[ "$MODE" = "up" ]]; then
                    echo "Creating minimal data folders"
                    mkdir -p docker-data/php docker-data/$DATABASE docker-data/$WEB_SERVER
                    if [[ "$DATABASE" = "postgres" ]]; then
                        echo "Adjusting permissions for the postgres log folder"
                        mkdir -p docker-data/$DATABASE/logs
                        sudo chown :70 docker-data/$DATABASE/logs
                        sudo chmod 770 docker-data/$DATABASE/logs
                        sudo chmod g+s docker-data/$DATABASE/logs
                    fi
                    echo 'Generating the database root password file'
                    openssl rand -base64 20 > docker-data/$DATABASE/db_root_password.txt
                    echo 'Running the docker compose up and building services'
                    sudo PWD=${PWD} COMPOSE_BAKE=true WEB_SERVER="$WEB_SERVER" DATABASE="$DATABASE" docker compose --env-file .env.app up -d --build
                    exit 0
                elif [[ "$MODE" = "down" ]]; then
                    echo 'Running the docker compose down and removing services'
                    sudo PWD=${PWD} WEB_SERVER="$WEB_SERVER" DATABASE="$DATABASE" docker compose --env-file .env.app down
                    #clear_env
                    exit 0
                fi
            fi
        fi
    fi
}

if [ "$#" -lt 1 ]; then
    echo "Error: This script requires at least 1 argument."
    usage
    exit 1
fi

while [[ -n "$1" ]]; do
  case $1 in
  --web | -w)
    WEBSERVER=$2
    shift
    ;;
  --database | -d)
    DATABASE=$2
    shift
    ;;
   up | down)
    MODE=$1
    main ${WEBSERVER:="nginx"} ${DATABASE:="mysql"} ${MODE}
    ;;
   clear)
    clear_env;
    exit 0;
    ;;
  --help | -H)
    sed -n '3,9p' "$0" | tr -d '#'
    exit 3
    ;;
  *)
    echo "Unknown argument: $1"
    exec "$0" --help
    exit 3
    ;;
  esac
  shift
done