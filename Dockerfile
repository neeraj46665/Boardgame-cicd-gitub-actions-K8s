# Step 1: Build the application
FROM maven:3.8.4-openjdk-11 AS builder

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy the Maven project files to the container
COPY . .

# Build the application
RUN mvn clean package

# Step 2: Create the final image
FROM adoptopenjdk/openjdk11

# Expose the port that your application will run on
EXPOSE 8080

# Set the application directory
ENV APP_HOME /usr/src/app

# Copy the jar file from the builder stage
COPY --from=builder /usr/src/app/target/*.jar $APP_HOME/app.jar

# Set the working directory
WORKDIR $APP_HOME

# Command to run the application
CMD ["java", "-jar", "app.jar"]
