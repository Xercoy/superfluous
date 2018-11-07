#!/bin/bash

# install Docker
printf "1) installing Docker..."
./ubuntu_docker_install.sh

# install Go
printf "2) installing Go..."
./ubuntu_install_go.sh

# install Nginx
printf "3) installing Nginx and preparing virtual host..."
./ubuntu_nginx_install.sh

# clone the repo
printf "4) cloning repo..."
./ubuntu_clone_repo.sh

# build and run the container
printf "5) building and running container..."
./docker_build_and_run.sh

