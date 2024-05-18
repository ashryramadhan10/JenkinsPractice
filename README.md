# JenkinsPractice

## 1. Installing Jenkins with Docker

First, pull the docker image for jenkins:
```console
docker run --name jenkins --publish 8080:8080 -v <host_volume>:/var/jenkins_home jenkins/jenkins
```

Then, do the initial setup by submitting the password that's appers on the terminal.

## 2. Add SSH Key in Jenkins Environment

Ensure the jenkins container is run, then we can use this command check our jenkins container:
```console
docker container start jenkins
docker container exec -it jenkins /bin/bash
```

:warning: Notes: check if your container is connected to the internet or not using this command: `curl https://www.google.com`.

After that, we can create the .ssh key for the jenkins environment by using this command:

```console
ssh-keygen -t ed25519 -C "your.email@example.com"
```

## 3. Install Git Plugin

