Flow:

1. Build simple jobs pipeline - 3jobs
1. Setup JDK and Maven
1. Create a maven build job - compile
1. Integrate with git
1. Build triggers - remote, polling
1. Artifactory
1. Artifactory integration to resolve libs
1. Create Test Job - test
1. Static Code Analysis with SonarQube
1. Deploying to tomcat
1. Deploy Using Docker

What will you learn

1. **Git** Integration with Jenkins
1. Using  **Jenkins** to automate workflows 1. Setting up a CI and CD process for a sample java project.
1. Using **Artifactory** for fetching libs from and push build **Artifacts** to
1. Using SonarQube for Static Code Analysis
1. Deploying to **Tomcat**
1. Running containers with Docker
2. Docker **deployment** process

TODO
Setup deployment with Docker Compose, Swarm, Consul etc. 

http://192.168.5.10:8080/job/build/build?token=j4jthgiop45o34mkm0jrege


Artifactory Integration
1. Install Artifactory Plugin
2. Manage Jenkins -> Configure System -> Artifactory -> Add
3. Add Artifactory details and Test Connection

   uri: http://192.168.5.10:8081/artifactory
   port: 9000
   user: admin
   pass: password






SonarQube Integration
1. Install Artifactory Plugin
2. Configure Artifactory PLugin
3. From Security -> Users , click on tokens for any user. Assign a name and click on generate.
port: 8081
user: admin
pass: admin
token: 6f5ff1f6cc711379a5c970e25fd505f3c54f5274
4. Update Job Configurations to use SonarQube Runner as part of build/pre-build steps


Tomcat Deploy

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



Docker Deploy
