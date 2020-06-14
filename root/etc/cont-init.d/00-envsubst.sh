#!/usr/bin/with-contenv bash

set -eu
set -o pipefail

if [ "$PATH_PREFIX" = "/" ]
then
  export SOCKET_PREFIX=""
else
  export SOCKET_PREFIX="$PATH_PREFIX"
fi

TEMP="$(envsubst '${PATH_PREFIX},${SOCKET_PREFIX}' < /etc/nginx/nginx.conf)"
echo "$TEMP" > /etc/nginx/nginx.conf

export PAGE_PREFIX="${SOCKET_PREFIX:1}/"
TEMP="$(envsubst '${PAGE_PREFIX},${PAGE_TITLE},${RECON_DELAY},${VNC_RESIZE}' < /novnc/index.html)"
echo "$TEMP" > /novnc/index.html

TEMP="$(envsubst '${VIRTBR_NAME},${LXDBR_NAME}' < /vmrc/br0.xml)"
echo "$TEMP" > /vmrc/br0.xml

TEMP="$(envsubst '${LXDBR_NAME}' < /vmrc/lxd-init.yml)"
echo "$TEMP" > /vmrc/lxd-init.yml
