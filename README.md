# VPN 

OpenVPN settings

- CA Passphrase: ``
- CN ``

Subnet network of the VPN:
```
10.66.77.0/24
```

## Users
Each user must be created with a unique IP.

I order to know the already used IPS,  type the following command:

```
grep -o -e "10\.66\.77\.[0-9]*" data/ccd/* | cut -d: -f2 | sort | uniq 
```


Add a new user with `CLIENTNAME` and `IP`, where IP MUST be a free IP.

```
./bin/gen_client_conf.sh <CLIENTNAME> <IP>
```

Copy locally the `ovpen` created

```
scp root@REMOTEHOST:/root/letomec-vpn/client_files/<CLIENTNAME>.ovpn <local folder>
```

List all users with their IPS
```
grep -o -e "10\.66\.77\.[0-9]*" data/ccd/*

```

delete an user
```
$ bin/revoke_client.sh [CLIENTNAME]
```

# Connect with OpenVPN Client

Copy the ip in the `/etc/hosts`

``` 
195.201.224.239 YOUR_HOST
```

start open vpn 

```
sudo openvpn --config <CLIENTNAME>.ovpn
```# ovpn
