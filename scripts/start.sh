#!/usr/bin/env bash

set -Eeuo pipefail


ROOT="$HOME/Muteb-SOC"

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

exit 1

}



title(){

echo

echo "=============================================================="

echo "$1"

echo "=============================================================="

}



check_system(){

title "SYSTEM CHECK"


cd "$ROOT"


command -v python3 >/dev/null \
|| error "Python missing"


if command -v npm >/dev/null

then

info "npm detected"

else

warn "npm missing"

info "Installing Node.js"


curl -fsSL https://deb.nodesource.com/setup_22.x \
| sudo -E bash -


sudo apt install -y nodejs


fi



python3 --version

node -v

npm -v


}



activate_env(){

title "PYTHON ENVIRONMENT"


[ -d venv ] \
|| error "venv missing"


source venv/bin/activate


info "Virtual environment active"


}



backend_prepare(){

title "BACKEND PREPARE"


cd "$ROOT"


python3 -m compileall app


if [ -f requirements.txt ]

then

pip install -r requirements.txt

fi



info "Backend ready"

}



frontend_prepare(){

title "FRONTEND PREPARE"


cd "$FRONTEND"


if [ ! -d node_modules ]

then

npm install

else

info "node_modules exists"

fi



npm run build


info "Frontend ready"


cd "$ROOT"


}



stop_old(){

title "STOP OLD SERVICES"


pkill -f "python3 run.py" || true

pkill -f "vite" || true


sleep 3


}



start_backend(){

title "START BACKEND"


cd "$ROOT"


nohup python3 run.py \
>"$BACKEND_LOG" 2>&1 &


echo $! > backend.pid


sleep 6


curl -f \
http://127.0.0.1:8000/api/version/info \
>/dev/null \
|| error "Backend failed"



info "Backend ONLINE"


}



auth_test(){

title "API AUTH TEST"


TOKEN=$(curl -s \
-X POST \
http://127.0.0.1:8000/api/auth/login \
-H "Content-Type: application/json" \
-d '{"username":"admin","password":"Password123"}' \
| python3 -c "import sys,json;print(json.load(sys.stdin).get('access_token',''))")



if [ -n "$TOKEN" ]

then

echo "$TOKEN" > token.txt

info "JWT OK"

else

warn "JWT failed"

fi


}



start_frontend(){

title "START FRONTEND"


cd "$FRONTEND"


nohup npm run dev \
-- --host 0.0.0.0 \
>"$FRONTEND_LOG" 2>&1 &



echo $! > ../frontend.pid


sleep 10



if ss -tulpn | grep 5173 >/dev/null

then

info "Frontend ONLINE"

else

warn "Frontend failed"

tail -30 "$FRONTEND_LOG"

fi



cd "$ROOT"


}



health(){

title "FINAL STATUS"



echo

echo "========== PROCESS =========="


ps aux | grep -E \
"python3 run.py|vite" \
| grep -v grep || true



echo

echo "========== PORTS =========="


ss -tulpn | grep -E "8000|5173" || true



echo

echo "========== URL =========="


echo

echo "Backend:"

echo "http://172.20.10.4:8000"



echo

echo "Frontend:"

echo "http://172.20.10.4:5173"



echo

echo "========== LOGS =========="


echo

echo "Backend"

tail -10 "$BACKEND_LOG" || true



echo

echo "Frontend"

tail -10 "$FRONTEND_LOG" || true



}



main(){


check_system

activate_env

backend_prepare

frontend_prepare

stop_old

start_backend

auth_test

start_frontend

health



echo

echo "=============================================================="

echo "          MUTEB SOC ENTERPRISE RUNNING"

echo "=============================================================="


}



main "$@"

