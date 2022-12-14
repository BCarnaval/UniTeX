#!/usr/bin/env bash

RED="$(printf '\033[31m')"
CYAN="$(printf '\033[36m')"
GREEN="$(printf '\033[32m')"
WHITE="$(printf '\033[37m')"
ORANGE="$(printf '\033[33m')"

PROJ=UniTeX
CONFIG=~/.config/latexmk
DESTINATION=/usr/local/share

reset_terminal () {
    tput sgr0
}

rm_config () {
    echo -e "${WHITE}--------------------------\n"
    echo -e "${ORANGE}[!] Uninstalling ${WHITE}configs (commands, pdf viewer, etc.) ${ORANGE}..."

    # remove zathura from latexmk config file
    sed "/\$ pdf_previewer = 'zathura';/d" ${CONFIG}/latexmkrc > ${CONFIG}/latexmkrc
}

rm_directory () {
    echo -e "${WHITE}\n--------------------------\n"
    echo -e "${ORANGE}[!] Uninstalling ${WHITE}${PROJ}${ORANGE}..."

    if [[ -d ${DESTINATION}/${PROJ} ]]; then
        echo -e "${ORANGE}[!] Removing dirs from ${WHITE}${DESTINATION}${ORANGE}."
        sudo rm -rf ${DESTINATION}/${PROJ}
    fi
}

rm_symlink() {
    echo -e "${WHITE}\n--------------------------\n"

    if [[ -L /usr/local/bin/unitex ]]; then
        echo -e "${ORANGE}[!] Destroying ${WHITE}'unitex' ${ORANGE}symlink."
        sudo rm /usr/local/bin/unitex
    fi

    echo -e "${GREEN}[@] ${WHITE}${PROJ}${GREEN} Uninstalled successfully${WHITE}."
    echo -e "${WHITE}\n--------------------------"
}

main () {
    rm_config
    rm_directory
    rm_symlink
    reset_terminal
}

main
