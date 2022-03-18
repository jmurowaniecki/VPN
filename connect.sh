#!/usr/bin/env sh

which openvpn > /dev/null || {
    echo "Please install openvpn before continue."
    exit 1
}

[ ! -f ~/.profile.ovpn ] && {
    echo "Download your .ovpn file from your VPN provider then save it on ~/.profile.ovpn"
    exit 1
}

[ ! -f ~/.profile.secret ] && {
    echo -n "Enter VPN username..: "
    read -r username

    [ -z "${username}" ] && exit 0

    echo -n "Enter VPN password..: "
    read -r password

    echo "${username}\n${password}" > ~/.profile.secret
}

groups | grep -q "\<sudo\>" &> /dev/null || {
    echo "You may need to be on sudoers list. Well, we'll try anyway.."
}

sudo -- bash -c "
    echo \"nameserver 1.1.1.1\" > /etc/resolv.conf &&
    openvpn \
        --config         \"${HOME}/.profile.ovpn\" \
        --auth-user-pass \"${HOME}/.profile.secret\"
"