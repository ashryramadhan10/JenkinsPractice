docker compose stop
docker compose down
docker image rm master_slave_ssh-jenkins_agent
docker image rm master_slave_ssh-jenkins_master
docker compose ps -a
docker images