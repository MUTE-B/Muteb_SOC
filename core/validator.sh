#!/bin/bash
#
# ==========================================================
# MUTEB SOC
# Environment Validator
# ==========================================================

validate_environment() {

log_section "Environment Validation"

local errors=0

for cmd in "${REQUIRED_COMMANDS[@]}"
do
    if command -v "$cmd" >/dev/null 2>&1; then
        log_success "$cmd : OK"
    else
        log_error "$cmd : Missing"
        ((errors++))
    fi
done

if systemctl is-active --quiet ssh; then
    log_success "SSH Service : Running"
else
    log_warning "SSH Service : Stopped"
fi

if command -v ufw >/dev/null 2>&1; then
    log_success "Firewall : Installed"
else
    log_warning "Firewall : Not Installed"
fi

if [[ $errors -gt 0 ]]; then
    log_error "Validation completed with $errors error(s)."
    return 1
fi

log_success "Environment validation completed successfully."

}

