FROM jenkins:2.19.4

MAINTAINER vijayboopathy <vibe@initcron.org>

# Change to root user to install packages
USER root

# Install Prereqs
RUN apt update -y && \
    apt-get -y install wget sudo && \
    echo "jenkins    ALL=NOPASSWD: ALL" >> /etc/sudoers

# Install Docker Compose
RUN curl -L https://github.com/docker/compose/releases/download/1.14.0/docker-compose-`uname -s`-`uname -m` > /usr/local/bin/docker-compose && \
    chmod +x /usr/local/bin/docker-compose


# Install Docker-Engine
RUN apt-get install -yq apt-transport-https ca-certificates curl software-properties-common \
    && curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - \
    && add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable" \
    && apt-get update -yq \
    && apt-get install -yq docker-ce \
    && usermod -aG docker jenkins

# Change to Jenkins User
USER jenkins

COPY entrypoint.sh /usr/local/bin/entrypoint.sh
ENTRYPOINT [ "/usr/local/bin/entrypoint.sh"]
