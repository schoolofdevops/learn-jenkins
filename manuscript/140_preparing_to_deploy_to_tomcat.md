
# Preparing Tomcat for Deployment

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
