#!/bin/bash

# The source of this script is based on this article:
# https://www.digitalocean.com/community/tutorials/how-to-install-and-use-docker-on-ubuntu-18-04

# check to see if docker is already installed, save the output
# ideally we'd like to see it checking that docker is within the list of
# services + is enabled, but this is alright for now.
# todo features: to uninstall, rollback, reverse changes on failure, upgrade if exists
DOCKER_IS_INSTALLED=$(sudo systemctl status docker >/dev/null 2>/dev/null; echo $?)

# list services: systemctl list-unit-files

if [ "${DOCKER_IS_INSTALLED}" == 0 ]
then
    echo "Docker is already installed. Exiting..."
    exit 0
else
    # update existing set of packages
    sudo apt update

    # install packages to let apt use packages over HTTPS
    sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

    # add GPG key for the official Docker repository to the system
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

    # add Docker to apt sources
    sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu bionic stable"

    # update package database with Docker packages from the newly added repo
    sudo apt update

    # ensure Docker is installed from the Docker repo and not the default Ubuntu one
    apt-cache policy docker-ce

    # install docker
    sudo apt install -y docker-ce

    # run status check to ensure it's running
    # TODO: validate this step, reduce redundancy...
    DOCKER_IS_INSTALLED=$(sudo systemctl status docker >/dev/null 2>/dev/null; echo $?)
    if [ DOCKER_IS_INSTALLED == "0" ]
    then
        echo "Docker is installed and running..."
    else
        echo "Docker installation unsucessful..."
	exit 1
    fi
fi