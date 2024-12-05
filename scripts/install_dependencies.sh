#!/bin/bash
echo "Installing Docker..."
yum update -y
yum install -y docker
service docker start
chkconfig docker on

# Optional: Install AWS CLI if not already installed
yum install -y aws-cli
