#!/bin/bash

# grab these values as arguments, if not, set defaults
REPO_DESTINATION=$1
DOCKERFILE_PATH=$2  # path to docker file
NGINX_HOSTS_PATH=$3 # path to nginx config
SERVER_CODE_PATH=$4 # path to .go files for server
BUILD_SCRIPTS_PATH=$5
APP_NAME="superfluous-app"

# TODO: list argument options + check for them

# default repo destination is the current directory
if [ "${REPO_DESTINATION}" == "" ]
then
    REPO_DESTINATION='.'
fi

if [ "${DOCKERFILE_PATH}" == "" ]
then
    DOCKERFILE_PATH="${REPO_DESTINATION}/infrastructure/docker/Dockerfile"
fi

if [ "${NGINX_HOSTS_PATH}" == "" ]
then
    NGINX_HOSTS_PATH="${REPO_DESTINATION}/infrastructure/build/nginx_superfluous_hosts_file"
fi

if [ "${SERVER_CODE_PATH}" == "" ]
then
    SERVER_CODE_PATH="./server"
fi

# install Docker
printf "1) installing Docker...\n"
${REPO_DESTINATION}/infrastructure/build/ubuntu_docker_install.sh

# install Go
printf "2) installing Go...\n"
${REPO_DESTINATION}/infrastructure/build/ubuntu_install_go.sh

# TODO: treat this as an arg instead of assuming
source /"${USER}"/.profile

# clone the repo
# printf "3) cloning repo...\n"
#./ubuntu_clone_repo.sh ${REPO_DESTINATION}

# install Nginx
printf "4) installing Nginx and preparing virtual host...\n"
${REPO_DESTINATION}/infrastructure/build/ubuntu_nginx_install.sh ${NGINX_HOSTS_PATH}

printf "5) building app binary...\n"
CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o ./bin/superfluous ${SERVER_CODE_PATH}

printf "6) building docker image...\n"
docker build -f ${DOCKERFILE_PATH} -t ${APP_NAME} .

#printf "7) running docker image, using host network...\n"
docker run --rm -d --network host --name ${APP_NAME} ${APP_NAME}