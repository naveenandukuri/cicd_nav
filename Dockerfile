FROM maven as build
WORKDIR /app
COPY . .
RUN mvn install
FROM openjdk:11.0 as run
WORKDIR /app
COPY --from=build /app/webapp/target/webapp.jar /app
EXPOSE 8080
CMD ["java","-jar","webapp.jar"]
