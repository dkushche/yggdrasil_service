#!/usr/bin/dumb-init /bin/bash

set -euxo pipefail

conf_file=/yggdrasil/yggdrasil.conf

if [ ! -f ${conf_file} ]; then
    yggdrasil -genconf -json > ${conf_file}
    python3 /yggdrasil/configurator.py
fi

exec yggdrasil -useconffile ${conf_file}
