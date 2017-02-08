# Deploying to Tomcat

We have setup the jobs which compile code and then run unit tests, static code analysis etc. Once its been unit tested, we would like to deploy the software. In this case we would deploy it to a tomcat server in our development environment. Later on, we would also create a docker image which could then be either deployed to production, or shipped to the customers.

## Preparing Tomcat for Deployment

### Running Tomcat as a Docker Container

* We assume that docker image for Tomcat is being pulled from [docker hub](https://hub.docker.com/_/tomcat/).

* To deploy to tomcat, we first need to create user configurations to enable tomcat admin UI.

* Lets create a `tomcat-users.xml` in on the docker host machine.

This tomcat-users.xml file contains,

```
<?xml version='1.0' encoding='utf-8'?>

<tomcat-users xmlns="http://tomcat.apache.org/xml"
              xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
              xsi:schemaLocation="http://tomcat.apache.org/xml tomcat-users.xsd"
              version="1.0">

  <role rolename="admin-gui"/>
  <role rolename="manager-gui"/>
  <user username="admin" password="password" roles="admin-gui,manager-gui,manager-script"/>

</tomcat-users>
```

This file need to be mounted inside the container in `/usr/local/tomcat/conf/`.

Now use docker run command with port mapping and volume mount option to run Tomcat docker container.

```
docker run -idt -p 8888:8080 -v /path/to/tomcat-users.xml:/usr/local/tomcat/conf/tomcat-users.xml tomcat
```

1. Replace **/path/to/** with the corresponding absolute path of tomcat-users.xml file that you have created.

2. Install **Deploy to Container** Plugin in jenkins.

3. Create a project called **deploy** which is a copy of **test** job.

4. But the maven goal should be **"package"**.
![maven](images/chap12/mvn.png)

5. From post build action, select deploy to EAR/WAR Container

```
context: cmad
tomcat url : http://ipadress:8888
user: admin
pass: s3cret
```

![deploy to Container](images/chap12/deploy to Container.png)

6. From post build action, select Deploy artifacts to Artifactory.

7. Refresh to get the target repositories.

  ![Deploy artifacts to Artifactory](images/chap12/Deploy artifacts to Artifactory.png)

7. Verify browser for Deployment.

  ![Deployment](images/chap12/Deployment.png)
