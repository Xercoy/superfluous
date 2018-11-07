#!/bin/bash

APP_NAME="superfluous-app"
DOCKERFILE_PATH="./infrastructure/docker/Dockerfile"
DOCKERFILE_PORT=4000
CONTAINER_PORT=8080

printf "building app binary...\n"
CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o ./bin/superfluous server/*.go

printf "building docker image...\n"
docker build -f ${DOCKERFILE_PATH} -t ${APP_NAME} .

printf "running docker image, using host network..."
docker run --rm -d --network host --name ${APP_NAME} ${APP_NAME}