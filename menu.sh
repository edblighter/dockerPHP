#!/usr/bin/env bash
#set -x 

check_dependencies() {
    DEPS=0
    for cmd in docker openssl;  do  # TODO: Create a list for the deps.
        echo "Checking ${cmd}"
        command -v "$cmd" >/dev/null || {
            echo "... Missing $cmd please install it"
            let DEPS++
            exit 1
        } 
        echo "... OK"
    done
}

load_env() {
    set -o allexport
    source .env.app
    set +o allexport
}

ports_check() {
    PORTS=(80 443 8000 3306 5432 6379 1025 8025 9000) # TODO: Pick the list in the env vars
    IN_USE=0
    for port in "${PORTS[@]}"
    do
        echo "Checking port ${port}:"
        sudo lsof -Pi:${port} -sTCP:LISTEN -t > /dev/null
        if [[ "$?" == 0 ]]; then
            echo "Port ${port} is already in use"
            let IN_USE++
        else
            echo "... Free to use"
        fi
    done
    if [[ "$IN_USE" == 1 ]]; then
        exit 1
    fi
}

# Variables to store configuration
WEBSERVER=""
DATABASE=""
services=()

# Function to print header
print_header() {
    clear
    echo "======================================="
    echo "  Dev Environment Configuration Tool   "
    echo "======================================="
    echo
}

# Function to pause
pause() {
    echo
    read -rp "Press ENTER to continue..." _
}

# Web Server Type Menu
webserver_menu() {
    print_header
    echo "Step 1: Choose Server Type"
    echo "1) Nginx"
    echo "2) Caddy"
    echo "3) Traefik"
    echo "4) Go Back"
    echo
    read -rp "Select an option [1-4]: " choice

    case "$choice" in
        1) WEBSERVER="nginx" ;;
        2) WEBSERVER="caddy" ;;
        3) WEBSERVER="traefik" ;;
        4) return ;;
        *) echo "Invalid option"; pause; webserver_menu ;;
    esac
}
# Database Server Type Menu
database_menu() {
    print_header
    echo "Step 1: Choose Server Type"
    echo "1) MySQL"
    echo "2) MariaDB"
    echo "3) PostgreSQL"
    echo "4) Go Back"
    echo
    read -rp "Select an option [1-4]: " choice

    case "$choice" in
        1) DATABASE="mysql" ;;
        2) DATABASE="mariadb" ;;
        3) DATABASE="postgres" ;;
        4) return ;;
        *) echo "Invalid option"; pause; database_menu ;;
    esac
}
# Summary Menu
summary_menu() {
    print_header
    if [[ "$DATABASE" = "mysql" || "$DATABASE" = "mariadb" ]]; then
        DBADMIN="PHPMyAdmin"
    elif [[ "$DATABASE" = "postgres" ]];then
        DBADMIN="Adminer"
    else
        DBADMIN="Database type not selected yet!"
    fi
    echo " Configuration Summary "
    echo "-----------------------------"
    echo "Web Server : ${WEBSERVER:-Not selected}"
    echo "Database   : ${DATABASE:-Not selected}"
    echo "Services   : Aditional services[Mailpit, Redis, ${DBADMIN}]"
    echo "-----------------------------"
    echo
    echo "1) Restart Configuration"
    echo "2) Run"
    echo
    read -rp "Choose an option [1-2]: " choice

    case "$choice" in
        1) WEBSERVER=""; DATABASE=""; main_menu ;;
        2) echo "Configuration complete. Running the Docker composer"; bash $PWD/run.sh ${WEBSERVER} ${DATABASE} up; exit 0 ;;
        *) echo "Invalid option"; pause; summary_menu ;;
    esac
}
# Main Menu
main_menu() {
    while true; do
        print_header
        echo "Main Menu "
        echo "1) Check Dependencies      [${DEPS:-Not Checked} dependencies]"
        echo "2) Check (un)used Ports    [${IN_USE:-Not Checked} used ports]"
        echo "3) Set your Web Server     [${WEBSERVER:-Not set}]"
        echo "4) Select the Database     [${DATABASE:-Not set}]"
        echo "5) Show Summary"
        
        echo
        read -rp "Select an option [1-4]: " main_choice

        case "$main_choice" in
            1) check_dependencies ;pause;;
            2) ports_check ; pause;;
            3) webserver_menu ;;
            4) database_menu ;;
            5) summary_menu ;;
            *) echo "Invalid option"; pause ;;
        esac
    done
}

check_dependencies
ports_check
main_menu
