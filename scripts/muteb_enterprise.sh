#!/usr/bin/env bash

set -Eeuo pipefail


ROOT="$HOME/Muteb-SOC"

LOG_DIR="$ROOT/logs"

REPORT_DIR="$ROOT/reports"

BACKUP_DIR="$ROOT/backups"

FRONTEND="$ROOT/frontend"

VENV="$ROOT/venv"


BACKEND_LOG="$LOG_DIR/backend.log"

FRONTEND_LOG="$LOG_DIR/frontend.log"



mkdir -p \
"$LOG_DIR" \
"$REPORT_DIR" \
"$BACKUP_DIR"



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



header(){

clear

echo

echo "=============================================================="

echo "              MUTEB SOC ENTERPRISE"

echo "=============================================================="

echo

}



install(){

header

info "Installing system requirements"


sudo apt update


sudo apt install -y \
python3 \
python3-pip \
python3-venv \
nodejs \
npm \
git \
curl \
jq \
tree \
htop



if [ ! -d "$VENV" ]

then

python3 -m venv "$VENV"

fi



source "$VENV/bin/activate"



if [ -f "$ROOT/requirements.txt" ]

then

pip install -r "$ROOT/requirements.txt"

fi



cd "$FRONTEND"

npm install

cd "$ROOT"



chmod +x scripts/*.sh



info "Installation completed"

}



start(){

header


cd "$ROOT"


source "$VENV/bin/activate"



pkill -f "python3 run.py" || true

pkill -f "vite" || true



info "Starting Backend"



nohup python3 run.py \
>"$BACKEND_LOG" 2>&1 &



echo $! > backend.pid



sleep 5



info "Backend Test"



curl -s \
http://127.0.0.1:8000/api/version/info \
| jq



info "Starting Frontend"



cd "$FRONTEND"



nohup npm run dev \
-- --host 0.0.0.0 \
>"$FRONTEND_LOG" 2>&1 &



echo $! > ../frontend.pid



cd "$ROOT"



sleep 8



status



}



stop(){

header


pkill -f "python3 run.py" || true

pkill -f "vite" || true



info "Services stopped"

}



restart(){

stop

sleep 3

start

}



status(){

header


echo "============== PROCESSES =============="


ps aux | grep -E \
"python3 run.py|vite" \
| grep -v grep || true



echo

echo "============== PORTS =============="


ss -tulpn | grep -E \
"8000|5173|22|80" || true



echo

}



health(){

header



curl -s \
http://127.0.0.1:8000/api/system/health \
| jq



}



logs(){

header


echo

echo "============== BACKEND =============="


tail -50 "$BACKEND_LOG" || true



echo

echo "============== FRONTEND =============="


tail -50 "$FRONTEND_LOG" || true



}



backup(){

header


DATE=$(date +"%Y%m%d_%H%M%S")


tar -czf \
"$BACKUP_DIR/muteb_$DATE.tar.gz" \
--exclude=venv \
--exclude=node_modules \
"$ROOT"



info "Backup created"



}



security(){

header


echo "============== OPEN PORTS =============="


ss -tulpn



echo

echo "============== SSH FAILURES =============="


journalctl \
-u ssh \
--no-pager \
| grep Failed \
| tail -20 || true



}



report(){

header


FILE="$REPORT_DIR/report_$(date +%s).txt"



{

echo "MUTEB SOC REPORT"

echo

date

echo

uname -a

echo

free -h

echo

df -h

echo

ss -tulpn

echo

ps aux | grep -E "python3 run.py|vite"

} > "$FILE"



info "$FILE"



}



menu(){

while true

do


header


echo "1) Install"

echo "2) Start"

echo "3) Stop"

echo "4) Restart"

echo "5) Status"

echo "6) Health"

echo "7) Logs"

echo "8) Security"

echo "9) Backup"

echo "10) Report"

echo "0) Exit"


echo


read -p "Select Option: " opt



case $opt in


1) install ;;


2) start ;;


3) stop ;;


4) restart ;;


5) status ;;


6) health ;;


7) logs ;;


8) security ;;


9) backup ;;


10) report ;;


0) exit ;;


*) warn "Invalid option" ;;


esac


read -p "ENTER..."



done

}



case "${1:-menu}" in


menu)

menu

;;


start)

start

;;


stop)

stop

;;


restart)

restart

;;


status)

status

;;


health)

health

;;


logs)

logs

;;


security)

security

;;


backup)

backup

;;


report)

report

;;



install)

install

;;



*)

menu

;;


esac


