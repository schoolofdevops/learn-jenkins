# JENKINS

Jenkins is a essential automation tool to setup Continuous Integration. Its the integrator which helps you build your development,  testing and deployment  workflow and create job pipelines. It also adds visibility to all stake holders including the dev, qa, ops teams involved in building, testing and deploying the product.

## Installing Jenkins on Centos 6.x

Jenkins requires Java Development Kit to be installed first.

### Installing Pre Requisites

Installing OpenJDK 7

```
yum install -y  <jdk>

```

Installing Stable version of Jenkins

{title="Listing ", lang=shell, linenos=off}
~~~~~~~
sudo wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo
sudo rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key
sudo yum install jenkins
sudo service jenkins start
~~~~~~~

## Installing Jenkins With Docker

This is the simplest way of installing Jenkins and requires minimal efforts.

```
docker run -d --name jenkins   -p 8080:8080 -p 50000:50000 jenkins

```

If you install it using the instructions above, find out the IP address and go to http://YOUR_IP_ADDRESS:8080 to access jenkins UI.


To stop/start jenkins with docker, use the following commands,

```
docker stop jenkins
docker start jenkins
```
