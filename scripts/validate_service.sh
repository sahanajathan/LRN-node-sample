#!/bin/bash
echo "Validating if the container is running..."
if docker ps -q -f name=my-container; then
  echo "Application is running successfully!"
  exit 0
else
  echo "Application failed to start!"
  exit 1
fi
