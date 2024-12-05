#!/bin/bash

# Print out commands as they are executed
set -x

# Install dependencies (example for Node.js app)
echo "Installing dependencies..."
cd /opt/codedeploy-agent/deployment-root/$DEPLOYMENT_ID/my-application-files
npm install --production

# Ensure any other required dependencies are installed, like system packages
# Example: Installing a system package
# sudo yum install -y some-package

# Finished installing dependencies
echo "Dependencies installed successfully!"
