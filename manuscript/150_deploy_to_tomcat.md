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
