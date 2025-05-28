#!/usr/bin/env bash

#set -x 

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
    sudo docker rm \
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
    echo "Usage: $0 [clear | help] [caddy|nginx] [mysql|mariadb|postgres] [up|down]"
    echo "ex: $0 nginx mysql up  # this will set up the necessary services to run a nginx|php|mysql|phpmyadmin|redis|mailpit environment"
    exit 0
}

ports_check(){
    PORTS=(80 443 8000 3306 5432 6379 1025 8025 9000)
    IN_USE=0
    for port in "${PORTS[@]}"
    do
        sudo lsof -Pi:${port} -sTCP:LISTEN -t > /dev/null
        if [[ "$?" == 0 ]]; then
            echo "Port ${port} is already in use"
            IN_USE=1
        fi
    done
    if [[ "$IN_USE" == 1 ]]; then
        exit 1
    fi
}

check_dependencies() {
    for cmd in docker openssl; do
        command -v "$cmd" >/dev/null || {
            echo "Missing $cmd-please install it"
            exit 1
        }
    done
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

if [[ "$1" = "help" ]]; then
    usage
    exit 0
fi

if [[ "$1" = "clear" ]]; then
    clear_env    
    exit 0
else
    check_dependencies
    ports_check
    main $1 $2 $3
fi
