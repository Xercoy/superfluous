#!/bin/bash

# grab these values as arguments, if not, set defaults
# REPO_DESTINATION=$1 
DOCKERFILE_PATH=$2  # path to focker file
NGINX_HOSTS_PATH=$3 # path to nginx config
SERVER_CODE_PATH=$4 # path to .go files for server

# TODO: list argument options + check for them

# default repo destination is the current directory
if [ "${REPO_DESTINATION}" == "" ]
then
    REPO_DESTINATION='.'
fi

if [ "${DOCKERFILE_PATH}" == "" ]
then
    DOCKERFILE_PATH="../docker/Dockerfile"
fi

if [ "${NGINX_HOSTS_PATH}" == "" ]
then
    NGINX_HOSTS_PATH="./nginx_superfluous_hosts_file"
fi

if [ "${SERVER_CODE_PATH}" == "" ]
then 
    SERVER_CODE_PATH="../server/*.go"
fi

# install Docker
printf "1) installing Docker...\n"
./ubuntu_docker_install.sh

# install Go
printf "2) installing Go...\n"
./ubuntu_install_go.sh

# clone the repo
# printf "3) cloning repo...\n"
#./ubuntu_clone_repo.sh ${REPO_DESTINATION}

# install Nginx
printf "4) installing Nginx and preparing virtual host...\n"
./ubuntu_nginx_install.sh ${NGINX_HOSTS_PATH}

# build and run the container
printf "5) building and running container...\n"
./docker_build_and_run.sh ${DOCKERFILE_PATH} ${SERVER_CODE_PATH}