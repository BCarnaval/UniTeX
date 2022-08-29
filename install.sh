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

build_directory () {
    echo -e "${GREEN}[@] Installing ${WHITE} ${PROJ} ${GREEN}..."
    if [[ -d "${DESTINATION}"/UniTeX ]]; then
        # Updating directories
        sudo rm -rf ${DESTINATION}/${PROJ}
        sudo mkdir -p ${DESTINATION}/${PROJ}
    else
        sudo mkdir -p ${DESTINATION}/${PROJ}
    fi
}

fill_directory () {
    sudo cp -r ${CURRENT_DIR}/unitex.sh ${DESTINATION}/${PROJ}
    sudo cp -r ${CURRENT_DIR}/install.sh ${DESTINATION}/${PROJ}
    sudo cp -r ${CURRENT_DIR}/uninstall.sh ${DESTINATION}/${PROJ}
    sudo cp -r ${CURRENT_DIR}/man_page.1 ${DESTINATION}/${PROJ}

    # Make scripts executable
    sudo chmod +x ${DESTINATION}/${PROJ}/unitex.sh
    sudo chmod +x ${DESTINATION}/${PROJ}/uninstall.sh

    # Create symlink
    if [[ -L /usr/local/bin/unitex ]]; then
        sudo rm /usr/local/bin/unitex
        sudo ln -s ${DESTINATION}/${PROJ}/unitex.sh /usr/local/bin/unitex
    else
        sudo ln -s ${DESTINATION}/${PROJ}/unitex.sh /usr/local/bin/unitex
    fi
    echo -e "${GREEN}[@] ${WHITE} ${PROJ} ${GREEN} Installed successfully:${WHITE} Execute 'unitex' to verify installation."
}

main () {
    build_directory
    fill_directory
}

main
