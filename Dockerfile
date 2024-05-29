FROM jenkins/jenkins:latest
USER root
RUN apt-get update && apt-get install -y lsb-release python3-pip 
RUN curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc \
  https://download.docker.com/linux/debian/gpg
RUN echo "deb [arch=$(dpkg --print-architecture) \
  signed-by=/usr/share/keyrings/docker-archive-keyring.asc] \
  https://download.docker.com/linux/debian \
  $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list
RUN apt-get update && apt-get install -y docker-ce-cli && apt-get install -y nano && apt-get install -y curl && apt-get install sudo
RUN echo 'root:root' | chpasswd
RUN echo 'jenkins:jenkins' | chpasswd
USER jenkins
RUN jenkins-plugin-cli --plugins "blueocean:1.27.10 docker-workflow:1.28"
