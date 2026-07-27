#!/bin/bash
#
# ==========================================================
# MUTEB SOC
# Logging Engine
# ==========================================================

ensure_log_file() {

mkdir -p "$LOG_DIR"

touch "$LOG_FILE"

}

write_log() {

local LEVEL="$1"
local MESSAGE="$2"

ensure_log_file

echo "[$(timestamp)] [$LEVEL] $MESSAGE" >> "$LOG_FILE"

}

log_info() {

write_log "INFO" "$1"

print_info "$1"

}

log_success() {

write_log "SUCCESS" "$1"

print_success "$1"

}

log_warning() {

write_log "WARNING" "$1"

print_warning "$1"

}

log_error() {

write_log "ERROR" "$1"

print_error "$1"

}

log_section() {

ensure_log_file

echo "" >> "$LOG_FILE"

echo "==================================================" >> "$LOG_FILE"

echo "[$(timestamp)] $1" >> "$LOG_FILE"

echo "==================================================" >> "$LOG_FILE"

}

rotate_logs() {

if [[ -f "$LOG_FILE" ]]; then

SIZE=$(stat -c%s "$LOG_FILE")

LIMIT=$((5*1024*1024))

if (( SIZE >= LIMIT )); then

mv "$LOG_FILE" "$LOG_FILE.$(date +%F_%H-%M-%S)"

touch "$LOG_FILE"

fi

fi

}

initialize_logger() {

rotate_logs

ensure_log_file

log_section "MUTEB SOC Started"

}
