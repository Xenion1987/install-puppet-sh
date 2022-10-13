#! /usr/bin/env bash

function do_install(){
    URL="https://raw.githubusercontent.com/Xenion1987/install-puppet-sh/main/install_puppet_${PUPPET_AGENT_VERSION}_agent.sh";
    if (curl -sLo - "${URL}" || wget --quiet -O - "${URL}") | sh; then
        configure
        systemctl enable --now puppet;
    else
        echo "Could not install puppet."
        exit 255 
    fi
}

function do_configure(){
    PUPPET_CONFIG_PATH="/etc/puppetlabs/puppet/puppet.conf"
    cat << ENDOFCONFIG >> "${PUPPET_CONFIG_PATH}"
### ADDED BY PUPPET-INSTALL-SCRIPT ###
server = puppet.mcs.dogado.net
environment = useronly
splay = true
runinterval = 30m
### ### ### ### ### ### ### ### ### ###

ENDOFCONFIG
}

function main() {
    if [[ -n "${1}" ]]; then
        case "${1}" in
        5|6|7)
            PUPPET_AGENT_VERSION=${1}
            do_install
            do_configure
            ;;
        *)
            echo -e "\nMissing or wrong option. Need one of 5, 6, 7"
            exit 244
            ;;
        esac
    else
        echo -e "\nMissing or wrong option. Need one of 5, 6, 7"
        exit 244
    fi
}

main "$@"
