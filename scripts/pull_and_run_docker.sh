#!/bin/bash

# Ensure Docker is running
if ! systemctl is-active --quiet docker; then
    echo "Docker is not running, starting Docker..."
    service docker start
else
    echo "Docker is already running."
fi

# Log in to Amazon ECR
echo "Logging in to Amazon ECR..."
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 843835551300.dkr.ecr.us-east-1.amazonaws.com

# Pull the Docker image from ECR
echo "Pulling Docker image from ECR..."
docker pull 843835551300.dkr.ecr.us-east-1.amazonaws.com/lrn_demo2:latest

# Stop any running container (if any)
echo "Stopping any existing containers..."
docker stop my-container || true
docker rm my-container || true

# Run the new container
echo "Running the Docker container..."
docker run -d -p 3000:3000 --name my-container 843835551300.dkr.ecr.us-east-1.amazonaws.com/lrn_demo2:latest
