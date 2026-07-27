#!/bin/bash
#
# ==========================================================
# MUTEB SOC
# Module Loader
# ==========================================================

load_module() {

local MODULE="$1"

if [[ -f "$MODULE" ]]; then

    # shellcheck source=/dev/null
    source "$MODULE"

    log_success "Loaded: $(basename "$MODULE")"

else

    log_error "Module not found: $MODULE"

    exit 1

fi

}

load_core() {

load_module "$CORE_DIR/colors.sh"
load_module "$CORE_DIR/constants.sh"
load_module "$CORE_DIR/helpers.sh"
load_module "$CORE_DIR/logger.sh"
load_module "$CORE_DIR/banner.sh"
load_module "$CORE_DIR/validator.sh"
load_module "$CORE_DIR/health.sh"
load_module "$CORE_DIR/bootstrap.sh"
load_module "$CORE_DIR/shutdown.sh"

}

load_monitoring() {

if [[ -d "$MONITOR_DIR" ]]; then

for file in "$MONITOR_DIR"/*.sh
do
    [[ -f "$file" ]] && source "$file"
done

fi

}

load_security() {

if [[ -d "$SECURITY_DIR" ]]; then

for file in "$SECURITY_DIR"/*.sh
do
    [[ -f "$file" ]] && source "$file"
done

fi

}

load_reporting() {

if [[ -d "$REPORTING_DIR" ]]; then

for file in "$REPORTING_DIR"/*.sh
do
    [[ -f "$file" ]] && source "$file"
done

fi

}

load_utilities() {

if [[ -d "$UTILITIES_DIR" ]]; then

for file in "$UTILITIES_DIR"/*.sh
do
    [[ -f "$file" ]] && source "$file"
done

fi

}
