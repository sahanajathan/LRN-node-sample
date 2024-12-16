FROM --platform=linux/amd64 node:alpine
RUN mkdir -p /usr/src/calc
WORKDIR /usr/src/calc
COPY . .
RUN npm install
EXPOSE 3000
CMD [ "node", "app.js" ]


# Use an official Maven image for building the app
FROM maven:3.8.4-openjdk-11 AS build

# Declare Snyk Token as a build argument
ARG snyk_auth_token

# Set the SNYK_TOKEN environment variable using the build argument
ENV SNYK_TOKEN=${snyk_auth_token}

# Set the working directory in the container
WORKDIR /app

# Copy the Maven project files to the container
COPY . .

# ~~~~~~~ SNYK Variable ~~~~~~~~
# The SNYK_TOKEN environment variable is now set, and Snyk can be used to scan the application.

# Package the application (skip tests for faster builds)
RUN mvn package -Dmaven.test.skip=true

# ~~~~~~~~~ SNYK Test ~~~~~~~~~
# Download and configure Snyk CLI tool
RUN curl -Lo ./snyk "https://github.com/snyk/snyk/releases/download/v1.210.0/snyk-linux"
RUN chmod +x ./snyk

# Authenticate with Snyk using the environment variable (SNYK_TOKEN)
RUN ./snyk auth $SNYK_TOKEN

# Run Snyk to test your project for vulnerabilities (fail the build if vulnerabilities are found with medium or higher severity)
RUN ./snyk test --severity-threshold=medium

# Optionally, upload the vulnerability results to Snyk's dashboard for monitoring 
RUN ./snyk monitor

# Expose the application (if needed, based on your use case)
# EXPOSE 8080  # Uncomment if the application runs on a specific port

# Optionally, you can define the default command to run your app (e.g., if it's a web app, REST API, etc.)
# CMD ["java", "-jar", "target/your-app.jar"]  # Adjust as necessary for your app 



