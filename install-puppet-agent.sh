#! /usr/bin/env bash

function do_install() {
  echo "Start of ${FUNCNAME[0]}"
  URL="https://raw.githubusercontent.com/Xenion1987/install-puppet-sh/main/install_puppet_${PUPPET_AGENT_VERSION}_agent.sh"
  if (curl -sLo - "${URL}" || wget --quiet -O - "${URL}") | sh; then
    systemctl enable --now puppet
  else
    echo "Could not install puppet."
    exit 255
  fi
  echo "End of ${FUNCNAME[0]}"
}
function main() {
  echo "Start of ${FUNCNAME[0]}"
  if [[ -n "${1}" ]]; then
    case "${1}" in
    5 | 6 | 7 | 8)
      PUPPET_AGENT_VERSION=${1:-"6"}
      do_install
      ;;
    *)
      echo -e "\nMissing or wrong option. Need one of 5, 6, 7, 8"
      exit 244
      ;;
    esac
  else
    echo -e "\nMissing or wrong option. Need one of 5, 6, 7, 8"
    exit 244
  fi
  echo "End of ${FUNCNAME[0]}"
}

main "$@"
