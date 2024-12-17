#FROM --platform=linux/amd64 node:alpine
#RUN mkdir -p /usr/src/calc
#WORKDIR /usr/src/calc
#COPY . .
#RUN npm install
#EXPOSE 3000
#CMD [ "node", "app.js" ]




# Use official Node.js image with amd64 support
FROM --platform=linux/amd64 node:alpine

# Install Maven dependencies (Alpine-based images need these packages)
RUN apk add --no-cache \
    bash \
    curl \
    git \
    openjdk11 \
    maven

# Create and set working directory
RUN mkdir -p /usr/src/calc
WORKDIR /usr/src/calc

# Copy project files
COPY . .

# Install dependencies for Node.js
RUN npm install


WORKDIR /usr/src/calc/java_project  # Set to the directory where pom.xml is located
# Package the application (Assuming a Maven-based project)
RUN mvn package -Dmaven.test.skip=true

# Expose the required port
EXPOSE 3000

# Start the app
CMD [ "node", "app.js" ]

# Install and run SNYK for security testing
RUN curl -Lo ./snyk "https://github.com/snyk/snyk/releases/download/v1.210.0/snyk-linux"
RUN chmod -R +x ./snyk

# Set the SNYK_AUTH_TOKEN in environment variable (ensure this is passed at runtime)
RUN ./snyk test --severity-threshold=medium
RUN ./snyk monitor

