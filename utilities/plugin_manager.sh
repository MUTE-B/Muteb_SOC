#!/bin/bash
#
# ==========================================================
# MUTEB SOC
# Plugin Manager
# ==========================================================

plugin_manager() {

print_title "PLUGIN MANAGER"

PLUGIN_DIR="$BASE_DIR/plugins"

mkdir -p "$PLUGIN_DIR"

echo
echo "[Installed Plugins]"
echo

COUNT=0

for PLUGIN in "$PLUGIN_DIR"/*.sh
do
    [[ -f "$PLUGIN" ]] || continue

    NAME=$(basename "$PLUGIN")

    printf " [+] %s\n" "$NAME"

    source "$PLUGIN"

    ((COUNT++))

done

echo

printf "Total Plugins : %s\n" "$COUNT"

log_success "Plugin Manager Completed"

}

