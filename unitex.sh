#!/usr/bin/env bash

# Author: Antoine de Lagrave
# Email: antoinedelagrave@hotmail.com
# GitHub: @BCarnaval

# UniTeX: UniTeX is a collection of scientific oriented and minimalistic
# LaTeX templates suitable for many assignment types.

# Colors
RED="$(printf '\033[31m')"
CYAN="$(printf '\033[36m')"
GREEN="$(printf '\033[32m')"
WHITE="$(printf '\033[37m')"
ORANGE="$(printf '\033[33m')"

# Font style
BOLD="$(printf '\033[1m')"
REG="$(printf '\033[0m')"

PROJ_DIR=/usr/local/share/UniTeX

reset_terminal () {
    tput sgr0
}

display_version () {
    echo -e "${CYAN}[~] UniTeX $(cat ${PROJ_DIR}/version.txt), BCarnaval."
}

usage () {
    cat << EOF
${BOLD}${CYAN}
 _   _       _ _____
| | | |_ __ (_)_   _|____  __
| | | | '_ \| | | |/ _ \ \/ /
| |_| | | | | | | |  __/>  <
 \___/|_| |_|_| |_|\___/_/\_\

${WHITE}
Usage: ${REG}${CYAN}$(basename $0) ${WHITE}-h <help> -v <version> -b <build> -d <dir> -o <opt> [-hvbdo]

${BOLD}${CYAN}-h,          -help               ${REG}${WHITE}Display help.

${BOLD}${CYAN}-v,          -version            ${REG}${WHITE}Display current installation version of UniTex.

${BOLD}${CYAN}-b,          -build              ${REG}${WHITE}Build specified template using latexmk compiler (ex: classic, article, homework, cover).

${BOLD}${CYAN}-d,          -dir                ${REG}${WHITE}Specifies where to build chosen template.

${BOLD}${CYAN}-o,          -opt     ${REG}${WHITE}(optional) Specifies 'make' tool option (clean, targz, zip or dry). No option means 'make all'.
${WHITE}${BOLD}
Examples:

1) $ ${CYAN}unitex -b classic -d ./ -o dry${WHITE}
${REG}
This command is used to build (in none continuous mode) the ${CYAN}classic ${WHITE}template in current directory.
${BOLD}
2) $ ${CYAN}unitex -b classic -d ~/some/assignement/directory/${WHITE}
${REG}
This command is used to build the ${CYAN}classic ${WHITE}template in given directory.

    If one wants to share the project to some collaborator(s), he/she could go to
    his/her ${CYAN}UniTeX ${WHITE}project and use
    ${BOLD}
    2.1) ~/some/assignement/directory/ $ ${CYAN}make zip${WHITE}
    ${REG}
    and it will build a zip of the project in project's directory. Obviously, the command
    ${BOLD}
    2.2) ~/some/assignement/directory/ $ ${CYAN}make clean${WHITE}
    ${REG}
    also exists and doesn't need any explanation.
EOF
}

check_pdflatex () {
    if type pdflatex &> /dev/null; then
        echo -e "${GREEN}[@] Using pdf generator version: ${WHITE}$(pdflatex -version)."
    else
        echo -e "${RED}[X] Program ${WHITE}'pdflatex'${RED} is not installed on your system!"
        echo -e "${ORANGE}[!] Verify your ${WHITE}'TeX'${ORANGE} installation: ${WHITE}exiting..."
        reset_terminal
        exit 1
    fi
}

check_latexmk () {
    if type latexmk &> /dev/null; then
        echo -e "${GREEN}[@] Using compiler 'latexmk' version: ${WHITE}$(latexmk -v)."
    else
        echo -e "${RED}[X] Compiler ${WHITE}'latexmk'${RED} is not installed on your system:${WHITE} exiting..."
        reset_terminal
        exit 1
    fi
}

copy_template () {
    echo -e "${GREEN}[@] Copying template to ${WHITE}${BUILD_DIR}${GREEN} directory...${WHITE}"
    rsync -a ${PROJ_DIR}/${BUILD_TEMP}/ ${BUILD_DIR}/
}

build_template () {
    echo -e "${GREEN}[@] Building template inside ${WHITE}${BUILD_DIR}..."
    make ${MAKE_OPT} --directory=${BUILD_DIR}
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
    echo -e "${WHITE}--------------------------"
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
                while true; do
                    read -p "${ORANGE}[!] Do you wish to use ${WHITE}$(pwd)${ORANGE} instead? [y/n]" yn
                    case $yn in
                        [Yy]*)
                            BUILD_DIR=$(pwd)
                            break
                            ;;
                        [Nn]*)
                            reset_terminal
                            echo -e "${GREEN}[@] Exiting..."
                            exit 0
                            ;;
                        *)
                            echo -e "${ORANGE}[!] Please answer yes or no."
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
if [[ ${BUILD_TEMP} && ${BUILD_DIR} ]]; then
    main
else
    echo -e "${ORANGE}[!] You must chose a template using ${WHITE}'b' ${ORANGE}flag."
    echo -e "[!] AND a directory using ${WHITE} 'd' ${ORANGE} flag."
    echo -e "${ORANGE}[!] Options are currently ${WHITE}'classic, article, homework and cover'."
    echo -e "${GREEN}[@] Run ${WHITE}$(basename ${0}) -h."
    reset_terminal
    exit 1
fi
