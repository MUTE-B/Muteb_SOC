#!/bin/bash
#
# ==========================================================
# MUTEB SOC
# Network Monitoring Engine
# ==========================================================

monitor_network() {

print_title "NETWORK MONITOR"

echo "[Interfaces]"
ip -br addr

echo
echo "[Default Gateway]"
ip route | grep default

echo
echo "[DNS]"
grep "^nameserver" /etc/resolv.conf

echo
echo "[Listening Ports]"
ss -tuln

echo
echo "[Network Statistics]"
ip -s link

log_info "Network Monitor Completed"

}
