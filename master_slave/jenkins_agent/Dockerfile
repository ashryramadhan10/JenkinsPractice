# Dockerfile for Jenkins Swarm Agent
FROM jenkins/inbound-agent:latest

USER root

# Install necessary tools
RUN apt-get update && apt-get install -y curl

# Download the Swarm client JAR file
RUN curl -o /usr/local/bin/swarm-client.jar -L \
    http://repo.jenkins-ci.org/releases/org/jenkins-ci/plugins/swarm-client/3.46/swarm-client-3.46.jar

# Copy entrypoint script
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

# Set entrypoint script
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
