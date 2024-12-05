#!/bin/bash

# Print out commands as they are executed
set -x

# Start the application (example for Node.js)
echo "Starting application..."
cd /opt/codedeploy-agent/deployment-root/$DEPLOYMENT_ID/my-application-files
nohup npm start > /opt/codedeploy-agent/deployment-root/$DEPLOYMENT_ID/my-application-files/app.log 2>&1 &

# Alternatively, if you're using PM2 to manage your Node.js app:
# pm2 start server.js

echo "Application started successfully!"
