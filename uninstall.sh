#!/usr/bin/env bash

# Colors used in terminal messages
RED="$(printf '\033[31m')"
GREEN="$(printf '\033[32m')"
ORANGE="$(printf '\033[33m')"
CYAN="$(printf '\033[36m')"
WHITE="$(printf '\033[37m')"

PROJ=UniTeX
DESTINATION=/usr/local/share

rm_directory () {
    echo -e "${ORANGE}[!] Uninstalling ${WHITE} ${PROJ} ${ORANGE}..."
    if [[ -d ${DESTINATION}/${PROJ} ]]; then
        sudo rm -rf ${DESTINATION}/${PROJ}
    fi
}

rm_symlink() {
    if [[ -L /usr/local/bin/unitex ]]; then
        sudo rm /usr/local/bin/unitex
    fi
    echo -e "${GREEN}[@] ${WHITE} ${PROJ} ${GREEN} Uninstalled successfully."
}

main () {
    rm_directory
    rm_symlink
}

main
