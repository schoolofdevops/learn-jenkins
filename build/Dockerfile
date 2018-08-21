FROM jenkins:2.60.3

MAINTAINER vijayboopathy <vibe@initcron.org>

# Change to root user to install packages
USER root

# Install Prereqs
RUN apt update -y && \
    apt-get -y install wget zip sudo && \
    echo "jenkins    ALL=NOPASSWD: ALL" >> /etc/sudoers

RUN echo "deb http://ppa.launchpad.net/ansible/ansible/ubuntu trusty main" >> /etc/apt/sources.list \ 
    && apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 93C4A3FD7BB9C367 \
    && apt-get update \
    && apt-get install -yq ansible
    
# Install Docker Compose
RUN curl -L https://github.com/docker/compose/releases/download/1.19.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose


# Install Docker-Engine
RUN apt-get install -yq apt-transport-https ca-certificates curl gnupg2 software-properties-common \
    && curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - \
    && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" \
    && apt-get update -yq \
    && apt-get install -yq docker-ce \
    && usermod -aG docker jenkins

# Change to Jenkins User
USER jenkins

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
ENTRYPOINT [ "/usr/local/bin/entrypoint.sh"]
