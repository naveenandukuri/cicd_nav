FROM maven:3.6.3-jdk-11 as build
WORKDIR /app
COPY . .
RUN mvn clean package
FROM openjdk:11.0 as run
WORKDIR /app
COPY --from=build /app/webapp/target/webapp.war /app
EXPOSE 8080
CMD ["java","-war","webapp.war"]
