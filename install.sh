#!/usr/bin/env bash

# Colors used in terminal messages
RED="$(printf '\033[31m')"
GREEN="$(printf '\033[32m')"
ORANGE="$(printf '\033[33m')"
CYAN="$(printf '\033[36m')"
WHITE="$(printf '\033[37m')"

# Paths
PROJ=UniTeX
CURRENT_DIR=$( pwd )
DESTINATION=/usr/local/share
LINK_DIR=/usr/local/bin/unitex

build_directory () {
    echo -e "${GREEN}[@] Installing ${WHITE} ${PROJ} ${GREEN}..."
    if [[ -d "${DESTINATION}"/UniTeX ]]; then

        # Updating directories
        echo -e "${GREEN}[@] Wiping old version if any inside ${WHITE}${DESTINATION}${GREEN}."
        sudo rm -rf ${DESTINATION}/${PROJ}

        echo -e "${GREEN}[@] Building new dirs inside ${WHITE}${DESTINATION}${GREEN}."
        sudo mkdir -p ${DESTINATION}/${PROJ}
    else
        echo -e "${GREEN}[@] Building dirs inside ${WHITE}"
        sudo mkdir -p ${DESTINATION}/${PROJ}
    fi
}

fill_directory () {
    echo -e "${GREEN}[@] Filling dirs with shell scripts..."
    sudo cp -r ${CURRENT_DIR}/unitex.sh ${DESTINATION}/${PROJ}
    sudo cp -r ${CURRENT_DIR}/install.sh ${DESTINATION}/${PROJ}
    sudo cp -r ${CURRENT_DIR}/uninstall.sh ${DESTINATION}/${PROJ}
    sudo cp -r ${CURRENT_DIR}/man_page.1 ${DESTINATION}/${PROJ}

    # Make scripts executable
    sudo chmod +x ${DESTINATION}/${PROJ}/unitex.sh
    sudo chmod +x ${DESTINATION}/${PROJ}/uninstall.sh

    # Create symlink
    echo -e "${GREEN}[@] Updating symlinks from ${WHITE}${LINK_DIR}${GREEN}."
    if [[ -L ${LINK_DIR} ]]; then
        sudo rm ${LINK_DIR}
        sudo ln -s ${DESTINATION}/${PROJ}/unitex.sh ${LINK_DIR}
    else
        sudo ln -s ${DESTINATION}/${PROJ}/unitex.sh ${LINK_DIR}
    fi
    echo -e "${GREEN}[@] ${WHITE}${PROJ}${GREEN} Installed successfully:${WHITE} Execute 'unitex' to verify installation."
}

main () {
    build_directory
    fill_directory
}

main
