#!/bin/bash
#
# ==========================================================
# MUTEB SOC
# Helper Functions
# ==========================================================

command_exists() {
    command -v "$1" >/dev/null 2>&1
}

check_root() {
    if [[ $EUID -ne 0 ]]; then
        echo "[ERROR] Please run as root."
        exit 1
    fi
}

create_directories() {

    mkdir -p "$LOG_DIR"
    mkdir -p "$REPORT_DIR"
    mkdir -p "$TMP_DIR"

}

check_requirements() {

    local missing=()

    for cmd in "${REQUIRED_COMMANDS[@]}"
    do
        if ! command_exists "$cmd"; then
            missing+=("$cmd")
        fi
    done

    if (( ${#missing[@]} > 0 )); then

        echo
        echo "Missing Required Commands:"
        printf ' - %s\n' "${missing[@]}"
        echo

        exit 1
    fi

}

separator() {

printf '%*s\n' "${COLUMNS:-80}" '' | tr ' ' '='

}

timestamp() {

date '+%Y-%m-%d %H:%M:%S'

}

system_info() {

echo "Hostname : $HOSTNAME"
echo "Kernel   : $KERNEL"
echo "Arch     : $ARCH"
echo "CPU      : $CPU_CORES Cores"

}

ensure_file() {

[[ -f "$1" ]] || touch "$1"

}

