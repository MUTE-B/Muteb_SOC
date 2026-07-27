#!/bin/bash
#
# ==========================================================
# MUTEB SOC
# File Integrity Monitor
# ==========================================================

integrity_monitor() {

print_title "FILE INTEGRITY MONITOR"

BASELINE="$BASE_DIR/baseline/system_binaries.sha256"

if [[ ! -f "$BASELINE" ]]; then

print_warning "Baseline not found."

return

fi

TEMP="$TMP_DIR/integrity_check.sha256"

find /bin /sbin /usr/bin /usr/sbin -type f -exec sha256sum {} \; \
2>/dev/null > "$TEMP"

echo

echo "Modified Files"

diff "$BASELINE" "$TEMP" | grep "^>" || echo "None"

echo

log_success "Integrity Scan Completed"

}

