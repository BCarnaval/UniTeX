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
    clear
    echo -e "${CYAN}UniTeX $(cat ${PROJ_DIR}/version.txt), BCarnaval."
    reset_terminal
}

usage () {
    clear

    cat << EOF
    ------------------------------------------------------------------------------
    ------------------------------------------------------------------------------
    ${CYAN}
    888     888          d8b 88888888888      Y88b   d88P 
    888     888          Y8P     888           Y88b d88P  
    888     888                  888            Y88o88P   
    888     888 88888b.  888     888   .d88b.    Y888P    
    888     888 888 "88b 888     888  d8P  Y8b   d888b    
    888     888 888  888 888     888  88888888  d88888b   
    Y88b. .d88P 888  888 888     888  Y8b.     d88P Y88b  
     "Y88888P"  888  888 888     888   "Y8888 d88P   Y88b
    ${WHITE}
    Usage: ${CYAN}$(basename $0) ${WHITE}-h <help> -v <version> -b <build> -d <dir> -o <opt> [-hvbdo]

    ${CYAN}-h,          -help           ${WHITE}Display help.

    ${CYAN}-v,          -version        ${WHITE}Display current installation version of UniTex.

    ${CYAN}-b,          -build          ${WHITE}Build specified template using latexmk compiler (ex: classic, article, homework).

    ${CYAN}-d,          -dir            ${WHITE}Specifies where to build chosen template.

    ${CYAN}-o,          -opt            ${WHITE}Specifies 'make' tool option (clean, targz, zip or dry). No option means 'make all'.

EOF
}

copy_template () {
    cp -r ${PROJ_DIR}/${BUILD_TEMP}/ ${BUILD_DIR}/
}

build_template () {
    make ${MAKE_OPT} -C ${BUILD_DIR}
}

main () {
    check_latexmk
    copy_template
    build_template
}

while getopts ":b:d:o:vh" opt; do
    case ${opt} in
        b)
            case ${OPTARG} in
                classic)
                    BUILD_TEMP=Classic
                    ;;
                article)
                    BUILD_TEMP=Article
                    ;;
                homework)
                    BUILD_TEMP=Homework
                    ;;
                *)
                    echo -e "${ORANGE}[X] UniTeX doesn't have a template named '${OPTARG}' ${WHITE}run $(basename ${0}) -h."
                    reset_terminal
                    exit 0
                    ;;
            esac
            ;;
        d)
            BUILD_DIR=${OPTARG}
            ;;

        o)
            MAKE_OPT=${OPTARG}
            case ${MAKE_OPT} in
                clean|targz|zip|dry)
                    ;;
                *)
                    echo -e "${RED}[X] Unknown option: '${MAKE_OPT}' ${WHITE}run $(basename ${0}) -h."
                    reset_terminal
                    exit 0
                    ;;
            esac
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
if [[ "${BUILD_TEMP}" && "${BUILD_DIR}" ]]; then
    main
else
    usage
    exit 0
fi
