FROM jenkins/ssh-agent:alpine-jdk17

# Ensure the 'jenkins' user exists
RUN adduser -D -u 1000 jenkins

# Update the SSH server configuration
RUN echo "AllowUsers jenkins" >> /etc/ssh/sshd_config

EXPOSE 22