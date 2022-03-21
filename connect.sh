#!/usr/bin/env sh

checkInstall() {

    ok() {
        echo "\e[0;1;32m✓\e[0m ${@}"
    }

    throwError() {
        echo "\e[0;1;31m✗\e[0m ${@}"
        exit 1
    }
    
    which openvpn > /dev/null && {
        ok "OpenVPN installed.."
    } || {
        [ ! -f '/etc/issue' ] && {
            throwError "Cannot resolve OpenVPN dependency.."
        }

        execUbuntuInstaller() {
            sudo apt install apt-transport-https \
            || throwError "APT-transport-https failed"

            sudo wget https://swupdate.openvpn.net/repos/openvpn-repo-pkg-key.pub \
            || throwError "Cannot download pkg key"

            sudo apt-key add openvpn-repo-pkg-key.pub \
            || throwError "Cannot add pkg key"

            sudo wget -O /etc/apt/sources.list.d/openvpn3.list https://swupdate.openvpn.net/community/openvpn3/repos/openvpn3-focal.list \
            || throwError "Cannot add to apt sources list"

            sudo apt update \
            || throwError "Cannot update apt tree"

            sudo apt install openvpn3 \
            || throwError "Cannot install OpenVPN3"
        }

        execArchInstaller() {
            which yay && {
                sudo yay -S openvpn
            } || which pacman && {
                sudo pacman -S openvpn
            } || {
                throwError "Yay or Pacman not found"
            }
        }

        execFedoraInstaller() {
            sudo yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm \
            || throwError  "Cannot install OpenVPN3"

            sudo ARCH=$(/bin/arch)
            sudo subscription-manager repos --enable "codeready-builder-for-rhel-8-${ARCH}-rpms" \
            || throwError "Cannot enable repository arch"

            sudo dnf config-manager --set-enabled PowerTools \
            || throwError "Cannot enable PowerTools"

            sudo yum install yum-plugin-copr \
            || throwError "Cannot install COPR module"

            sudo yum copr enable dsommers/openvpn3 \
            || throwError "Cannot enable OpenVPN3 COPR repository"

            sudo yum install openvpn3-client \
            || throwError "Cannot install OpenVPN3"
        }

        for each in \
            'Ubuntu:ubuntu|mint|knoppix|deepin|bodhi' \
            'Arch:arch|garuda|manjaro|arco|chakra|endeavour|hyperbola|instant|kaos|parabola|reborn|ubos|snal' \
            'Fedora:fedora|redhat|centos|scientific'
        do  distro=$(echo "$each" | awk -F':' '{print($1)}')
            search=$(echo "$each" | awk -F':' '{print($2)}')
            grep -qEi "${search}" '/etc/issue' && {
                exec${distro}Installer && {
                    ok "OpenVPN client installed."
                } || {
                    throwError "Cannot install using system packet managers. Please install OpenVPN manually before continue."
                }
            }
        done
    }

    [ -f ~/.profile.ovpn ] && {
        ok "OpenVPN profile found."
    } || {
        echo "Download your .ovpn file from your VPN provider then save it on ~/.profile.ovpn"
        exit 1
    }

    [ -f ~/.profile.secret ] && {
        ok "OpenVPN secrets found."
    } || {
        echo -n "Enter VPN username..: "
        read -r username

        [ -z "${username}" ] && exit 0

        echo -n "Enter VPN password..: "
        read -r password

        echo "${username}\n${password}" > ~/.profile.secret
    }

    groups | grep -q "\<sudo\>" &> /dev/null && {
        ok "User is sudoer."
    } || {
        echo "You may need to be on sudoers list. Well, we'll try anyway.."
    }
}


checkInstall && {
    ok "Everything is properly configurated.. Executing OpenVPN"
    sudo -- bash -c "
        echo \"nameserver 1.1.1.1\" > /etc/resolv.conf &&
        openvpn \
            --config         \"${HOME}/.profile.ovpn\" \
            --auth-user-pass \"${HOME}/.profile.secret\"
    "
}