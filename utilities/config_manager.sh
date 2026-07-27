#!/bin/bash
#
# ==========================================================
# MUTEB SOC
# Configuration Manager
# ==========================================================

config_manager() {

print_title "CONFIGURATION"

CONFIG_FILE="$BASE_DIR/config/muteb_soc.conf"

mkdir -p "$BASE_DIR/config"

if [[ ! -f "$CONFIG_FILE" ]]; then

cat > "$CONFIG_FILE" <<CFG
REPORT_DIR=reports
LOG_DIR=logs
TMP_DIR=tmp
DEBUG=false
AUTO_UPDATE=true
CFG

fi

cat "$CONFIG_FILE"

log_success "Configuration Loaded"

}

