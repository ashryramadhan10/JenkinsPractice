sudo docker compose stop
sudo docker compose down
sudo docker image rm master_slave_ssh-jenkins_agent
sudo docker image rm master_slave_ssh-jenkins_master
sudo docker compose ps -a
sudo docker images