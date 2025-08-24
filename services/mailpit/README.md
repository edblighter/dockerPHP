# Mailpit Service

This service provides a powerful and lightweight email testing tool called [Mailpit](https://mailpit.axllent.org/). It's an ideal solution for developers who need to test email functionality in their applications without sending real emails.

## Key Features

- **Real-time Email Viewing:** View emails in a clean and intuitive web interface as they are sent by your application.
- **No Configuration Required:** Mailpit is a zero-configuration tool, making it easy to set up and use.
- **API Support:** Access and manage emails programmatically through a simple REST API.

## Standalone Usage

To run the Mailpit service as a standalone container, execute the following command from the project's root directory:

```bash
docker-compose -f services/mailpit/docker-compose.yml up -d
```

This will start the Mailpit container with the default configuration values.

### Customization

For advanced customization, you can use the `.env.mailpit` file. To apply your custom settings, run the following command:

```bash
docker-compose -f services/mailpit/docker-compose.yml --env-file services/mailpit/.env.mailpit up -d
```

The following variables can be customized in the `.env.mailpit` file:

| Variable                | Description                                       | Default Value     |
| ----------------------- | ------------------------------------------------- | ----------------- |
| `APP_MAILPIT_CONTAINER` | The name of the Mailpit container.                | `app_mailpit`     |
| `MAILPIT_IMAGE`         | The Docker image for Mailpit.                     | `axllent/mailpit` |
| `MAILPIT_VERSION`       | The version of the Mailpit image.                 | `latest`          |
| `APP_MAILPIT_SMTP_PORT` | The SMTP port for Mailpit.                        | `1025`            |
| `APP_MAILPIT_WEB_PORT`  | The web UI port for Mailpit.                      | `8025`            |
| `APP_TIMEZONE`          | The timezone for the container.                   | `America/Manaus`  |
| `APP_NETWORK_NAME`      | The name of the Docker network.                   | `app_network`     |

### Accessing Mailpit

Once the service is running, you can access the Mailpit web UI at `http://127.0.0.1:8025`.

To send emails to Mailpit, configure your application to use the following SMTP settings:

- **Host:** `127.0.0.1`
- **Port:** `1025`