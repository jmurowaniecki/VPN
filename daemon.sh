#!/usr/bin/env sh

sudo -- bash -c "
    echo \"nameserver 1.1.1.1\" > /etc/resolv.conf &&
    openvpn \
        --config         \"${HOME}/.profile.ovpn\" \
        --auth-user-pass \"${HOME}/.profile.secret\"
"