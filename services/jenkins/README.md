# Jenkins Service

This service provides a powerful and extensible automation server called [Jenkins](https://www.jenkins.io/). It's a leading open-source tool for building, testing, and deploying software, enabling continuous integration and continuous delivery (CI/CD) pipelines.

## Key Features

- **CI/CD Automation:** Automate your software development lifecycle, from building and testing to deployment and delivery.
- **Extensive Plugin Ecosystem:** With thousands of available plugins, Jenkins can be integrated with a wide range of tools and technologies.
- **Distributed Builds:** Distribute build and test workloads across multiple machines for faster and more efficient pipelines.

## Standalone Usage

To run the Jenkins service as a standalone container, execute the following command from the project's root directory:

```bash
docker-compose -f services/jenkins/docker-compose.yml up -d
```

This will start the Jenkins container with the default configuration values.

### Customization

For advanced customization, it is recommended to use environment variables. You can create a `.env.jenkins` file with the following content:

```
JENKINS_IMAGE=jenkins/jenkins
JENKINS_VERSION=lts
JENKINS_CONTAINER_NAME=jenkins
JENKINS_HTTP_PORT=8085
JENKINS_AGENT_PORT=50000
JENKINS_DATA_DIR=./jenkins_data
```

Then, update the `docker-compose.yml` to use these variables:

```yaml
services:
  jenkins:
    image: ${JENKINS_IMAGE:-jenkins/jenkins}:${JENKINS_VERSION:-lts}
    container_name: ${JENKINS_CONTAINER_NAME:-jenkins}
    restart: unless-stopped
    privileged: true
    user: root
    ports:
      - "${JENKINS_HTTP_PORT:-8085}:8080"
      - "${JENKINS_AGENT_PORT:-50000}:50000"
    volumes:
      - ${JENKINS_DATA_DIR:-./jenkins_data}:/var/jenkins_home
      - /var/run/docker.sock:/var/run/docker.sock
    networks:
      - jenkins_network
networks:
  jenkins_network:
    driver: bridge
```

### Healthcheck

To ensure the container is running correctly, you can add a healthcheck to the service in the `docker-compose.yml` file:

```yaml
healthcheck:
  test: ["CMD", "curl", "-f", "http://localhost:8080/login"]
  interval: 10s
  timeout: 5s
  retries: 5
```

### Accessing Jenkins

Once the service is running, you can access the Jenkins web interface at `http://127.0.0.1:8085`.