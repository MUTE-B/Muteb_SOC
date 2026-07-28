#!/usr/bin/env bash

set -Eeuo pipefail

ROOT="$HOME/Muteb-SOC"

GREEN="\033[1;32m"
RED="\033[1;31m"
YELLOW="\033[1;33m"
BLUE="\033[1;34m"
RESET="\033[0m"


ok(){
echo -e "${GREEN}[OK]${RESET} $1"
}

fail(){
echo -e "${RED}[FAIL]${RESET} $1"
}

info(){
echo -e "${BLUE}[INFO]${RESET} $1"
}

warn(){
echo -e "${YELLOW}[WARN]${RESET} $1"
}


echo
echo "================================================"
echo " MUTEB SOC ENTERPRISE DIAGNOSTIC"
echo "================================================"


cd "$ROOT"


info "Checking directory"

[ -d app ] && ok "Backend folder" || fail "Backend missing"

[ -d frontend ] && ok "Frontend folder" || fail "Frontend missing"


echo

info "Checking Python"

python3 --version && ok "Python"


echo

info "Checking Virtual Environment"

[ -d venv ] && ok "venv exists" || fail "venv missing"


echo

info "Checking Flask"

source venv/bin/activate

python3 - <<'PY'

from app.core.application import create_app

app=create_app()

print("Flask application loaded")

print("Routes:")

for r in app.url_map.iter_rules():

    print(r.rule)

PY


echo

info "Checking React"

cd frontend

[ -f package.json ] && ok "package.json" || fail "package.json missing"


npm --version && ok "npm"


echo

info "Checking API"


curl -f \
http://127.0.0.1:8000/api/version/info \
>/dev/null \
&& ok "Backend API" \
|| warn "Backend offline"


echo

info "Checking ports"


ss -tulpn | grep 8000 \
&& ok "Backend port" \
|| warn "8000 closed"


ss -tulpn | grep 5173 \
&& ok "Frontend port" \
|| warn "5173 closed"


echo

info "Checking logs"


cd "$ROOT"


if [ -f logs/backend.log ]
then

tail -20 logs/backend.log

else

warn "Backend log missing"

fi


echo

if [ -f logs/frontend.log ]
then

tail -20 logs/frontend.log

else

warn "Frontend log missing"

fi


echo

echo "================================================"

echo " DIAGNOSTIC FINISHED"

echo "================================================"

