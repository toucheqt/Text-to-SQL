# User maven to build the project
FROM maven:3.9.9-eclipse-temurin-22-alpine AS build

COPY pom.xml build/
COPY src build/src/

RUN mvn clean package -DskipTests --file /build/pom.xml

# Use minimal JDK to run the application
FROM eclipse-temurin:22-jdk-alpine

COPY --from=build /build/target/texttosql-*.jar app.jar

ENTRYPOINT ["java", "-jar", "/app.jar"]
