#!/usr/bin/env bash

RED="$(printf '\033[31m')"
CYAN="$(printf '\033[36m')"
GREEN="$(printf '\033[32m')"
WHITE="$(printf '\033[37m')"
ORANGE="$(printf '\033[33m')"

# Paths
PROJ=UniTeX
OS=$(uname)
CURRENT_DIR=$( pwd )
DESTINATION=/usr/local/share
LINK_DIR=/usr/local/bin/unitex
MAN_DIR=/usr/local/share/man/
TAG=$(cat version.txt)

# Turn on extended globbing in bash shell
shopt -s extglob 

reset_terminal () {
    tput -x init
}

build_directory () {
    echo -e "${GREEN}[@] Installing ${WHITE}${PROJ}${GREEN}..."
    if [[ -d "${DESTINATION}"/UniTeX ]]; then

        # Updating directories
        echo -e "${GREEN}[@] Wiping old version if any inside ${WHITE}${DESTINATION}${GREEN}."
        sudo rm -rf ${DESTINATION}/${PROJ}
        
        if [[ "${OS}" = "Darwin" ]]; then
            sudo rm ${MAN_DIR}/man1/unitex.1
        else
            sudo rm ${MAN_DIR}/unitex.1
        fi

        echo -e "${GREEN}[@] Building new dirs inside ${WHITE}${DESTINATION}${GREEN}."
        sudo mkdir -p ${DESTINATION}/${PROJ}
    else
        echo -e "${GREEN}[@] Building dirs inside ${WHITE}${DESTINATION}${GREEN}."
        sudo mkdir -p ${DESTINATION}/${PROJ}
    fi
}

fill_directory () {
    echo -e "${GREEN}[@] Filling dirs with templates..."
    sudo cp -r ${CURRENT_DIR}/!(*.md|*.1) ${DESTINATION}/${PROJ}
    sudo cp ${CURRENT_DIR}/unitex.1 ${MAN_DIR}/

    if [[ "${OS}" = "Darwin" ]]; then
        sudo cp ${CURRENT_DIR}/unitex.1 ${MAN_DIR}/man1/unitex.1
    else
        sudo cp ${CURRENT_DIR}/unitex.1 ${MAN_DIR}/unitex.1
    fi

    # Make scripts executable
    sudo chmod +x ${DESTINATION}/${PROJ}/unitex.sh
    sudo chmod +x ${DESTINATION}/${PROJ}/uninstall.sh

    # Version control
    echo "${TAG%-*}" | sudo tee ${DESTINATION}/${PROJ}/version.txt &> /dev/null

    # Create symlink
    echo -e "${GREEN}[@] Updating symlink from ${WHITE}${LINK_DIR}${GREEN}."
    if [[ -L ${LINK_DIR} ]]; then
        sudo rm ${LINK_DIR}
        sudo ln -s ${DESTINATION}/${PROJ}/unitex.sh ${LINK_DIR}
    else
        sudo ln -s ${DESTINATION}/${PROJ}/unitex.sh ${LINK_DIR}
    fi
    echo -e "${GREEN}[@] ${WHITE}${PROJ}${GREEN} Installed successfully:${WHITE} Execute 'unitex' to verify installation."
}

main () {
    echo -e "${WHITE}\n--------------------------\n"
    build_directory
    echo -e "${WHITE}\n--------------------------\n"
    fill_directory
    reset_terminal
}

main
