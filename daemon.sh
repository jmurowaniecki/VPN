#!/usr/bin/env sh

sudo -- bash -c '
    echo "nameserver 1.1.1.1" > /etc/resolv.conf &&
    openvpn \
    	--config		/home/joaosantanna/.profile.ovpn \
    	--auth-user-pass	/home/joaosantanna/.profile.secret'
