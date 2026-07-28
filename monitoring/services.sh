#!/bin/bash
#
# ==========================================================
# MUTEB SOC
# Services Monitoring Engine
# ==========================================================

monitor_services() {

print_title "SERVICES MONITOR"

SERVICES=(
ssh
systemd-resolved
NetworkManager
cron
rsyslog
ufw
fail2ban
apache2
nginx
mysql
docker
)

printf "%-25s %-15s\n" "SERVICE" "STATUS"
printf "%-25s %-15s\n" "------------------------" "---------------"

for SERVICE in "${SERVICES[@]}"
do
    if systemctl list-unit-files | grep -q "^${SERVICE}\.service"; then

        STATUS=$(systemctl is-active "$SERVICE" 2>/dev/null)

        printf "%-25s %-15s\n" "$SERVICE" "$STATUS"

    fi
done

echo

echo "[Running Services]"

systemctl --type=service --state=running \
--no-pager \
--no-legend | head -30

log_info "Services Monitor Completed"

}
