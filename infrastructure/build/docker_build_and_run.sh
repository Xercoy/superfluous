#!/bin/bash

APP_NAME="superfluous-app"
DOCKERFILE_PATH=$1 # allow this path to be set as an arg
SERVER_PATH=$2 # path where the server code is
BIN_FULL_PATH="./bin/superfluous"
DOCKERFILE_PORT=4000
CONTAINER_PORT=8080

# assume that you're running in same dir that this script is in
if [ "${DOCKERFILE_PATH}" == "" ]
then
    DOCKERFILE_PATH='../docker/Dockerfile'
fi

if [ "${SERVER_PATH}" == "" ]
then
    SERVER_PATH="../../server/*.go"
fi

printf "building app binary...\n"
CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o ${BIN_FULL_PATH} ${SERVER_PATH}

printf "building docker image...\n"
docker build -f ${DOCKERFILE_PATH} -t ${APP_NAME} .

printf "running docker image, using host network..."
docker run --rm -d --network host --name ${APP_NAME} ${APP_NAME}