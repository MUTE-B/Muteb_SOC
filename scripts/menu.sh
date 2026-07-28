#!/usr/bin/env bash

set -Eeuo pipefail


ROOT="$HOME/Muteb-SOC"


GREEN="\033[1;32m"
BLUE="\033[1;34m"
YELLOW="\033[1;33m"
RED="\033[1;31m"
RESET="\033[0m"



pause(){

read -p "Press ENTER to continue..."

}



header(){

clear

echo -e "${BLUE}"

echo "================================================"

echo "          MUTEB SOC ENTERPRISE PANEL"

echo "================================================"

echo -e "${RESET}"

}



start(){

"$ROOT/scripts/start.sh"

pause

}



stop(){

pkill -f "python3 run.py" || true

pkill -f "vite" || true

echo

echo "Services stopped"

pause

}



restart(){

"$ROOT/scripts/start.sh"

pause

}



status(){

echo

echo "================ STATUS ================"


ps aux | grep -E \
"python3 run.py|vite" \
| grep -v grep || true


echo

ss -tulpn | grep -E "8000|5173" || true


pause

}



health(){

curl -s \
http://127.0.0.1:8000/api/system/health \
| python3 -m json.tool


pause

}



logs(){

echo

echo "========== BACKEND =========="

tail -50 "$ROOT/logs/backend.log" || true


echo

echo "========== FRONTEND =========="

tail -50 "$ROOT/logs/frontend.log" || true


pause

}



security(){

"$ROOT/scripts/muteb_security.sh"

pause

}



monitor(){

"$ROOT/scripts/muteb_monitor.sh once"

pause

}



backup(){

"$ROOT/scripts/muteb.sh backup"

pause

}



routes(){

"$ROOT/scripts/muteb.sh routes"

pause

}



while true

do


header


echo "1) Start MUTEB SOC"

echo "2) Stop Services"

echo "3) Restart"

echo "4) Status"

echo "5) Health Check"

echo "6) Logs"

echo "7) Security Scan"

echo "8) System Monitor"

echo "9) Backup"

echo "10) API Routes"

echo "0) Exit"


echo

read -p "Select Option: " choice



case $choice in


1)

start

;;


2)

stop

;;


3)

restart

;;


4)

status

;;


5)

health

;;


6)

logs

;;


7)

security

;;


8)

monitor

;;


9)

backup

;;


10)

routes

;;


0)

exit

;;


*)

echo "Invalid option"

sleep 2

;;


esac



done

