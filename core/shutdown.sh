#!/bin/bash
#
# ==========================================================
# MUTEB SOC
# Shutdown Engine
# ==========================================================

shutdown_engine() {

log_section "Shutdown"

echo
print_title "SHUTTING DOWN"

log_info "Saving logs..."
sync

log_success "Logs saved."

log_info "Cleaning temporary files..."

if [[ -d "$TMP_DIR" ]]; then
    find "$TMP_DIR" -type f -delete 2>/dev/null
fi

log_success "Temporary files cleaned."

log_info "Shutdown completed."

echo
print_success "Thank you for using $APP_NAME"
echo

exit 0

}

trap shutdown_engine EXIT

