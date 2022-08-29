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


