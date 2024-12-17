#FROM --platform=linux/amd64 node:alpine
#RUN mkdir -p /usr/src/calc
#WORKDIR /usr/src/calc
#COPY . .
#RUN npm install
#EXPOSE 3000
#CMD [ "node", "app.js" ]



# Use official Node.js image with amd64 support
FROM --platform=linux/amd64 node:alpine



#~~~~~~~SNYK Variable~~~~~~~~~~~~
# Declare Snyktoken as a build-arg
ARG snyk_auth_token
# Set the SNYK_TOKEN environment variable
ENV SNYK_TOKEN=${snyk_auth_token}
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


RUN apk add --no-cache \
    bash \
    curl \
    git 
    
# Create and set working directory
RUN mkdir -p /usr/src/calc
WORKDIR /usr/src/calc

COPY . .
RUN npm install

# Install and run SNYK for security testing
RUN curl -Lo ./snyk "https://github.com/snyk/snyk/releases/download/v1.210.0/snyk-linux"
RUN chmod -R +x ./snyk

# Set the SNYK_AUTH_TOKEN in environment variable (ensure this is passed at runtime)
RUN ./snyk test --severity-threshold=medium
RUN ./snyk monitor

# Expose the required port
EXPOSE 3000

# Start the app
CMD [ "node", "app.js" ]

