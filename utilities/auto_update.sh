#!/bin/bash
#
# ==========================================================
# MUTEB SOC
# Auto Update
# ==========================================================

auto_update() {

print_title "AUTO UPDATE"

if [[ -d .git ]]; then

git fetch --all >/dev/null 2>&1

LOCAL=$(git rev-parse HEAD)
REMOTE=$(git rev-parse @{u} 2>/dev/null)

if [[ "$LOCAL" == "$REMOTE" ]]; then

print_success "Already Up To Date"

else

print_warning "New Update Available"

fi

else

print_warning "Git Repository Not Found"

fi

log_success "Update Check Completed"

}

