#!/bin/sh

#set -x 

clear_env() {
    echo "Clearing environment..."
    sudo rm -rf docker-data/caddy/config docker-data/caddy/data docker-data/mysql/mysqldata docker-data/postgres/data docker-data/postgres/db_root_password.txt docker-data/mysql/db_root_password.txt
    sudo docker stop app_php app_mysql app_postgres app_redis app_phpmyadmin app_dbadmin app_nginx app_caddy app_mailhog
    sudo docker rm app_php app_mysql app_postgres app_redis app_phpmyadmin app_dbadmin app_nginx app_caddy app_mailhog
    echo "##### ATTENTION the following commands will erase all stopped docker containers and associated volumes. Say NO if you don't know what to do. ###"
    sudo docker system prune --all
    sudo docker volume prune --all
    echo "Environment cleared."
}

if [ "$1" = "help" ]; then
    echo "Usage: $0 [clear | help] [caddy|nginx] [mysql|postgres] [up|down]"
    echo "ex: $0 nginx mysql up  # this will set up the necessary services to run a nginx|mysql|phpmyadmin|redis|mailhog enviroment"
    exit 0
fi

if [ "$1" = "clear" ]; then
    clear_env    
    exit 0
else
    export WEB_SERVER=$1
    export DATABASE=$2
    export MODE=$3

    if [ -z "$WEB_SERVER" ]; then
        echo 'You must specify the name of the web server to be utilized - caddy or nginx'
        exit 1
    elif [ "$WEB_SERVER" = "caddy" -o "$WEB_SERVER" = "nginx" ]; then
        if [ -z "$DATABASE" ]; then
            echo 'You must specify the name of the database server to be utilized - mysql or postgres'
            exit 1
        elif [ "$DATABASE" = "mysql" -o "$DATABASE" = "postgres" ]; then
            if [ -z "$MODE" ]; then
                echo 'You must specify mode for the services - up or down'
                exit 1
            elif [ "$MODE" = "up" -o "$MODE" = "down" ]; then
                if [ "$MODE" = "up" ]; then
                    openssl rand -base64 20 > docker-data/$DATABASE/db_root_password.txt
                    sudo PWD=${PWD} WEB_SERVER="$WEB_SERVER" DATABASE="$DATABASE" docker compose --env-file .env.app up -d --build
                    exit 0
                elif [ "$MODE" = "down" ]; then
                    sudo PWD=${PWD} WEB_SERVER="$WEB_SERVER" DATABASE="$DATABASE" docker compose --env-file .env.app down
                    clear_env
                    exit 0
                fi
            fi
        fi
    fi
fi
