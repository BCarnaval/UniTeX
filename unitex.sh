#!/usr/bin/env bash

# Author: Antoine de Lagrave
# Email: antoinedelagrave@hotmail.com
# GitHub: @BCarnaval

# UniTeX: UniTeX is a collection of scientific oriented and minimalistic 
# LaTeX templates suitable for many assignement types.

RED="$(printf '\033[31m')"
CYAN="$(printf '\033[36m')"
GREEN="$(printf '\033[32m')"
WHITE="$(printf '\033[37m')"
ORANGE="$(printf '\033[33m')"

PROJ_DIR=/usr/local/share/UniTeX

reset_terminal () {
    tput init
}

# Progress animation functions
sp="/-\|"
sc=0
spin() {
   printf "\r${GREEN}[@] ${1}${WHITE}${sp:sc++:1}"
   ((sc==${#sp})) && sc=0
}
endspin() {
   printf "\r%s\n" "$@"
}

# Exit if 'latexmk' not found on machine
check_latexmk() {
    if [[ -x $(command -v latexmk ) ]]; then
        echo -e "${GREEN}[@] Using compiler 'latexmk' version: ${WHITE}$(latexmk -v)${GREEN}."
        reset_terminal
    else
        echo -e "${RED}[X] Compiler 'latexmk' is not installed on your system:${WHITE} exiting..."
        reset_terminal
        exit 1
    fi
}

display_version () {
    echo -e "${CYAN}Current version of UniTeX is:${WHITE} UniTex 1.0${CYAN}."
    reset_terminal
}

# ------------------------
# FUNCS
# ------------------------

usage () {
    cat << EOF  
    Usage: $(basename $0) -h <help> -v <version> -b <build> [-hvb]

    -h, -help,          --help              Display help

    -v, -version,       --version           Display current installation version of UniTex

    -b, -build,         --build             Build specified template using latexmk compiler

EOF
}


main () {
    check_latexmk
}

while getopts ":b:vh" opt; do
    case ${opt} in
        b)
            BUILD_TEMP=${OPTARG}
            ;;
        v)
            display_version
            exit 0
            ;;
        h)
            usage
            exit 0
            ;;
        \?)
            echo -e "${RED}[X] Unknown option: '${OPTARG}' ${WHITE}run $(basename ${0}) -h."
            reset_terminal
            exit 1
            ;;
        :)
            echo -e "${ORANGE}[!] Invalid command: ${WHITE}'${OPTARG}' ${ORANGE}requires an argument."
            reset_terminal
            exit 1
            ;;
    esac
done

# Main run
if [[ "${BUILD_TEMP}" ]]; then
    echo ${BUILD_TEMP}
    main
else
    usage
    exit 0
fi
