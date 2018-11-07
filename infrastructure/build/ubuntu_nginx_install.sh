#!/bin/bash
# this script uses apt-get to install nginx
# assumes that working directory is /infrastructure/build
# TODO MAKE CHECKS
# saving for later:  systemctl status nginx.service

VIRTUAL_HOST_FILE_PATH='./nginx_superfluous_hosts_file'
SITES_PATH='/etc/nginx/sites-enabled/'

printf "updating...\n"
sudo apt-get -y update

printf "installing...\n"
sudo apt-get install -y nginx

printf "updating virtual host file...\n"
cp ${VIRTUAL_HOST_FILE_PATH} 

printf "restarting nginx...\n"
sudo systemctl restart nginx

printf "installation and preparation for superfluous complete...\n"