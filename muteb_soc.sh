#!/bin/bash
#
# ==========================================================
# MUTEB SOC
# Main Engine
# Developer : Muteb Albalawi
# ==========================================================

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$BASE_DIR/core/constants.sh"
source "$BASE_DIR/core/colors.sh"
source "$BASE_DIR/core/helpers.sh"
source "$BASE_DIR/core/logger.sh"
source "$BASE_DIR/core/banner.sh"
source "$BASE_DIR/core/validator.sh"
source "$BASE_DIR/core/health.sh"
source "$BASE_DIR/core/bootstrap.sh"
source "$BASE_DIR/core/shutdown.sh"

bootstrap

show_banner

system_health_check

validate_environment

log_success "MUTEB SOC Engine Started Successfully"

echo
print_title "SYSTEM INFORMATION"

system_info

echo


source "$BASE_DIR/config/menu.sh"

echo
print_success "Initialization Complete"

sleep 1

main_menu


source "$BASE_DIR/utilities/log_analyzer.sh"
source "$BASE_DIR/utilities/ioc_scanner.sh"

echo
print_title "THREAT HUNTING"

log_analyzer
ioc_scanner


source "$BASE_DIR/utilities/linux_hardening.sh"

echo
print_title "HARDENING ENGINE"

linux_hardening


source "$BASE_DIR/utilities/threat_intelligence.sh"
source "$BASE_DIR/utilities/incident_response.sh"

echo
print_title "THREAT INTELLIGENCE"

threat_intelligence

echo
print_title "INCIDENT RESPONSE"

incident_response


source "$BASE_DIR/utilities/json_export.sh"
source "$BASE_DIR/utilities/html_report.sh"

echo
print_title "EXPORT ENGINE"

json_export
html_report


source "$BASE_DIR/utilities/plugin_manager.sh"
source "$BASE_DIR/utilities/config_manager.sh"
source "$BASE_DIR/utilities/auto_update.sh"

echo
print_title "SYSTEM MANAGEMENT"

config_manager
plugin_manager
auto_update



source "$BASE_DIR/utilities/tui_dashboard.sh"
source "$BASE_DIR/utilities/live_log_viewer.sh"


echo

print_title "ADVANCED MONITORING"


tui_dashboard


