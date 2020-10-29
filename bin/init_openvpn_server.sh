#!/bin/bash

docker-compose run --rm openvpn ovpn_genconfig -u udp://vpn.sfcoding.com && \
docker-compose run --rm openvpn ovpn_initpki
