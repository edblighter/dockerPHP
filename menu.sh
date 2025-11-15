#!/usr/bin/env bash
#set -x

# --- Configuration & State ---
# Variables to store configuration
WEBSERVER=""
DATABASE=""

# Variables to store check statuses
DEPS_STATUS="Not Checked"
PORTS_STATUS="Not Checked"
DEPS_MISSING=0
PORTS_IN_USE=0

# --- Core Functions ---

# Load environment variables from .env.app file
load_env() {
    if [ -f .env.app ]; then
        set -o allexport
        source .env.app
        set +o allexport
    else
        echo "Warning: .env.app file not found. Using default values."
    fi
}

# Check for required command-line tools
check_dependencies() {
    local dependencies=("docker" "openssl" "lsof")
    DEPS_MISSING=0
    DEPS_STATUS="OK"

    print_header
    echo "Checking dependencies..."
    for cmd in "${dependencies[@]}"; do
        if ! command -v "$cmd" &> /dev/null; then
            echo "  - $cmd: [MISSING] Please install it."
            ((DEPS_MISSING++))
            DEPS_STATUS="FAIL"
        else
            echo "  - $cmd: [OK]"
        fi
    done

    if [[ "$DEPS_STATUS" == "FAIL" ]]; then
        echo
        echo "Error: $DEPS_MISSING missing dependencies. Please install them to continue."
    fi
}

# Check for conflicting ports
ports_check() {
    # These variables should be defined in your .env.app file
    local required_ports=(
        "${HTTP_PORT:-80}"
        "${HTTPS_PORT:-443}"
        "${PHPMYADMIN_PORT:-8000}"
        "${MYSQL_PORT:-3306}"
        "${POSTGRES_PORT:-5432}"
        "${MONGODB_PORT:-27017}"
        "${DUCKDB_PORT:-5432}"
        "${CLICKHOUSE_HTTP_PORT:-8123}"
        "${CLICKHOUSE_NATIVE_PORT:-9000}"
        "${JENKINS_PORT:-8085}"
        "${JENKINS_SLAVE_PORT:-50000}"
        "${REDIS_PORT:-6379}"
        "${MAILPIT_PORT_SMTP:-1025}"
        "${MAILPIT_PORT_UI:-8025}"
        "${PORTAINER_PORT:-9000}"
    )
    PORTS_IN_USE=0
    PORTS_STATUS="OK"

    print_header
    echo "Checking required ports..."
    for port in "${required_ports[@]}"; do
        if sudo lsof -Pi:"$port" -sTCP:LISTEN -t &> /dev/null; then
            echo "  - Port $port: [IN USE]"
            ((PORTS_IN_USE++))
            PORTS_STATUS="FAIL"
        else
            echo "  - Port $port: [OK]"
        fi
    done

    if [[ "$PORTS_STATUS" == "FAIL" ]]; then
        echo
        echo "Warning: $PORTS_IN_USE port(s) are already in use. This may cause conflicts."
    fi
}

# --- UI Functions ---

# Function to print a standardized header
print_header() {
    clear
    echo "======================================="
    echo "  Dev Environment Configuration Tool   "
    echo "======================================="
    echo
}

# Function to pause execution until user presses Enter
pause() {
    echo
    read -rp "Press ENTER to continue..." _
}

# --- Menus ---

# Web Server Type Menu
webserver_menu() {
    while true; do
        print_header
        echo "Step 1: Choose Your Web Server"
        echo "1) Nginx"
        echo "2) Caddy"
        echo "3) Go Back"
        echo
        read -rp "Select an option [1-3]: " choice

        case "$choice" in
            1) WEBSERVER="nginx"; break ;;
            2) WEBSERVER="caddy"; break ;;
            3) break ;;
            *) echo "Invalid option"; pause ;;
        esac
    done
}

# Database Server Type Menu
database_menu() {
    while true; do
        print_header
        echo "Step 2: Choose Your Database"
        echo "1) MySQL"
        echo "2) MariaDB"
        echo "3) PostgreSQL"
        echo "4) MongoDB"
        echo "5) DuckDB"
        echo "6) ClickHouse"
        echo "7) Go Back"
        echo
        read -rp "Select an option [1-7]: " choice

        case "$choice" in
            1) DATABASE="mysql"; break ;;
            2) DATABASE="mariadb"; break ;;
            3) DATABASE="postgres"; break ;;
            4) DATABASE="mongodb"; break ;;
            5) DATABASE="duckdb"; break ;;
            6) DATABASE="clickhouse"; break ;;
            7) break ;;
            *) echo "Invalid option"; pause ;;
        esac
    done
}

# Summary and Execution Menu
summary_menu() {
    while true; do
        print_header
        local db_admin_tool="Not applicable"
        if [[ "$DATABASE" == "mysql" || "$DATABASE" == "mariadb" ]]; then
            db_admin_tool="PHPMyAdmin"
        elif [[ "$DATABASE" == "postgres" || "$DATABASE" == "mongodb" || "$DATABASE" == "duckdb" || "$DATABASE" == "clickhouse" ]]; then
            db_admin_tool="Adminer"
        fi

        echo "Configuration Summary"
        echo "-------------------------------------"
        echo "Web Server: ${WEBSERVER:-Not Selected}"
        echo "Database:   ${DATABASE:-Not Selected}"
        echo "Services:   Portainer, Traefik, Mailpit, Redis, and ${db_admin_tool}"
        echo "-------------------------------------"
        echo

        # Validation checks
        local can_run=true
        if [[ "$DEPS_STATUS" != "OK" ]]; then
            echo "Warning: Dependency check has not passed. [Status: $DEPS_STATUS]"
            can_run=false
        fi
        if [[ "$PORTS_STATUS" == "FAIL" ]]; then
            echo "Warning: There are port conflicts. [Status: $PORTS_STATUS]"
        fi
        if [[ -z "$WEBSERVER" || -z "$DATABASE" ]]; then
            echo "Warning: Web server or database not selected."
            can_run=false
        fi

        echo
        echo "1) Run Environment"
        echo "2) Restart Configuration"
        echo "3) Go Back"
        echo
        read -rp "Choose an option [1-3]: " choice

        case "$choice" in
            1)
                if [[ "$can_run" == "true" ]]; then
                    echo "Configuration complete. Running the Docker environment..."
                    bash "$PWD/run.sh" -w "$WEBSERVER" -d "$DATABASE" up
                    exit 0
                else
                    echo "Cannot run due to configuration errors or missing selections."
                    pause
                fi
                ;;
            2)
                WEBSERVER=""
                DATABASE=""
                # Keep check statuses
                main_menu
                ;;
            3) break ;;
            *) echo "Invalid option"; pause ;;
        esac
    done
}

# Main Menu
main_menu() {
    while true; do
        print_header
        echo "Main Menu"
        echo "1) Check Dependencies      [Status: ${DEPS_STATUS}]"
        echo "2) Check Required Ports    [Status: ${PORTS_STATUS}]"
        echo "3) Set Web Server          [Current: ${WEBSERVER:-Not Set}]"
        echo "4) Set Database            [Current: ${DATABASE:-Not Set}]"
        echo "5) View Summary & Run"
        echo "6) Exit"
        echo
        read -rp "Select an option [1-6]: " main_choice

        case "$main_choice" in
            1) check_dependencies; pause ;;
            2) ports_check; pause ;;
            3) webserver_menu ;;
            4) database_menu ;;
            5) summary_menu ;;
            6) exit 0 ;;
            *) echo "Invalid option"; pause ;;
        esac
    done
}

# --- Script Entrypoint ---
load_env
main_menu
