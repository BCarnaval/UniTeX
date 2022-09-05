#!/usr/bin/env bash

RED="$(printf '\033[31m')"
CYAN="$(printf '\033[36m')"
GREEN="$(printf '\033[32m')"
WHITE="$(printf '\033[37m')"
ORANGE="$(printf '\033[33m')"

OS=$(uname)
PROJ=UniTeX
DESTINATION=/usr/local/share
MAN_DIR=/usr/local/share/man

reset_terminal () {
    tput -x init
}

rm_directory () {
    echo -e "${ORANGE}[!] Uninstalling ${WHITE}${PROJ}${ORANGE}..."
    if [[ -d ${DESTINATION}/${PROJ} ]]; then
        echo -e "${ORANGE}[!] Removing dirs from ${WHITE}${DESTINATION}${ORANGE}."
        sudo rm -rf ${DESTINATION}/${PROJ}
    fi

    if [[ "${OS}" = "Darwin" ]]; then
        sudo rm ${MAN_DIR}/man1/unitex.1
    else
        sudo rm ${MAN_DIR}/unitex.1
    fi
}

rm_symlink() {
    if [[ -L /usr/local/bin/unitex ]]; then
        echo -e "${ORANGE}[!] Destroying ${WHITE}'unitex' ${ORANGE}symlink."
        sudo rm /usr/local/bin/unitex
    fi
    echo -e "${GREEN}[@] ${WHITE}${PROJ}${GREEN} Uninstalled successfully${WHITE}."
}

main () {
    echo -e "${WHITE}\n--------------------------\n"
    rm_directory
    echo -e "${WHITE}\n--------------------------\n"
    rm_symlink
    reset_terminal
}

main
