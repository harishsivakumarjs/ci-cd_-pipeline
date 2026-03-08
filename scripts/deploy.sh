#!/bin/bash
set -e

cd /home/ubuntu/app

echo "Logging into ECR"

aws ecr get-login-password --region ap-south-2 \
| docker login --username AWS --password-stdin 331301815990.dkr.ecr.ap-south-2.amazonaws.com

echo "Stopping old containers"

docker compose down

echo "Pulling latest image"

docker compose pull

echo "Starting containers"

docker compose up -d

echo "Cleaning old images"

docker image prune -f
