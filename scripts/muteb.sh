#!/usr/bin/env bash

set -Eeuo pipefail

ROOT="$HOME/Muteb-SOC"
VENV="$ROOT/venv"
FRONTEND="$ROOT/frontend"
LOGS="$ROOT/logs"

BACKEND_LOG="$LOGS/backend.log"
FRONTEND_LOG="$LOGS/frontend.log"

mkdir -p "$LOGS"

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


banner(){

clear

echo "=============================================================="
echo "              MUTEB SOC ENTERPRISE MANAGER"
echo "=============================================================="

}


check(){

banner

info "Checking project"

cd "$ROOT"


command -v python3 >/dev/null || error "Python missing"

command -v node >/dev/null || error "Node missing"

command -v npm >/dev/null || error "NPM missing"


if [ -d "$VENV" ]; then

source "$VENV/bin/activate"

info "Virtual environment active"

else

error "Virtual environment missing"

fi


python3 -m compileall app >/dev/null

info "Python validation completed"


cd "$FRONTEND"

npm list --depth=0 >/dev/null 2>&1 || warn "Frontend packages missing"


cd "$ROOT"


curl -s http://127.0.0.1:8000/api/version/info >/dev/null \
&& info "Backend API ONLINE" \
|| warn "Backend API OFFLINE"


ss -tulpn | grep 8000 >/dev/null \
&& info "Backend port 8000 OPEN" \
|| warn "Backend port closed"


ss -tulpn | grep 5173 >/dev/null \
&& info "Frontend port 5173 OPEN" \
|| warn "Frontend port closed"


}


install(){

banner

cd "$ROOT"

source "$VENV/bin/activate"


info "Installing backend packages"

pip install -r requirements.txt


info "Installing frontend packages"

cd "$FRONTEND"

npm install


info "Installation completed"

}


start(){

banner

cd "$ROOT"

source "$VENV/bin/activate"


pkill -f "python3 run.py" || true

pkill -f "vite" || true


info "Starting Flask"

nohup python3 run.py \
>"$BACKEND_LOG" 2>&1 &


sleep 6


info "Testing backend"

curl -s \
http://127.0.0.1:8000/api/version/info \
| python3 -m json.tool


info "Starting React"

cd "$FRONTEND"


nohup npm run dev \
>"$FRONTEND_LOG" 2>&1 &


sleep 8


info "Services started"


echo

echo "Backend  : http://127.0.0.1:8000"

echo "Frontend : http://localhost:5173"


}


stop(){

banner

info "Stopping services"

pkill -f "python3 run.py" || true

pkill -f "vite" || true


info "Stopped"

}


restart(){

stop

sleep 3

start

}


logs(){

banner

echo "================ BACKEND ================"

tail -50 "$BACKEND_LOG" || true


echo

echo "================ FRONTEND ================"

tail -50 "$FRONTEND_LOG" || true


}


backup(){

banner

cd "$ROOT"


mkdir -p backups


NAME="muteb_backup_$(date +%Y%m%d_%H%M%S).tar.gz"


tar -czf \
"backups/$NAME" \
--exclude=venv \
--exclude=node_modules \
.


info "Backup created"

}


routes(){

banner

cd "$ROOT"

source "$VENV/bin/activate"


python3 - <<'PY'

from app.core.application import create_app

app=create_app()

print("="*60)

print("MUTEB SOC ROUTES")

print("="*60)

for route in sorted(app.url_map.iter_rules(),key=lambda x:x.rule):

    print(route)

PY

}


status(){

banner

echo

ps aux | grep -E "python3 run.py|vite" | grep -v grep || true

echo

ss -tulpn | grep -E "8000|5173" || true

}


case "${1:-}" in

start)
start
;;

stop)
stop
;;

restart)
restart
;;

check)
check
;;

install)
install
;;

logs)
logs
;;

backup)
backup
;;

routes)
routes
;;

status)
status
;;

*)

echo

echo "MUTEB SOC COMMANDS"

echo

echo "./scripts/muteb.sh start"

echo "./scripts/muteb.sh stop"

echo "./scripts/muteb.sh restart"

echo "./scripts/muteb.sh check"

echo "./scripts/muteb.sh install"

echo "./scripts/muteb.sh logs"

echo "./scripts/muteb.sh backup"

echo "./scripts/muteb.sh routes"

echo "./scripts/muteb.sh status"

;;

esac
