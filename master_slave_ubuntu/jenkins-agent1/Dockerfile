# Use the official Ubuntu image as a base
FROM ubuntu:20.04

# Set environment variables to avoid prompts during package installation
ENV DEBIAN_FRONTEND=noninteractive

USER root

# Install necessary packages
RUN apt-get update && \
    apt-get install -y openjdk-11-jdk wget curl git openssh-client openssh-server && \
    rm -rf /var/lib/apt/lists/*

# Create a jenkins_agent1 user
RUN useradd -d /var/lib/jenkins_agent1 -s /bin/bash jenkins_agent1

RUN mkdir /var/run/sshd

# Set up SSH for jenkins_agent1 user
RUN mkdir -p /var/lib/jenkins_agent1/.ssh && \
    chown -R jenkins_agent1:jenkins_agent1 /var/lib/jenkins_agent1/.ssh

# Copy SSH public key for authentication
COPY authorized_keys /var/lib/jenkins_agent1/.ssh/authorized_keys
RUN chown jenkins_agent1:jenkins_agent1 /var/lib/jenkins_agent1/.ssh/authorized_keys && \
    chmod 600 /var/lib/jenkins_agent1/.ssh/authorized_keys && \
    chmod 700 /var/lib/jenkins_agent1/.ssh

# Configure SSH daemon
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin no/' /etc/ssh/sshd_config && \
    sed -i 's/#PubkeyAuthentication yes/PubkeyAuthentication yes/' /etc/ssh/sshd_config

# Expose SSH port
EXPOSE 22

# Start SSH daemon
CMD ["/usr/sbin/sshd", "-D"]
