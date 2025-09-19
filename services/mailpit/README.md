# Mailpit Service

## Overview
This service provides [Mailpit](https://mailpit.axllent.org/), a powerful, lightweight email testing tool for developers to test email functionality without sending real emails.

## Features
- **Real-time Viewing:** Clean web interface to view emails as sent.
- **Zero Configuration:** Easy setup with no complex configuration.
- **API Support:** REST API for programmatic access and management.
- **SMTP Server:** Acts as SMTP server to capture emails.

## Prerequisites
- Docker and Docker Compose installed.
- Application configured to send emails via SMTP.

## Quick Start
1. Run: `docker-compose -f services/mailpit/docker-compose.yml up -d`
2. Access web UI at `http://127.0.0.1:8025`
3. Configure app SMTP to `127.0.0.1:1025`

## Configuration
Customize via `.env.mailpit`:

| Variable                | Description                                       | Default Value     |
| ----------------------- | ------------------------------------------------- | ----------------- |
| `APP_MAILPIT_CONTAINER` | The name of the Mailpit container.                | `app_mailpit`     |
| `MAILPIT_IMAGE`         | The Docker image for Mailpit.                     | `axllent/mailpit` |
| `MAILPIT_VERSION`       | The version of the Mailpit image.                 | `latest`          |
| `MAILPIT_MEM_LIMIT`     | Memory limit for Mailpit.                         | `128M`            |
| `APP_MAILPIT_SMTP_PORT` | The SMTP port for Mailpit.                        | `1025`            |
| `APP_MAILPIT_WEB_PORT`  | The web UI port for Mailpit.                      | `8025`            |
| `APP_TIMEZONE`          | The timezone for the container.                   | `America/Manaus`  |
| `APP_NETWORK_NAME`      | The name of the Docker network.                   | `app_network`     |

## Usage
- **Web UI:** View captured emails at configured port.
- **SMTP Config:** Host `127.0.0.1`, Port `1025` (or internal `mailpit:1025`).
- **API:** Access via REST endpoints for automation.
- **Features:** View, search, delete emails; view attachments.

## Troubleshooting
- **Emails Not Appearing:** Check SMTP configuration in your app.
- **Port Conflicts:** Ensure 1025 and 8025 are available.
- **Connection Issues:** Verify network settings and firewall.
- **Web UI Not Loading:** Check if container is running and port is correct.

## Links
- [Mailpit Documentation](https://mailpit.axllent.org/docs/)
- [API Reference](https://mailpit.axllent.org/docs/api/)