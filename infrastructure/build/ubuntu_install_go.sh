#!/bin/bash
# This script installs go 1.11.2 in /usr/local/ and updates ~/.profile
# with the updated PATH environment variable

set -e

PATH_EXPORT_SOURCE="/${USER}/.profile"
PATH_EXPORT='export PATH=$PATH:/usr/local/go/bin'
TMP_DIR='/tmp'
GO_URL='https://dl.google.com/go/go1.11.2.linux-amd64.tar.gz'
GO_BIN_NAME="gobin"
GO_DESTINATION_PATH='/usr/local/'
GO_BIN_PATH=${TMP_DIR}/${GO_BIN_NAME}

printf "downloading go binary..(1.11.2)\n"
wget  --directory-prefix ${TMP_DIR} ${GO_URL} -P ${TMP_DIR} -O /tmp/${GO_BIN_NAME}

printf "extracting tarball...\n"
tar -xvf ${GO_BIN_PATH} -C ${GO_DESTINATION_PATH} > /dev/null 2>&1 # all that stuff here at the end supresses output

printf "adding export clause ${PATH_EXPORT} to Go, remember to restart or source updated profile\n"
printf "basically > source ${PATH_EXPORT_SOURCE}"
echo ${PATH_EXPORT} >> ${PATH_EXPORT_SOURCE}

printf "cleaning up assets...\n"
rm ${GO_BIN_PATH}

printf "cleanup complete; remember to setup workspace...\n"