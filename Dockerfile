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

# Copy project files first (including pom.xml for Maven)
COPY . .

# Set the working directory to where the pom.xml is located (before running Maven)
WORKDIR /usr/src/calc/java_project

# Run Maven build (Ensure pom.xml is present in this directory)
RUN mvn -X package -Dmaven.test.skip=true

# Install dependencies for Node.js
WORKDIR /usr/src/calc  # Go back to the root directory where package.json is located
RUN npm install

# Verify the pom.xml file is present in the correct directory
RUN ls -la /usr/src/calc/java_project

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
