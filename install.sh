#!/usr/bin/env bash

RED="$(printf '\033[31m')"
CYAN="$(printf '\033[36m')"
GREEN="$(printf '\033[32m')"
WHITE="$(printf '\033[37m')"
ORANGE="$(printf '\033[33m')"

PROJ=UniTeX
CURRENT_DIR=$( pwd )
TAG=$(git describe --tags)

DESTINATION=${INSTALL_DIR:-${1:-${HOME}/.local/share}}
LINK_DIR=${2:-${HOME}/.local/bin/unitex}

# DESTINATION=${HOME}/.local/share
# LINK_DIR=${HOME}/.local/bin/unitex

# Turn on extended globbing in bash shell
shopt -s extglob

reset_terminal () {
    tput sgr0
}

check_rsync () {
    if ! type rsync &> /dev/null; then
        echo -e "${WHITE}--------------------------\n"
        echo -e "${ORANGE}[!] Please install ${WHITE}rsync ${ORANGE}command on your system!"
        echo -e "${ORANGE}[!] For MacOS intallation, run ${WHITE}'brew install rsync'}."
        echo -e "${ORANGE}[!] For common Linux distribution, run ${WHITE}'apt-get install rsync'."
        echo -e "${GREEN} [@] Exiting..."
        exit 0
    fi
}

build_directory () {
    echo -e "${WHITE}\n--------------------------\n"
    echo -e "${GREEN}[@] Installing ${WHITE}${PROJ}${GREEN}..."

    if [[ -d "${DESTINATION}"/UniTeX ]]; then

        # Updating directories
        echo -e "${GREEN}[@] Wiping old version if any inside ${WHITE}${DESTINATION}${GREEN}."
        rm -rf ${DESTINATION}/${PROJ}

        echo -e "${GREEN}[@] Building new dirs inside ${WHITE}${DESTINATION}${GREEN}."
        mkdir -p ${DESTINATION}/${PROJ}
    else
        echo -e "${GREEN}[@] Building dirs inside ${WHITE}${DESTINATION}${GREEN}."
        mkdir -p ${DESTINATION}/${PROJ}
    fi
}

fill_directory () {
    echo -e "${WHITE}\n--------------------------\n"
    echo -e "${GREEN}[@] Filling dirs with templates..."

    rsync -a --exclude='*.md' --exclude='.*' ${CURRENT_DIR}/ ${DESTINATION}/${PROJ}

    # Make scripts executable
    chmod +x ${DESTINATION}/${PROJ}/unitex.sh
    chmod +x ${DESTINATION}/${PROJ}/uninstall.sh

    # Version control
    echo "${TAG}" | cut -d '-' -f 1 | tee ${DESTINATION}/${PROJ}/version.txt &> /dev/null

    # Create symlink
    echo -e "${GREEN}[@] Updating symlink from ${WHITE}${LINK_DIR}${GREEN}."
    if [[ -L ${LINK_DIR} ]]; then
        rm ${LINK_DIR}
        ln -s ${DESTINATION}/${PROJ}/unitex.sh ${LINK_DIR}
    else
        ln -s ${DESTINATION}/${PROJ}/unitex.sh ${LINK_DIR}
    fi

    echo -e "${GREEN}[@] ${WHITE}${PROJ}${GREEN} Installed successfully:${WHITE} Execute 'unitex -h' to verify installation."
    echo -e "${WHITE}\n--------------------------"
}

main () {
    check_rsync
    build_directory
    fill_directory
    reset_terminal
}

main "${@}"
