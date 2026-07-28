#!/usr/bin/env bash

set -Eeuo pipefail

ROOT="$HOME/Muteb-SOC"
LOGS="$ROOT/logs"

BACKEND_LOG="$LOGS/backend.log"
FRONTEND_LOG="$LOGS/frontend.log"

INTERVAL=30


GREEN="\033[1;32m"
RED="\033[1;31m"
YELLOW="\033[1;33m"
BLUE="\033[1;34m"
RESET="\033[0m"


info(){
echo -e "${GREEN}[+]${RESET} $1"
}


warn(){
echo -e "${YELLOW}[!]${RESET} $1"
}


error(){
echo -e "${RED}[X]${RESET} $1"
}


check_backend(){

if curl -s \
http://127.0.0.1:8000/api/system/health \
>/dev/null

then

info "Backend ONLINE"

else

error "Backend DOWN"

fi

}


check_frontend(){

if ss -tulpn | grep 5173 >/dev/null

then

info "Frontend ONLINE"

else

error "Frontend DOWN"

fi

}


check_process(){

echo

ps aux | grep -E \
"python3 run.py|vite" \
| grep -v grep \
|| warn "No application process"


}


system_info(){

echo

echo "================ SYSTEM ================"

date

echo

hostname

echo

uptime

echo

free -h

echo

df -h /

}


security_check(){

echo

echo "================ SECURITY ================"


echo

echo "Open Ports"

ss -tulpn


echo

echo "Active Users"

who


echo

echo "Failed Login Attempts"

journalctl \
-u ssh \
--no-pager \
| grep Failed \
| tail -10 || true


}


logs_check(){

echo

echo "================ LOGS ================"


echo

echo "BACKEND"

tail -10 "$BACKEND_LOG" 2>/dev/null || true


echo

echo "FRONTEND"

tail -10 "$FRONTEND_LOG" 2>/dev/null || true


}


monitor(){

clear


echo "================================================"

echo "        MUTEB SOC ENTERPRISE MONITOR"

echo "================================================"


while true

do


echo

echo "TIME: $(date)"


check_backend


check_frontend


check_process


system_info


logs_check


security_check


echo

echo "NEXT CHECK AFTER ${INTERVAL}s"


sleep "$INTERVAL"


clear


done

}


case "${1:-}" in


once)

check_backend

check_frontend

check_process

system_info

logs_check

security_check

;;


start)

monitor

;;


*)

echo

echo "Usage:"

echo "./scripts/muteb_monitor.sh once"

echo "./scripts/muteb_monitor.sh start"

;;

esac

