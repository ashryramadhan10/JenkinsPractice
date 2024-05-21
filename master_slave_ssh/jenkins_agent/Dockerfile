# Dockerfile for Jenkins SSH Agent
FROM jenkins/inbound-agent:latest

USER root

# Install OpenSSH server
RUN apt-get update && apt-get install -y openssh-server

# Create SSH directory and set permissions
RUN mkdir /var/run/sshd

# Configure SSH for root and jenkins user
RUN echo 'root:password' | chpasswd
RUN echo 'jenkins:jenkins' | chpasswd

# Enable SSH root login and password authentication
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
    sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# Create Jenkins agent user
RUN useradd -m -d /home/jenkins -s /bin/bash jenkins

# Set up SSH keys for the Jenkins user
RUN mkdir /home/jenkins/.ssh
COPY id_ed25519.pub /home/jenkins/.ssh/authorized_keys
RUN chown -R jenkins:jenkins /home/jenkins/.ssh
RUN chmod 700 /home/jenkins/.ssh
RUN chmod 600 /home/jenkins/.ssh/authorized_keys

# Expose SSH port
EXPOSE 22

# Start SSH server
CMD ["/usr/sbin/sshd", "-D"]