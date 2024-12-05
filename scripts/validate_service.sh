#!/bin/bash

# Print out commands as they are executed
set -x

# Check if the app is running (example for a Node.js app)
echo "Validating service..."

# Check if the process is running
if pgrep -f "npm start" > /dev/null; then
    echo "Application is running successfully!"
    exit 0
else
    echo "Application is not running. Check logs for more information."
    exit 1
fi
