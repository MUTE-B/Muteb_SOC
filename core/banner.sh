#!/bin/bash
#
# ==========================================================
# MUTEB SOC
# Banner Engine
# ==========================================================

show_banner() {

clear

echo -e "${LIME}"

cat << "BANNER"

███╗   ███╗██╗   ██╗████████╗███████╗██████╗
████╗ ████║██║   ██║╚══██╔══╝██╔════╝██╔══██╗
██╔████╔██║██║   ██║   ██║   █████╗  ██████╔╝
██║╚██╔╝██║██║   ██║   ██║   ██╔══╝  ██╔══██╗
██║ ╚═╝ ██║╚██████╔╝   ██║   ███████╗██████╔╝
╚═╝     ╚═╝ ╚═════╝    ╚═╝   ╚══════╝╚═════╝

BANNER

echo -e "${CYAN}${BOLD}              MUTEB SOC${RESET}"
echo -e "${GREEN}       Security Operations Center${RESET}"
echo -e "${SKY} Linux | Blue Team | Defensive Security${RESET}"
echo
echo -e "${DIM}Version : ${APP_VERSION}${RESET}"
echo -e "${DIM}Host    : ${HOSTNAME}${RESET}"
echo -e "${DIM}Kernel  : ${KERNEL}${RESET}"
echo

}
