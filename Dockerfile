FROM maven:3.6.3-jdk-11 AS build
# Build Stage
WORKDIR /usr/src/app

COPY ./ /usr/src/app
RUN mvn clean install -DskipTests


# Docker Build Stage
FROM openjdk:11

COPY --from=build /usr/src/app/target/*.jar app.jar

ENV PORT 8080
EXPOSE $PORT

ENTRYPOINT ["java","-jar","-Dserver.port=${PORT}","app.jar"]
