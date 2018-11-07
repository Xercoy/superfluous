#!/bin/bash

# show commands as they're executed; great for debugging...
set -e 

# allow destination of clone as first argument
CLONE_DESTINATION=$1
REPO_URL='https://github.com/xercoy/superfluous'

# if no destination provided, repo is cloned in current dir
if [ "${CLONE_DESTINATION}" == "" ]
then 
    CLONE_DESTINATION = "./"
fi

echo "Cloning repository..."

# clones git repo in current location
git clone ${REPO_URL} ${CLONE_DESTINATION}

