FROM tomcat:latest
COPY /target/PersistentWebApp.war /usr/local/tomcat/webapps
EXPOSE 8080
