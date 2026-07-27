#!/bin/bash
#
# ==========================================================
# MUTEB SOC
# Threat Intelligence Engine
# ==========================================================

threat_intelligence() {

print_title "THREAT INTELLIGENCE"

echo
echo "[System Information]"
echo "Hostname : $(hostname)"
echo "IP       : $(hostname -I | awk '{print $1}')"
echo "Kernel   : $(uname -r)"
echo

echo "[Established Connections]"
ss -tun state established

echo
echo "[Top Remote IP Addresses]"

ss -tun | awk 'NR>1 {print $5}' \
| cut -d: -f1 \
| sort \
| uniq -c \
| sort -rn \
| head -20

echo
echo "[DNS Servers]"
grep "^nameserver" /etc/resolv.conf

echo
echo "[Recent SSH Activity]"
journalctl -u ssh --since "24 hours ago" --no-pager 2>/dev/null | tail -30

echo
echo "[Recent Sudo Commands]"
journalctl _COMM=sudo --since "24 hours ago" --no-pager 2>/dev/null | tail -30

echo
echo "[Listening Services]"
ss -tulpen

echo

log_success "Threat Intelligence Completed"

}

