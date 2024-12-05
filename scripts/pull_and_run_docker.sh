#!/bin/bash
# Ensure Docker is running
service docker start

# Log in to Amazon ECR
echo "Logging in to Amazon ECR..."
$(aws ecr get-login --no-include-email --region us-east-1)

# Pull the Docker image from ECR
echo "Pulling Docker image from ECR..."
docker pull 843835551300.dkr.ecr.us-east-1.amazonaws.com/lrn_demo2:latest

# Stop any running container (if any)
echo "Stopping any existing containers..."
docker stop my-container || true
docker rm my-container || true

# Run the new container
echo "Running the Docker container..."
docker run -d -p 80:80 --name my-container843835551300.dkr.ecr.us-east-1.amazonaws.com/lrn_demo2:latest
