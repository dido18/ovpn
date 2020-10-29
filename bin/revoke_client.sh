#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 [clientname]"
    exit 1
fi

CLIENTNAME=$1

docker-compose run --rm openvpn ovpn_revokeclient $CLIENTNAME remove

rm -f "client_files/$CLIENTNAME.ovpn"
