[1mdiff --git a/manuscript/110_static_code_analysis_with_sonarqube.md b/manuscript/110_static_code_analysis_with_sonarqube.md[m
[1mindex 3121391..5d5c051 100644[m
[1m--- a/manuscript/110_static_code_analysis_with_sonarqube.md[m
[1m+++ b/manuscript/110_static_code_analysis_with_sonarqube.md[m
[36m@@ -87,21 +87,19 @@[m [mSave and Build.  If the job is successful, it should show a status similar to be[m
       docker exec -it sonarqube /bin/bash[m
 ```[m
 [m
[31m-* Execute the following command to install plugin and exit the container.[m
[32m+[m[32m* Execute the following commands to install plugin and exit the container.[m
 [m
 ```[m
[31m-[m
[31m-      cd extensions/plugins/[m
[31m-[m
[31m-      wget -c https://github.com/SonarQubeCommunity/sonar-build-breaker/releases/download/2.1/sonar-build-breaker-plugin-2.1.jar[m
[31m-[m
[31m-      exit[m
[31m-[m
[32m+[m[32mcd extensions/plugins/[m
[32m+[m[32mwget -c https://github.com/SonarQubeCommunity/sonar-build-breaker/releases/download/2.1/sonar-build-breaker-plugin-2.1.jar[m
[32m+[m[32mexit[m
 ```[m
 [m
 * Restart the container[m
 [m
[31m-      docker restart sonarqube[m
[32m+[m[32m```[m
[32m+[m[32mdocker restart sonarqube[m
[32m+[m[32m```[m
 [m
 ### Customizing Quality Gate[m
 [m
[1mdiff --git a/manuscript/120_deploy_to_tomcat.md b/manuscript/120_deploy_to_tomcat.md[m
[1mindex 60e398c..fe1d715 100644[m
[1m--- a/manuscript/120_deploy_to_tomcat.md[m
[1m+++ b/manuscript/120_deploy_to_tomcat.md[m
[36m@@ -35,10 +35,10 @@[m [mThis file need to be mounted inside the container in `/usr/local/tomcat/conf/`[m
 Now use docker run command with port mapping and volume mount option to run Tomcat docker container.[m
 [m
 ```[m
[31m-docker run -d -p 8888:8080 -v /path/to/tomcat-users.xml:/usr/local/tomcat/conf/tomcat-users.xml tomcat[m
[32m+[m[32mdocker run -idt -p 8888:8080 -v /path/to/tomcat-users.xml:/usr/local/tomcat/conf/tomcat-users.xml tomcat[m
 ```[m
 [m
[31m-2. Replace **/path/to/** with the corresponding path of tomcat-users.xml file that you have created.[m
[32m+[m[32m2. Replace **/path/to/** with the corresponding absolute path of tomcat-users.xml file that you have created.[m
 3. Install **Deploy to Container** Plugin in jenkins[m
 4. Create a project called **deploy** which is a copy of **test** job[m
 5. But the maven goal should be **"package"**.[m
warning: LF will be replaced by CRLF in manuscript/120_deploy_to_tomcat.md.
The file will have its original line endings in your working directory.
