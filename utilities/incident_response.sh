#!/bin/bash
#
# ==========================================================
# MUTEB SOC
# Incident Response Toolkit
# ==========================================================

incident_response() {

print_title "INCIDENT RESPONSE"

IR_DIR="$REPORT_DIR/IR_$(date +%F_%H-%M-%S)"

mkdir -p "$IR_DIR"

cp /etc/passwd "$IR_DIR/" 2>/dev/null
cp /etc/group "$IR_DIR/" 2>/dev/null

ps aux > "$IR_DIR/processes.txt"

ss -tunap > "$IR_DIR/network.txt"

ip addr > "$IR_DIR/ip_addr.txt"

ip route > "$IR_DIR/routes.txt"

who > "$IR_DIR/users.txt"

last -30 > "$IR_DIR/logins.txt"

journalctl -n 500 --no-pager > "$IR_DIR/system_journal.txt"

dmesg > "$IR_DIR/dmesg.txt"

tar -czf "${IR_DIR}.tar.gz" "$IR_DIR"

print_success "Incident Package Created"

echo "${IR_DIR}.tar.gz"

log_success "Incident Response Completed"

}

