# PHP ENV
APP_CONTAINER_NAME=app_php
PHP_VERSION=5.6      # Supported Versions [8.4, 8.3, 8.2, 7.4, 5.6]
PHP_VARIANT=.alpine  # Supported Variants [.alpine, .distro, .debian] only for PHP 8.4, leave '' for other versions
# MISC
APP_TIMEZONE="America/Manaus"       # Define the a timezone to adjust de date/time of logs inside containers
# NETWORK RELATED
APP_NETWORK_NAME=app_network    # Default docker network name used between services