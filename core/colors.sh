#!/bin/bash
#
# ==========================================================
# MUTEB SOC
# ANSI Color Library
# ==========================================================

RESET="\e[0m"

BLACK="\e[30m"
RED="\e[31m"
GREEN="\e[32m"
YELLOW="\e[33m"
BLUE="\e[34m"
MAGENTA="\e[35m"
CYAN="\e[36m"
WHITE="\e[37m"

BOLD="\e[1m"
DIM="\e[2m"
UNDERLINE="\e[4m"

ORANGE="\e[38;5;208m"
LIME="\e[38;5;118m"
SKY="\e[38;5;39m"
PURPLE="\e[38;5;141m"

print_info() {

echo -e "${BLUE}[INFO]${RESET} $1"

}

print_success() {

echo -e "${GREEN}[ OK ]${RESET} $1"

}

print_warning() {

echo -e "${YELLOW}[WARN]${RESET} $1"

}

print_error() {

echo -e "${RED}[FAIL]${RESET} $1"

}

print_title() {

echo
echo -e "${CYAN}${BOLD}$1${RESET}"
printf '%*s\n' "${#1}" '' | tr ' ' '='
echo

}
