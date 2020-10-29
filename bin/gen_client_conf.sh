#!/bin/bash
# Usage: bin/gen_client_conf.sh clientname 192.168.254.XXX

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 [clientname] [assigned ip]"
    exit 1
fi

CLIENTNAME=$1  # TODO: read from argv[1]
STATIC_IP=$2    # MUST be 10.66.77.XXX and XXX not 0 or 255

# Search for this IP in existing files
grep -rni "$STATIC_IP" data/ccd/
retVal=$?
if [ $retVal -eq 0 ]; then
  echo The assigned IP is already in use, try another one.
  exit 1
fi

docker-compose run --rm openvpn easyrsa build-client-full $CLIENTNAME nopass

docker-compose run --rm openvpn ovpn_getclient $CLIENTNAME > client_files/$CLIENTNAME.ovpn

docker-compose run --rm openvpn bash -c "echo 'ifconfig-push $STATIC_IP 255.255.255.0' > /etc/openvpn/ccd/$CLIENTNAME"

# Fix config to use external port number
sed -i 's/1194/51194/g' ./client_files/$CLIENTNAME.ovpn
