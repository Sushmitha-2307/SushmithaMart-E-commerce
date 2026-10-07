FROM maven:3.9-eclipse-temurin-21 AS builder

WORKDIR /app

COPY pom.xml .

COPY src ./src

RUN mvn clean package -DskipTests


FROM tomcat:10.1-jdk21-temurin

WORKDIR /usr/local/tomcat

COPY --from=builder /app/target/sushmithamart.war webapps/ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]