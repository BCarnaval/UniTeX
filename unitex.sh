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
BLUE="$(printf '\033[34m')"

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
UniTeX is a collection of scientific oriented and minimalistic LaTeX templates
suitable for many assignment types.
${BOLD}${WHITE}
USAGE

    ${BOLD}${CYAN}$(basename $0) -h ${REG}${WHITE}<help> ${BOLD}${CYAN}-v ${REG}${WHITE}<version> ${BOLD}${CYAN}-b ${REG}${WHITE}<build> ${BOLD}${CYAN}-d ${REG}${WHITE}<dir> ${BOLD}${CYAN}-o ${REG}${WHITE}<opt> ${BOLD}${CYAN}[-hvbdo]
${WHITE}${BOLD}
OPTIONS (required)

    ${BOLD}${CYAN}-b,        -build      ${REG}${WHITE}Build specified template (${BLUE}classic${WHITE}, ${BLUE}article${WHITE}, ${BLUE}homework${WHITE}, ${BLUE}cover${WHITE}).

    ${BOLD}${CYAN}-d,        -dir        ${REG}${WHITE}Specifies where to build chosen template.
${WHITE}${BOLD}
OPTIONS (optionnal)

    ${BOLD}${CYAN}-h,        -help       ${REG}${WHITE}Display help.

    ${BOLD}${CYAN}-v,        -version    ${REG}${WHITE}Display current installation version of ${CYAN}UniTeX${WHITE}.

    ${BOLD}${CYAN}-o,        -opt        ${REG}${WHITE}Specifies 'make' tool option (${BLUE}clean${WHITE}, ${BLUE}targz${WHITE}, ${BLUE}zip${WHITE} or ${BLUE}dry${WHITE}).
${BOLD}
EXAMPLES
    ${REG}
    The following command should be used to build (in non-continuous mode) the
    ${BLUE}classic ${WHITE}template in current directory:
    ${BOLD}
    1) $ ${CYAN}unitex -b ${REG}${WHITE}classic ${BOLD}${CYAN}-d ${REG}${WHITE}./ ${BOLD}${CYAN}-o ${REG}${WHITE}dry${BOLD}
       $ ...
    ${REG}
    The following is used to build (in continuous mode) the ${BLUE}homework ${WHITE}template
    in ${BLUE}'~/assignement/directory'${WHITE} directory:
    ${BOLD}
    2) $ ${CYAN}unitex -b ${REG}${WHITE}homework ${BOLD}${CYAN}-d ${REG}${WHITE}~/assignement/directory/${BOLD}
       $ ...
        ${REG}
        If one wants to share the project to some collaborator(s), the user could
        go to the ${CYAN}UniTeX ${WHITE}project and use
        ${BOLD}
        2.1) ~/assignement/directory/ $ ${CYAN}make ${REG}${WHITE}zip${BOLD}
             ~/assignement/directory/ $ ...
        ${REG}
        and it will build a zip of the project in project's directory. Obviously,
        the command:
        ${BOLD}
        2.2) ~/assignement/directory/ $ ${CYAN}make ${REG}${WHITE}clean${BOLD}
             ~/assignement/directory/ $ ...
        ${REG}
        also exists and doesn't need any further explanation.
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
    echo -e "${ORANGE}[!] You must chose a template using ${WHITE}'b' ${ORANGE}option."
    echo -e "[!] AND a directory using ${WHITE} 'd' ${ORANGE} option."
    echo -e "${ORANGE}[!] Options are currently ${WHITE}'classic, article, homework and cover'${ORANGE}."
    echo -e "${ORANGE}[!] Run ${WHITE}$(basename ${0}) -h${ORANGE}."
    reset_terminal
    exit 1
fi
