#!/usr/bin/env bash
#
# Check php-fpm pool status

set -eo pipefail

usage() {
    cat <<EOF
Usage: healthcheck.sh [-h host] [-p port] [-u socket] [-w warning] [-c critical] [-s status page]

Options:
  -h, --host                  php-fpm status page host (ignored if using Unix socket)
  -p, --port                  php-fpm status page port (default: 9000)
  -u, --unix-socket           Path to Unix socket for php-fpm
  -w, --warning WARNING       Warning value (percent, default: 90)
  -c, --critical CRITICAL     Critical value (percent, default: 95)
  -s, --status-page           Name of the php-fpm status page (default: status)
  -H, --help                  Display this screen
EOF
    exit 3
}

# --- Default values ---
host="127.0.0.1"
port="9000"
unix_socket=""
status_page="status"
warning=90
critical=95

# --- Argument Parsing ---
while [[ -n "$1" ]]; do
  case $1 in
  --host | -h) host=$2; shift ;;
  --port | -p) port=$2; shift ;;
  --unix-socket | -u) unix_socket=$2; shift ;;
  --warning | -w) warning=$2; shift ;;
  --critical | -c) critical=$2; shift ;;
  --status-page | -s) status_page=$2; shift ;;
  --help | -H) usage ;;
  *)
    echo "Unknown argument: $1"
    usage
    ;;
  esac
  shift
done

# --- Validate Inputs ---
if [[ "$warning" -ge "$critical" ]]; then
  echo "UNKNOWN - warning ($warning) can't be greater than critical ($critical)"
  exit 3
fi

# --- Get FPM Status ---
fcgi_env="SCRIPT_NAME=/${status_page} SCRIPT_FILENAME=/${status_page} REQUEST_METHOD=GET"

if [[ -n "$unix_socket" ]]; then
  # via Unix socket
  status=$(eval "$fcgi_env" cgi-fcgi -bind -connect "${unix_socket}")
else
  # via IP
  status=$(eval "$fcgi_env" cgi-fcgi -bind -connect "${host}:${port}")
fi

if [[ -z "$status" ]]; then
  if [[ -n "$unix_socket" ]]; then
    echo "CRITICAL - could not fetch php-fpm pool status page via Unix socket ${unix_socket}/${status_page}"
  else
    echo "CRITICAL - could not fetch php-fpm pool status page ${host}:${port}/${status_page}"
  fi
  exit 2
fi

# --- Parse and Check Status ---
active_processes=$(echo "$status" | awk '/^active processes:/ { print $3 }')
total_processes=$(echo "$status" | grep 'total processes' | awk '{ print $3 }')

# Fallback for older PHP-FPM versions
if [[ -z "$total_processes" ]]; then
    total_processes=$(echo "$status" | awk '/^total processes:/ { print $3 }')
fi

if [[ -z "$active_processes" ]] || [[ -z "$total_processes" ]] || [[ "$total_processes" -eq 0 ]]; then
  echo "UNKNOWN - could not parse status page, or total_processes is zero."
  exit 3
fi

used_percent=$((active_processes * 100 / total_processes))
status_msg="${used_percent}% of process pool is used (${active_processes} active processes out of ${total_processes} total)"

if [[ "$used_percent" -ge "$critical" ]]; then
  echo "CRITICAL - ${status_msg}"
  exit 2
elif [[ "$used_percent" -ge "$warning" ]]; then
  echo "WARNING - ${status_msg}"
  exit 1
else
  echo "OK - ${status_msg}"
  exit 0
fi
