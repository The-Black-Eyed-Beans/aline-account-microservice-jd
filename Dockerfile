FROM openjdk:8u312-jre-slim-buster
ARG JAR_FILE=account-microservice/target/*.jar
COPY ${JAR_FILE} myJar.jar
ENTRYPOINT ["java","-jar","myJar.jar"]
