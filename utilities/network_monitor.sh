#!/bin/bash
#
# ==========================================================
# MUTEB SOC
# Network Monitor
# ==========================================================

network_monitor() {

print_title "LIVE NETWORK"

echo
echo "Established Connections"
ss -tnp state established

echo
echo "Listening Ports"
ss -tulpen

echo
echo "Routing Table"
ip route

echo

log_success "Network Monitor Completed"

}

