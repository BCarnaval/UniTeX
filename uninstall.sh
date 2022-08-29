#!/usr/bin/env bash

RED="$(printf '\033[31m')"
CYAN="$(printf '\033[36m')"
GREEN="$(printf '\033[32m')"
WHITE="$(printf '\033[37m')"
ORANGE="$(printf '\033[33m')"

PROJ=UniTeX
DESTINATION=/usr/local/share

rm_directory () {
echo -e "${ORANGE}[!] Uninstalling ${WHITE}${PROJ}${ORANGE}..."
    if [[ -d ${DESTINATION}/${PROJ} ]]; then
        echo -e "${ORANGE}[!] Removing dirs from ${WHITE}${DESTINATION}${ORANGE}."
        sudo rm -rf ${DESTINATION}/${PROJ}
    fi
}

rm_symlink() {
    if [[ -L /usr/local/bin/unitex ]]; then
        echo -e "${ORANGE}[!] Destroying symlinks."
        sudo rm /usr/local/bin/unitex
    fi
    echo -e "${GREEN}[@] ${WHITE}${PROJ}${GREEN} Uninstalled successfully."
}

main () {
    rm_directory
    rm_symlink
}

main
