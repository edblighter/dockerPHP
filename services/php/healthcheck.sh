#!/usr/bin/env bash
#
# Check php-fpm pool status
#
# Usage: check_php_fpm_lepidus.sh [-h host] [-p port] [-u socket] [-w warning] [-c critical] [-s status page] [-S secure]
#   -h, --host                  php-fpm status page host (ignored if using Unix socket)
#   -p, --port                  php-fpm status page port (default: 9000)
#   -u, --unix-socket           Path to Unix socket for php-fpm
#   -w, --warning WARNING       Warning value (percent)
#   -c, --critical CRITICAL     Critical value (percent)
#   -s, --status-page           Name of the php-fpm status page (default: status)
#   -S, --secure                Use HTTPS instead of HTTP (not applicable with cgi-fcgi)
#   -H, --help                  Display this screen
#

while [[ -n "$1" ]]; do
  case $1 in
  --host | -h)
    host=$2
    shift
    ;;
  --port | -p)
    port=$2
    shift
    ;;
  --unix-socket | -u)
    unix_socket=$2
    shift
    ;;
  --warning | -w)
    warning=$2
    shift
    ;;
  --critical | -c)
    critical=$2
    shift
    ;;
  --status-page | -s)
    status_page=$2
    shift
    ;;
  --secure | -S)
    secure=$2
    shift
    ;;
  --help | -H)
    sed -n '2,13p' "$0" | tr -d '#'
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

host=${host:=127.0.0.1}
port=${port:=9000}  # Define a porta padrão como 9000
unix_socket=${unix_socket:-""}
status_page=${status_page:='status'}
warning=${warning:=90}
critical=${critical:=95}

if [[ $warning -ge $critical ]]; then
  echo "UNKNOWN - warning ($warning) can't be greater than critical ($critical)"
  exit 3
fi

# Verifica se deve usar conexão via socket Unix ou IP
if [[ -n $unix_socket ]]; then
  # Conexão via Unix socket
  status=$(SCRIPT_NAME="/status" \
           SCRIPT_FILENAME="/status" \
           REQUEST_METHOD="GET" \
           cgi-fcgi -bind -connect "${unix_socket}")
else
  # Conexão via IP
  status=$(SCRIPT_NAME="/status" \
           SCRIPT_FILENAME="/status" \
           REQUEST_METHOD="GET" \
           cgi-fcgi -bind -connect "${host}:${port}")
fi

if [[ $? -ne 0 ]] || [[ -z $status ]]; then
  if [[ -n $unix_socket ]]; then
    echo "CRITICAL - could not fetch php-fpm pool status page via Unix socket ${unix_socket}/status"
  else
    echo "CRITICAL - could not fetch php-fpm pool status page ${host}:${port}/status"
  fi
  exit 2
fi

active_processes=$(echo "$status" | grep -w 'active processes:' | head -n 1 | awk '{ print $3 }')
total_processes=$(echo "$status" | grep 'total processes' | awk '{ print $3 }')

if [[ -z $active_processes ]] || [[ -z $total_processes ]]; then
  echo "UNKNOWN - 'active_processes' or 'total_processes' are empty"
  exit 3
fi

used=$((active_processes * 100 / total_processes))
status="${used}% of process pool is used (${active_processes} active processes on ${total_processes})"

if [[ $used -gt $critical ]]; then
  echo "CRITICAL - ${status}"
  exit 2
elif [[ $used -gt $warning ]]; then
  echo "WARNING - ${status}"
  exit 1
else
  echo "OK - ${status}"
  exit 0
fi