FROM tomcat:latest
COPY /PersistentWebAppWithDocker/target/PersistentWebApp.war /usr/local/tomcat/webapps
EXPOSE 8090
