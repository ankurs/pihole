#!/bin/bash

# https://github.com/pi-hole/docker-pi-hole/blob/master/README.md

source ./secret.sh

podman stop pihole
podman rm pihole
podman run -d \
    --name pihole \
    -e TZ="Asia/Singapore" \
    -e WEBPASSWORD="$PIHOLE_PASSWORD" \
    --dns=127.0.0.1 --dns=1.1.1.1 \
    -p 443:443 \
    -p 80:80 \
    -p 53:53/tcp -p 53:53/udp \
    -v "$(pwd)/etc-pihole/:/etc/pihole/:z" \
    -v "$(pwd)/etc-dnsmasq.d/:/etc/dnsmasq.d/:z" \
    --restart=always \
    pihole/pihole:beta-v5.0
podman logs -f pihole
