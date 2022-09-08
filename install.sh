#!/usr/bin/env bash

RED="$(printf '\033[31m')"
CYAN="$(printf '\033[36m')"
GREEN="$(printf '\033[32m')"
WHITE="$(printf '\033[37m')"
ORANGE="$(printf '\033[33m')"

OS=$(uname)
PROJ=UniTeX
CURRENT_DIR=$( pwd )
CONFIG=~/.config/latexmk
TAG=$(git describe --tags)
DESTINATION=/usr/local/share
LINK_DIR=/usr/local/bin/unitex
MAN_DIR=/usr/local/share/man

# Turn on extended globbing in bash shell
shopt -s extglob 

reset_terminal () {
    tput sgr0
}

check_rsync () {
    if ! type rsync &> /dev/null; then
        echo -e "${WHITE}--------------------------\n"
        echo -e "${ORANGE}[!] Please install ${WHITE}rsync ${ORANGE}command on your system!"

        while true; do
            read -p "${GREEN}[@] Do you want ${WHITE}UniTeX${GREEN} to install this command on your system? [y/n]${WHITE}" yn
            case $yn in
                [Yy]*)
                    if [[ ${OS} = 'Darwin' ]]; then
                        brew install --quiet rsync
                    elif [[ ${OS} = 'Linux' ]]; then
                        sudo apt-get install -qq rsync
                    fi
                    echo -e "\n${GREEN}[@] Installation done!"
                    break
                    ;;
                [Nn]*)
                    break
                    ;;
                *)
                    echo -e "${ORANGE}[!] Please answer yes or no."
                    ;;
            esac
        done
    fi
}

use_viewer () {
    if command -v zathura &> /dev/null; then 
        echo -e "${WHITE}--------------------------\n"
        echo -e "${GREEN}[@] This pdf viewer has been found on your system: \n${WHITE}$(zathura -v)"

        if ! grep -s -e "\$ pdf_previewer = 'zathura';" ${CONFIG}/latexmkrc &> /dev/null; then
            while true; do
                read -p "${GREEN}[@] Do you want to use this viewer as default while compiling templates? [y/n]" yn
                case $yn in
                    [Yy]*)
                        mkdir -p ${CONFIG}
                        echo -n  "" > ${CONFIG}/latexmkrc
                        echo "\$ pdf_previewer = 'zathura';" >> ${CONFIG}/latexmkrc
                        break
                        ;;
                    [Nn]*)
                        break
                        ;;
                    *)
                        echo -e "${ORANGE}[!] Please answer yes or no."
                        ;;
                esac
            done
        fi

    fi
}

build_directory () {
    echo -e "${WHITE}\n--------------------------\n"
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
    echo -e "${WHITE}\n--------------------------\n"
    echo -e "${GREEN}[@] Filling dirs with templates..."

    sudo rsync -a --exclude='*.md,*.1' ${CURRENT_DIR}/ ${DESTINATION}/${PROJ}

    if [[ "${OS}" = "Darwin" ]]; then
        sudo rsync ${CURRENT_DIR}/unitex.1 ${MAN_DIR}/man1/unitex.1
    else
        sudo rsync ${CURRENT_DIR}/unitex.1 ${MAN_DIR}/unitex.1
    fi

    # Make scripts executable
    sudo chmod +x ${DESTINATION}/${PROJ}/unitex.sh
    sudo chmod +x ${DESTINATION}/${PROJ}/uninstall.sh

    # Version control
    echo "${TAG}" | cut -d '-' -f 1 | sudo tee ${DESTINATION}/${PROJ}/version.txt &> /dev/null

    # Create symlink
    echo -e "${GREEN}[@] Updating symlink from ${WHITE}${LINK_DIR}${GREEN}."
    if [[ -L ${LINK_DIR} ]]; then
        sudo rm ${LINK_DIR}
        sudo ln -s ${DESTINATION}/${PROJ}/unitex.sh ${LINK_DIR}
    else
        sudo ln -s ${DESTINATION}/${PROJ}/unitex.sh ${LINK_DIR}
    fi

    echo -e "${GREEN}[@] ${WHITE}${PROJ}${GREEN} Installed successfully:${WHITE} Execute 'unitex -h' to verify installation."
    echo -e "${WHITE}\n--------------------------"
}

main () {
    check_rsync
    use_viewer
    build_directory
    fill_directory
    reset_terminal
}

main
