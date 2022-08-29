#!/usr/bin/env bash

RED="$(printf '\033[31m')"
CYAN="$(printf '\033[36m')"
GREEN="$(printf '\033[32m')"
WHITE="$(printf '\033[37m')"
ORANGE="$(printf '\033[33m')"

# Paths
PROJ=UniTeX
CURRENT_DIR=$( pwd )
DESTINATION=/usr/local/share
MAN_DIR=/usr/local/share/man/man1
LINK_DIR=/usr/local/bin/unitex

# Turn on extended globbing in bash shell
shopt -s extglob 

build_directory () {
    echo -e "${GREEN}[@] Installing ${WHITE}${PROJ}${GREEN}..."
    if [[ -d "${DESTINATION}"/UniTeX ]]; then

        # Updating directories
        echo -e "${GREEN}[@] Wiping old version if any inside ${WHITE}${DESTINATION}${GREEN}."
        sudo rm -rf ${DESTINATION}/${PROJ}
        sudo rm ${MAN_DIR}/unitex.1

        echo -e "${GREEN}[@] Building new dirs inside ${WHITE}${DESTINATION}${GREEN}."
        sudo mkdir -p ${DESTINATION}/${PROJ}
    else
        echo -e "${GREEN}[@] Building dirs inside ${WHITE}"
        sudo mkdir -p ${DESTINATION}/${PROJ}
    fi
}

fill_directory () {
    echo -e "${GREEN}[@] Filling dirs with shell scripts..."
    sudo cp -r ${CURRENT_DIR}/!(*.md|*.1) ${DESTINATION}/${PROJ}
    sudo cp ${CURRENT_DIR}/unitex.1 ${MAN_DIR}/

    # Make scripts executable
    sudo chmod +x ${DESTINATION}/${PROJ}/unitex.sh
    sudo chmod +x ${DESTINATION}/${PROJ}/uninstall.sh

    # Version control
    sudo touch ${DESTINATION}/${PROJ}/version.txt
    echo "$(git describe)" | sudo tee -a ${DESTINATION}/${PROJ}/version.txt &> /dev/null

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