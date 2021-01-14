FROM tomcat:latest
COPY /PersistentWebAppWithDocker/target/*.war /usr/local/tomcat/webapps
EXPOSE 8090
