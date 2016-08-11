# JENKINS

Jenkins is a essential automation tool to setup Continuous Integration. Its the integrator which helps you build your development,  testing and deployment  workflow and create job pipelines. It also adds visibility to all stake holders including the Dev, QA, Ops teams involved in building, testing and deploying the product.

## Installing Jenkins on Ubuntu 14.04

Jenkins requires Java Development Kit to be installed first.

### Installing Pre Requisites

#### OpenJDK 7

* Installing OpenJDK 7

  ```
  $ sudo apt-get install openjdk-7-jre
  $ sudo apt-get install openjdk-7-jdk
  ```

  If you face any dependency error use this command to resolve the dependencies.

  ```
  $ sudo apt-get -f install
  ```  
* Verifying Installation

  ```
  $ sudo java -version
  ```

#### Installing Maven 3

* Installing Maven

  ```
  $ sudo apt-get install maven
  ```

* Verifying Installation

  ```
  $ sudo mvn -version
  ```

#### Installing Jenkins

To install Jenkins in Ubuntu visit [jenkins.io](http://pkg.jenkins-ci.org/debian-stable/)

Download the specific version of .deb package using wget in tmp folder and proceed with depackaging.

**Note:** In our case we use jenkins_1.651.3

```
$ sudo wget http://pkg.jenkins-ci.org/debian-stable/binary/jenkins_1.651.3_all.deb
$ sudo dpkg -i jenkins_1.651.3_all.deb
```

Verifying Installation by checking the status of Jenkins service.

```
$ sudo ps -aux | grep jenkins
```

Jenkins service is running in port 8080

Visit Jenkins Console in browser by visitig `http://localhost:8080` replace localhost with the VM ip.

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

#### Installing Docker Engine

Proceed with installing Docker Engine in Ubuntu 14.04 for a detail instruction visit [docs.docker.com](https://docs.docker.com/engine/installation/linux/ubuntulinux/)

After installing docker, pull Jenkins docker image from [docker hub](https://hub.docker.com/_/jenkins/)

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
