# Dockerfile for Auth Service (Default)
# This builds the auth-quiz-service by default
# For other services, copy and modify this file as needed

# Multi-stage build
FROM maven:3.8.4-openjdk-17-slim AS build

# Set working directory
WORKDIR /app

# Copy auth service files
COPY auth-quiz-service/pom.xml .
COPY auth-quiz-service/src ./src

# Package the application
RUN mvn clean package -DskipTests

# Runtime stage
FROM openjdk:17-jdk-slim

# Set working directory
WORKDIR /app

# Copy the built JAR from build stage
COPY --from=build /app/target/auth-quiz-service-1.0.0.jar app.jar

# Expose port
EXPOSE 8080

# Set environment variables
ENV SPRING_PROFILES_ACTIVE=back4app

# Run the application
CMD ["java", "-jar", "app.jar"]
