#!/usr/bin/dumb-init /bin/bash

set -euxo pipefail

conf_file=/mnt/storage/yggdrasil.conf

if [ ! -f ${conf_file} ]; then
    yggdrasil -genconf -json > ${conf_file}
    python3 /configurator.py
fi

if [ "$LOADBALANCER_IP" != "None" ]; then
    apk add socat

    socat TCP6-LISTEN:80,fork TCP4:${LOADBALANCER_IP}:80 &
    socat TCP6-LISTEN:443,fork TCP4:${LOADBALANCER_IP}:443 &
fi

exec yggdrasil -useconffile ${conf_file}
