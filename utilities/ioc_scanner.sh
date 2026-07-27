#!/bin/bash
#
# ==========================================================
# MUTEB SOC
# IOC Scanner
# ==========================================================

ioc_scanner() {

print_title "IOC SCANNER"

echo
echo "[Suspicious Processes]"

ps aux | grep -Ei "nc|ncat|netcat|socat|crypt|miner|xmrig" | grep -v grep || echo "None"

echo
echo "[Hidden Files]"
find /tmp /var/tmp /dev/shm -name ".*" 2>/dev/null | head -30

echo
echo "[Suspicious Executables]"
find /tmp /var/tmp -type f -perm /111 2>/dev/null | head -30

echo
echo "[Recent Modified Files]"
find /etc -mtime -1 2>/dev/null | head -30

echo

log_success "IOC Scan Completed"

}

