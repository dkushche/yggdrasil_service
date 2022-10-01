# Yggdrasil Service Image

[Yggdrasil Network](https://github.com/yggdrasil-network/yggdrasil-go) docker image. Container reads and stores configs in `/mnt/storage` directory. You could manipulate these files if mount the directory on the host.

_Docker compose entry example:_

```yml
yggdrasil:
  build: .
  image: yggdrasil_gateway_image
  container_name: yggdrasil_gateway_container
  cap_add:
  - NET_ADMIN
  - DAC_OVERRIDE
  sysctls:
  - net.ipv6.conf.all.disable_ipv6=0
  devices:
  - "/dev/net/tun:/dev/net/tun"
  volumes:
  - type: bind
    source: ./storage/yggdrasil
    target: /mnt/storage
```
