SonarQube Integration
1. Install Sonarqube Plugin
2. Configure SonarQube PLugin
3. From Security -> Users , click on tokens for any user. Assign a name and click on generate.
port: 8081
user: admin
pass: admin
token: 6f5ff1f6cc711379a5c970e25fd505f3c54f5274
4. Update Job Configurations to use SonarQube Runner as part of build/pre-build steps
