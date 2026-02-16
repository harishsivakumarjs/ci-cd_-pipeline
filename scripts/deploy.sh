#!/bin/bash

cd /home/ubuntu/app

IMAGE_URI=$(cat /opt/codedeploy-agent/deployment-root/deployment-*/imagedefinitions.json | jq -r '.[0].imageUri')
IMAGE_TAG=$(echo $IMAGE_URI | cut -d ":" -f2)

export IMAGE_TAG=$IMAGE_TAG

aws ecr get-login-password --region ap-south-1 | docker login --username AWS --password-stdin <ACCOUNT_ID>.dkr.ecr.ap-south-1.amazonaws.com

docker compose down
docker compose pull
docker compose up -d

docker image prune -f