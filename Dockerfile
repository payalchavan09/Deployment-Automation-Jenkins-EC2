FROM maven:3.6.3-jdk-11 AS build
# Build Stage
WORKDIR /usr/src/app

COPY ./ /usr/src/app
RUN mvn clean install -DskipTests

FROM openjdk:11

COPY --from=build /usr/src/app/target/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java","-jar","app.jar"]
