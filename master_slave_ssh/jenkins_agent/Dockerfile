# Dockerfile for Jenkins SSH Agent
FROM ubuntu:20.04

# Set environment variables to avoid interactive prompts during installation
ENV DEBIAN_FRONTEND=noninteractive

# Install OpenSSH server and OpenJDK
RUN apt-get update && \
    apt-get install -y openssh-server openjdk-11-jdk && \
    rm -rf /var/lib/apt/lists/*

# Generate SSH host keys
RUN ssh-keygen -A

# Create necessary directories and set permissions
RUN mkdir /var/run/sshd

# Create Jenkins user with home directory and set password
RUN useradd -m -d /home/jenkins -s /bin/bash jenkins && \
    echo "jenkins:jenkins" | chpasswd && \
    mkdir /home/jenkins/.ssh && \
    chown -R jenkins:jenkins /home/jenkins/.ssh && \
    chmod 700 /home/jenkins/.ssh

# Copy the public key for Jenkins user authentication
COPY id_ed25519.pub /home/jenkins/.ssh/authorized_keys
RUN chown jenkins:jenkins /home/jenkins/.ssh/authorized_keys && \
    chmod 600 /home/jenkins/.ssh/authorized_keys

# Configure SSH daemon
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config && \
    echo "AllowUsers jenkins" >> /etc/ssh/sshd_config

# Expose SSH port
EXPOSE 22

RUN su jenkins
RUN cd /home/jenkins

# Start SSH service
CMD ["/usr/sbin/sshd", "-D"]
