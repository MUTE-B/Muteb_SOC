#!/bin/bash
#
# ==========================================================
# MUTEB SOC
# Linux Hardening Engine
# ==========================================================

linux_hardening() {

print_title "LINUX HARDENING AUDIT"

echo
echo "[SSH Root Login]"

if grep -Eq '^PermitRootLogin[[:space:]]+no' /etc/ssh/sshd_config 2>/dev/null; then
    print_success "Root Login Disabled"
else
    print_warning "Root Login Enabled or Not Configured"
fi

echo
echo "[Password Authentication]"

if grep -Eq '^PasswordAuthentication[[:space:]]+no' /etc/ssh/sshd_config 2>/dev/null; then
    print_success "Password Authentication Disabled"
else
    print_warning "Password Authentication Enabled"
fi

echo
echo "[Firewall]"

if systemctl is-active --quiet ufw; then
    print_success "UFW Running"
else
    print_warning "UFW Stopped"
fi

echo
echo "[Fail2ban]"

if systemctl is-active --quiet fail2ban; then
    print_success "Fail2ban Running"
else
    print_warning "Fail2ban Stopped"
fi

echo
echo "[Automatic Updates]"

if systemctl is-enabled --quiet unattended-upgrades 2>/dev/null; then
    print_success "Enabled"
else
    print_warning "Disabled"
fi

echo
echo "[World Writable Directories]"
find / -xdev -type d -perm -0002 2>/dev/null | head -20

echo
echo "[Empty Password Accounts]"
awk -F: '($2==""){print $1}' /etc/shadow 2>/dev/null

echo

log_success "Hardening Audit Completed"

}

