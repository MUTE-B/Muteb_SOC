#!/bin/bash
#
# ==========================================================
# MUTEB SOC
# Baseline Engine
# ==========================================================

create_baseline() {

BASELINE_DIR="$BASE_DIR/baseline"

mkdir -p "$BASELINE_DIR"

print_title "CREATING SECURITY BASELINE"

sha256sum /etc/passwd > "$BASELINE_DIR/passwd.sha256"
sha256sum /etc/group > "$BASELINE_DIR/group.sha256"
sha256sum /etc/shadow 2>/dev/null > "$BASELINE_DIR/shadow.sha256"

find /bin /sbin /usr/bin /usr/sbin -type f -exec sha256sum {} \; \
2>/dev/null > "$BASELINE_DIR/system_binaries.sha256"

systemctl list-unit-files > "$BASELINE_DIR/services.list"

dpkg -l > "$BASELINE_DIR/packages.list" 2>/dev/null || true

crontab -l > "$BASELINE_DIR/crontab.txt" 2>/dev/null || true

ss -tulpen > "$BASELINE_DIR/open_ports.txt"

ip addr > "$BASELINE_DIR/network.txt"

mount > "$BASELINE_DIR/mounts.txt"

df -h > "$BASELINE_DIR/storage.txt"

free -h > "$BASELINE_DIR/memory.txt"

uname -a > "$BASELINE_DIR/kernel.txt"

hostnamectl > "$BASELINE_DIR/hostnamectl.txt"

log_success "Baseline Created"

}

compare_baseline() {

print_title "BASELINE VERIFICATION"

for FILE in passwd group shadow
do

if [[ -f "$BASELINE_DIR/${FILE}.sha256" ]]; then

sha256sum -c "$BASELINE_DIR/${FILE}.sha256" \
2>/dev/null

fi

done

log_success "Baseline Verification Completed"

}

