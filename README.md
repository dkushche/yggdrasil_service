# Yggdrasil Service Image

[Yggdrasil Network](https://github.com/yggdrasil-network/yggdrasil-go) docker image. Container reads and stores configs in `/mnt/storage` directory. You could manipulate these files if mount the directory on the host. __Important__: [Peers list](https://github.com/yggdrasil-network/public-peers) help you to create `peers.json`. An example of peers.json for Ukrainian peers you could see in `.roothazardlab/yggdrasil-peers-conf.yaml`.

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
