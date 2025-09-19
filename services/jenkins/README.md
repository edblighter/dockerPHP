# Jenkins Service

## Overview
This service provides [Jenkins](https://www.jenkins.io/), a powerful, extensible automation server for CI/CD pipelines, building, testing, and deploying software.

## Features
- **CI/CD Automation:** Automate development lifecycle from build to deployment.
- **Plugin Ecosystem:** Thousands of plugins for integrations.
- **Distributed Builds:** Scale builds across multiple agents.
- **Pipeline as Code:** Define pipelines with Jenkinsfile.

## Prerequisites
- Docker and Docker Compose installed.
- Sufficient resources for builds.

## Quick Start
1. Run: `docker-compose -f services/jenkins/docker-compose.yml up -d`
2. Access at `http://127.0.0.1:8085`
3. Complete initial setup and unlock with admin password from logs.

## Configuration
Customize via environment variables or `.env.jenkins`:

| Variable               | Description                                       | Default Value    |
| ---------------------- | ------------------------------------------------- | ---------------- |
| `JENKINS_CONTAINER_NAME` | The name of the Jenkins container.               | `jenkins`        |
| `JENKINS_IMAGE`        | The Docker image for Jenkins.                     | `jenkins/jenkins`|
| `JENKINS_VERSION`      | The version of the Jenkins image.                 | `lts`            |
| `JENKINS_HTTP_PORT`    | The HTTP port for Jenkins.                        | `8085`           |
| `JENKINS_AGENT_PORT`   | The port for Jenkins agents.                      | `50000`          |
| `JENKINS_DATA_DIR`     | The directory for Jenkins data.                   | `./jenkins_data` |

## Usage
- **Web UI:** Manage jobs, plugins, and configurations.
- **Pipelines:** Create freestyle or pipeline jobs.
- **Agents:** Connect build agents for distributed builds.
- **Plugins:** Install plugins for Git, Docker, etc.
- **Security:** Configure users, roles, and credentials.

## Troubleshooting
- **Unlock Password:** Check logs with `docker logs <container>` for initial password.
- **Permission Issues:** Ensure Docker socket access for Docker builds.
- **Memory/CPU:** Increase limits if builds fail due to resources.
- **Plugin Errors:** Check plugin compatibility and update Jenkins.

## Links
- [Jenkins Documentation](https://www.jenkins.io/doc/)
- [Pipeline Syntax](https://www.jenkins.io/doc/book/pipeline/syntax/)