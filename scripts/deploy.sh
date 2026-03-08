#!/bin/bash

set -e

cd /home/ubuntu/app

echo "Reading image definition"

IMAGE_URI=$(cat /opt/codedeploy-agent/deployment-root/deployment-*/imagedefinitions.json | jq -r '.[0].imageUri')
IMAGE_TAG=$(echo $IMAGE_URI | cut -d ":" -f2)

export IMAGE_TAG=$IMAGE_TAG

echo "Logging into ECR"

aws ecr get-login-password --region ap-south-2 \
| docker login --username AWS --password-stdin 331301815990.dkr.ecr.ap-south-2.amazonaws.com

echo "Stopping old containers"

docker compose down

echo "Pulling new image"

docker compose pull

echo "Starting containers"

docker compose up -d

echo "Cleaning old images"

docker image prune -f
