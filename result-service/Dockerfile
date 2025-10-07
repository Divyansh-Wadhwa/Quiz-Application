# Multi-stage build for Back4App compatibility
FROM maven:3.8.4-openjdk-17-slim AS build

# Set working directory
WORKDIR /app

# Copy pom.xml and source code
COPY pom.xml .
COPY src ./src

# Package the application
RUN mvn clean package -DskipTests

# Runtime stage
FROM openjdk:17-jdk-slim

# Set working directory
WORKDIR /app

# Copy the built JAR from build stage  
COPY --from=build /app/target/result-service-1.0.0.jar app.jar

# Expose port
EXPOSE 8082

# Set environment variables
ENV SPRING_PROFILES_ACTIVE=back4app

# Run the application
CMD ["java", "-jar", "app.jar"]
