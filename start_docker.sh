#!/bin/bash
#docker build -t myjenkins-blueocean:2.414.2 .
docker network create jenkins
docker run --name jenkins-blueocean --restart=on-failure --detach \
  --network jenkins --env DOCKER_HOST=tcp://docker:2376 \
  --env DOCKER_CERT_PATH=/certs/client --env DOCKER_TLS_VERIFY=1 \
  --publish 8080:8080 --publish 50000:50000 \
  --volume jenkins-data:/var/jenkins_home \
  --volume jenkins-docker-certs:/certs/client:ro \
  docker pull nirav96/jenkins:latest
id=$(docker ps --format "{{.ID}}")
jenkins_password=$(docker exec $id cat  /var/jenkins_home/secrets/initialAdminPassword)
echo "Jenkins Admin Password: "$jenkins_password