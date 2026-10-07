FROM tomcat:10.1-jdk21-temurin

WORKDIR /usr/local/tomcat

COPY target/sushmithamart.war webapps/ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]