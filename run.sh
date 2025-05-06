#!/bin/sh

if [ "$1" == "clear" ]; then
    echo "Clearing environment..."
    sudo rm -rf docker-data/caddy/config docker-data/caddy/data docker-data/mysql/mysqldata docker-data/postgres/data docker-data/postgres/db_root_password.txt docker-data/mysql/db_root_password.txt
    echo "Environment cleared."
    exit 0
else
    export PWD=${PWD}
    export WEB_SERVER=$1
    export DATABASE=$2
    export MODE=$3

    if [ -z "$WEB_SERVER" ]
    then
        echo 'You must specify the name of the web server to be utilized - caddy or nginx'
        exit 1
    elif [ "$WEB_SERVER" == 'caddy' || "$WEB_SERVER" == 'nginx' ]
    then
        if [ -z "$DATABASE" ]
        then
            echo 'You must specify the name of the database server to be utilized - mysql or postgres'
            exit 1
        elif [ "$DATABASE" == "mysql" || "$DATABASE" == "postgres" ]
            if [ -z "$MODE"]
            then
                echo 'You must specify mode for the services - up or down'
                exit 1
            elif [ "$MODE" == "up" || "$MODE" == "down" ]
                if [ "$MODE" == "up"]
                then
                    openssl rand -base64 20 > docker-data/$DATABASE/db_root_password.txt
                    sudo docker compose --env-file .env.app up -d --build
                    exit 0
                else
                    sudo docker compose --env-file .env.app down
                    ./run.sh clear
                    exit 0
                fi
            fi
        fi
    fi
fi
