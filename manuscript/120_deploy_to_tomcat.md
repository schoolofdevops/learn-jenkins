# Deploying to Tomcat

We have setup the jobs which compile code and then run unit tests, static code analysis etc. Once its been unit tested, we would like to deploy the software. In this case we would deploy it to a tomcat server in our development environment. Later on, we would also create a docker image which could then be either deployed to production, or shipped to the customers.


## Preparing Tomcat for Deployment

We already have tomcat running as a docker container.

To deploy to tomcat, we first need to create a manager user for tomcat.


1. Update tomcat-users.xml, restart tomcat
```
docker exec -it tomcat /bin/bash
apt-get update
apt-get install vim -yq
```
Replace the contents of conf/tomcat-users.xml with the configs from the following url
https://gist.github.com/initcron/e95c2b96ec258e02c424dd488c0079c1

Restart tomcat container

```
docker stop tomcat
docker start tomcat

```


2. Install Deploy to Container Plugin
3. From post build action, select deploy to EAR/WAR Container
     context: cmad
     tomcat url : http://ip:8080
     user: admin
     pass: pass/admin

Deploy Jobs Steps:
1. Create deploy job
2. Archive Artifacts
3. Deploy to Tomcat
4. Send  Artifacts to Artifactory
