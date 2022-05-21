#!/bin/sh

set -e

BUILD_DIR=images
CHECKSUM_FILE_FS="$(find ${BUILD_DIR} -iname *.fs.cksum)"
CHECKSUM_FILE_IMG="$(find ${BUILD_DIR} -iname *.img.cksum)"
SIGNATURE_KEYFILE=~/.signify/github.sec

PRIVATE_KEY=$(pass keys/signify/github) 
echo "${PRIVATE_KEY}" | signify -S -s ${SIGNATURE_KEYFILE} -m ${CHECKSUM_FILE_FS}
echo "${PRIVATE_KEY}" | signify -S -s ${SIGNATURE_KEYFILE} -m ${CHECKSUM_FILE_IMG}
gh-upload-assets -o soerenschneider -r openbsd-resflash-releases -f ~/.gh-token ${BUILD_DIR}
