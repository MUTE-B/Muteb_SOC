#!/usr/bin/env bash

set -Eeuo pipefail

PROJECT_DIR="$HOME/Muteb-SOC"

GREEN="\033[1;32m"
RED="\033[1;31m"
YELLOW="\033[1;33m"
BLUE="\033[1;34m"
RESET="\033[0m"


info(){
echo -e "${GREEN}[INFO]${RESET} $1"
}

warn(){
echo -e "${YELLOW}[WARN]${RESET} $1"
}

error(){
echo -e "${RED}[ERROR]${RESET} $1"
}


status(){

echo
echo "=============================="
echo " MUTEB SOC STATUS"
echo "=============================="

echo

ps aux | grep -E "python3 run.py|vite" | grep -v grep || true

echo

ss -tulpn | grep -E "8000|5173" || true

}


stop(){

info "Stopping MUTEB SOC"

pkill -f "python3 run.py" || true

pkill -f "vite" || true

info "Stopped"

}


restart(){

stop

sleep 3

"$PROJECT_DIR/scripts/start.sh"

}


logs(){

echo "========== BACKEND LOG =========="

tail -50 "$PROJECT_DIR/logs/backend.log" || true


echo

echo "========== FRONTEND LOG =========="

tail -50 "$PROJECT_DIR/logs/frontend.log" || true

}


backup(){

cd "$PROJECT_DIR"

DATE=$(date +"%Y%m%d_%H%M%S")

mkdir -p backups

tar -czf \
"backups/muteb_soc_$DATE.tar.gz" \
--exclude=venv \
--exclude=node_modules \
.


info "Backup created"

}


update(){

cd "$PROJECT_DIR"


git pull


source venv/bin/activate


pip install -r requirements.txt


cd frontend


npm install


cd ..


info "Update completed"

}


health(){

curl -s \
http://127.0.0.1:8000/api/system/health \
| python3 -m json.tool

}


case "${1:-}" in

start)

"$PROJECT_DIR/scripts/start.sh"

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

logs)

logs

;;

backup)

backup

;;

update)

update

;;

health)

health

;;

*)

echo

echo "MUTEB SOC MANAGEMENT"

echo

echo "./scripts/manage.sh start"

echo "./scripts/manage.sh stop"

echo "./scripts/manage.sh restart"

echo "./scripts/manage.sh status"

echo "./scripts/manage.sh logs"

echo "./scripts/manage.sh backup"

echo "./scripts/manage.sh update"

echo "./scripts/manage.sh health"

;;

esac

