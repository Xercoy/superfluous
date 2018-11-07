#!/bin/bash

# grab these values as arguments, if not, set defaults
REPO_DESTINATION=$1
DOCKERFILE_PATH=$2
NGINX_HOSTS_PATH=$3

# TODO: list argument options + check for them

# default repo destination is the current directory
if [ "${REPO_DESTINATION}" == "" ] 
then 
    REPO_DESTINTION='~/'
fi

# being able to provide paths to these to files makes it such that the entire project
# can be run with just the scripts... caveat: if the paths or names of these configs
# break, this script breaks

if [ "${DOCKERFILE_PATH}" == "" ]
then 
    DOCKERFILE_PATH="${REPO_DESTINATION}/infrastructure/docker/Dockerfile"
fi

if [ "${NGINX_HOSTS_PATH}" == "" ]
then
    NGINX_HOSTS_PATH"${REPO_DESTINATION}/infrastructure/build/nginx_superfluous_hosts_file"
fi 

# install Docker
printf "1) installing Docker...\n"
./ubuntu_docker_install.sh

# install Go
printf "2) installing Go...\n"
./ubuntu_install_go.sh

# clone the repo
printf "3) cloning repo...\n"
./ubuntu_clone_repo.sh ${REPO_DESTINATION}

# install Nginx
printf "4) installing Nginx and preparing virtual host...\n"
./ubuntu_nginx_install.sh ${NGINX_HOSTS_PATH}

# build and run the container
printf "5) building and running container...\n"
./docker_build_and_run.sh ${DOCKERFILE_PATH}

