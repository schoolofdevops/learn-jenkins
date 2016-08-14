# JENKINS

Jenkins is a essential automation tool to setup Continuous Integration. Its the integrator which helps you build your development,  testing and deployment  workflow and create job pipelines. It also adds visibility to all stake holders including the Dev, QA, Ops teams involved in building, testing and deploying the product.

## Setting up environment using  Vagrant (Pre bundled Image)

This is the simplest way of setting up the learning environment for this course following are the pre requisites,

  * You should have setup the environment by following the steps mentioned on the [Common Lab Setup Instructions](https://github.com/schoolofdevops/lab-setup/blob/master/common/common-lab-setup-instructions.md)  
  * You should also have received a pre pre bundled vagrant box (e.g. devops-ci-v01.box) with jenkins and docker installed and copied over to your development machine (windows/Mac/Linux Laptop/Desktop)  
  * You should have downloaded the [lab-setup repository]( https://github.com/schoolofdevops/lab-setup)  

#### Import the Vagrant Box

Open a bash terminal using ConEMU or Git Bash, change into the directory where you have copied over the box file and import it using,

``` vagrant box add devops  devops-ci-v01.box ```

Validate that the box is available on your system by running,

{title="Listing ", lang=html, linenos=off}
~~~~~~~

vagrant box list

[output]

devops                   (virtualbox, 0)

~~~~~~~

If you see **devops** in the list of available boxes, the template is been successfully imported.

Now lets bring up the Vagrant environment. To do so, you need to open a bash shell either using ConEmu or Git Bash and cd into lab-setup/ci/virtual directory. In this directory, you should see a Vagrantfile.

A> ##
A> All vagrant commands to manage a VM are run from a directory
A> where this Vagrantfile is


{title="Listing ", lang=html, linenos=off}
~~~~~~~
cd lab-setup/ci/virtual
vagrant up
vagrant ssh
~~~~~~~

After you run **vagrant ssh**, you should have been logged into the environment.

Validate that Jenkins comes up at the following URL

http://192.168.9.10:8080


## Setting up learning environment on Ubuntu 14.04

Jenkins requires Java Development Kit to be installed first.

### Installing Pre Requisites

#### OpenJDK 7

* Installing OpenJDK 7

  ```
  $ sudo apt-get install add-apt-repository
  $ sudo add-apt-repository ppa:openjdk-r/ppa
  $ sudo apt-get update
  $ sudo apt-get install openjdk-8-jdk
  ```

  Run the following command to set the default Java and Javac:

  ```
  $ sudo update-alternatives --config java
  $ sudo update-alternatives --config javac
  ```

  If there is more than one Java versions installed on your system, type in a number to select a Java version.

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

## Setting up learning environment on CentOS/RHEL 6.x

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

Proceed with installing Docker Engine on your choice of Operating System. For details on how to install docker visit the official installation page at  [docs.docker.com](https://docs.docker.com/engine/installation/)

We assume you have installed docker and are ready to launch containers before proceeding. To validate docker environment run  

``` docker ps ```

If the above command goes through without errors, you are all set.  


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

----
[Chapter 1: Introduction **Prev**](https://github.com/schoolofdevops/learn-jenkins/blob/master/manuscript/020_install_jenkins.md) :point_left:

:point_right: [**Next** Chapter 3: Configure Jenkins](https://github.com/schoolofdevops/learn-jenkins/blob/master/manuscript/030_configure_jenkins.md)
