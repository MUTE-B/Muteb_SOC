#!/bin/bash

# ==========================================================
# MUTEB SOC v1.1
# Professional SOC Dashboard TUI v2.0
# ==========================================================

BASE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

source "$BASE_DIR/core/colors.sh" 2>/dev/null
source "$BASE_DIR/core/logger.sh" 2>/dev/null

clear


banner(){

echo "================================================="
echo "             MUTEB SOC DASHBOARD v2.0"
echo "================================================="
echo

}


system_health(){

echo "[ SYSTEM INFORMATION ]"
echo

echo "Hostname : $(hostname)"
echo "User     : $(whoami)"
echo "Kernel   : $(uname -r)"
echo

}


resource_monitor(){

echo "[ RESOURCE MONITOR ]"
echo

echo "CPU:"
top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4 "%"}'

echo

echo "Memory:"
free -h | awk '/Mem:/ {print $3 "/" $2}'

echo

echo "Disk:"
df -h / | awk 'NR==2 {print $3 "/" $2 " Used: "$5}'

echo

}


security_status(){

echo "[ SECURITY STATUS ]"
echo


FAILED=$(grep "Failed password" /var/log/auth.log 2>/dev/null | wc -l)

echo "Failed SSH Attempts : $FAILED"


echo

echo "Firewall Status:"

systemctl is-active ufw 2>/dev/null || echo "Not Active"


echo

}


services_status(){

echo "[ IMPORTANT SERVICES ]"
echo

for SERVICE in ssh apache2 cron ufw;

do

STATUS=$(systemctl is-active $SERVICE 2>/dev/null)

echo "$SERVICE : $STATUS"

done

echo

}


log_monitor(){

echo "[ RECENT SECURITY EVENTS ]"
echo


tail -10 /var/log/auth.log 2>/dev/null


}


main(){

while true

do

clear

banner

system_health

resource_monitor

security_status

services_status

log_monitor


echo
echo "Refresh every 10 seconds..."
echo "Press CTRL+C to exit"


sleep 10


done

}


main

