#!/usr/bin/env bash

# Author: Antoine de Lagrave
# Email: antoinedelagrave@hotmail.com
# GitHub: @BCarnaval

# UniTeX: UniTeX is a collection of scientific oriented and minimalistic 
# LaTeX templates suitable for many assignment types.

RED="$(printf '\033[31m')"
CYAN="$(printf '\033[36m')"
GREEN="$(printf '\033[32m')"
WHITE="$(printf '\033[37m')"
ORANGE="$(printf '\033[33m')"

PROJ_DIR=/usr/local/share/UniTeX

reset_terminal () {
    tput sgr0
}

display_version () {
    echo -e "${CYAN}[~] UniTeX $(cat ${PROJ_DIR}/version.txt), BCarnaval."
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

    ${CYAN}-h,          -help               ${WHITE}Display help.

    ${CYAN}-v,          -version            ${WHITE}Display current installation version of UniTex.

    ${CYAN}-b,          -build              ${WHITE}Build specified template using latexmk compiler (ex: classic, article, homework, cover).

    ${CYAN}-d,          -dir                ${WHITE}Specifies where to build chosen template.

    ${CYAN}-o,          -opt     ${WHITE}(optional) Specifies 'make' tool option (clean, targz, zip or dry). No option means 'make all'.

EOF
}

check_pdflatex () {
    if [[ $(pdflatex -version) ]]; then
        echo -e "${GREEN}[@] Using pdf generator version: ${WHITE}$(pdflatex -version)."
    else
        echo -e "${RED}[X] Program 'pdflatex' is not installed on your system !"
        echo -e "${ORANGE}[!] Verify your 'TeX' installation: ${WHITE}exiting..."
        reset_terminal
        exit 1
    fi
}

check_latexmk () {
    if [[ -x $(command -v latexmk) ]]; then
        echo -e "${GREEN}[@] Using compiler 'latexmk' version: ${WHITE}$(latexmk -v)."
    else
        echo -e "${RED}[X] Compiler 'latexmk' is not installed on your system:${WHITE} exiting..."
        reset_terminal
        exit 1
    fi
}

copy_template () {
    echo -e "${GREEN}[@] Copying template to ${WHITE}${BUILD_DIR}${GREEN} directory...${WHITE}"
    cp -r ${PROJ_DIR}/${BUILD_TEMP}/ ${BUILD_DIR}/
}

build_template () {
    echo -e "${GREEN}[@] Building template inside ${WHITE}${BUILD_DIR}..."
    make ${MAKE_OPT} --directory=${BUILD_DIR}/
}

main () {
    echo -e "${WHITE}--------------------------\n"
    check_pdflatex
    echo -e "${WHITE}\n--------------------------\n"
    check_latexmk
    echo -e "${WHITE}\n--------------------------\n"
    copy_template
    echo -e "${WHITE}\n--------------------------\n"
    build_template
    echo -e "${WHITE}\n--------------------------"
    reset_terminal
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
                cover)
                    BUILD_TEMP=Cover
                    ;;
                *)
                    echo -e "${ORANGE}[!] UniTeX doesn't have a template named '${OPTARG}'. ${WHITE}Run $(basename ${0}) -h."
                    echo -e "${ORANGE}[!] Supported templates are currently ${WHITE}classic, article, homework and cover."
                    reset_terminal
                    exit 1
                    ;;
            esac
            ;;
        d)
            if [[ -d ${OPTARG} ]]; then
                BUILD_DIR=${OPTARG}
            else
                echo -e "${ORANGE}[!] ${WHITE}'${OPTARG}'${ORANGE} not a directory."
                echo "${ORANGE}[!] Do you wish to use ${WHITE}$(pwd)${ORANGE} instead?"
                select yn in "Yes" "No"; do
                    case ${yn} in
                        Yes)
                            BUILD_DIR=$(pwd)
                            break
                            ;;
                        No) 
                            reset_terminal
                            exit 0
                            ;;
                    esac
                done
                
            fi
            ;;

        o)
            MAKE_OPT=${OPTARG}
            case ${MAKE_OPT} in
                clean|targz|zip|dry)
                    ;;
                *)
                    echo -e "${RED}[X] Unknown option for 'make' tool: '${MAKE_OPT}'. ${WHITE}Run $(basename ${0}) -h."
                    echo -e "${RED}[X] Supported options for 'make' tool are: ${WHITE}clean, targz, zip and dry."
                    reset_terminal
                    exit 1
                    ;;
            esac
            ;;
        v)
            display_version
            reset_terminal
            exit 0
            ;;
        h)
            usage
            reset_terminal
            exit 0
            ;;
        \?)
            echo -e "${RED}[X] Unknown option: '${OPTARG}'. ${WHITE}Run $(basename ${0}) -h."
            reset_terminal
            exit 1
            ;;
        :)
            echo -e "${ORANGE}[!] Invalid command: ${WHITE}'${OPTARG}' ${ORANGE}requires an argument${WHITE}."
            reset_terminal
            exit 1
            ;;
    esac
done

# Main run
if [[ ${BUILD_TEMP} ]]; then
    main
else
    echo -e "${ORANGE}[!] You must chose a template using ${WHITE}'b' flag."
    echo -e "${ORANGE}[!] Options are currently ${WHITE}'classic, article, homework and cover'."
    echo -e "${GREEN}[@] Run ${WHITE}$(basename ${0}) -h."
    reset_terminal
    exit 1
fi
