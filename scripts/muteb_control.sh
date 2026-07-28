#!/usr/bin/env bash

set -Eeuo pipefail


ROOT="$HOME/Muteb-SOC"

FRONTEND="$ROOT/frontend"

LOG="$ROOT/logs"

BACKEND_LOG="$LOG/backend.log"

FRONTEND_LOG="$LOG/frontend.log"



mkdir -p "$LOG"



start(){

echo "================================"

echo " START MUTEB SOC"

echo "================================"


cd "$ROOT"


source venv/bin/activate 2>/dev/null || true



pkill -f "python3 run.py" || true

pkill -f "vite" || true



echo "[+] Starting Backend"



nohup python3 run.py \
>"$BACKEND_LOG" 2>&1 &



echo $! > backend.pid



sleep 5



echo "[+] Backend API"


curl -s \
http://127.0.0.1:8000/api/version/info \
| python3 -m json.tool || true



echo


echo "[+] Starting Frontend"



cd "$FRONTEND"



if ! command -v npm >/dev/null

then

sudo apt update

sudo apt install -y nodejs npm

fi



[ -d node_modules ] || npm install



nohup npm run dev \
-- --host 0.0.0.0 \
>"$FRONTEND_LOG" 2>&1 &



echo $! > "$ROOT/frontend.pid"



sleep 8



status



}



stop(){


echo "[+] Stopping MUTEB SOC"


pkill -f "python3 run.py" || true

pkill -f "vite" || true


echo "[+] STOPPED"


}



restart(){


stop


sleep 3


start


}



status(){


echo

echo "================================"

echo " PROCESS"

echo "================================"



ps aux | grep -E \
"python3 run.py|vite" \
| grep -v grep || true



echo

echo "================================"

echo " PORTS"

echo "================================"



ss -tulpn | grep -E \
"8000|5173|22|80" || true



echo

echo "================================"

echo " URL"

echo "================================"



echo "Backend : http://172.20.10.4:8000"

echo "Frontend: http://172.20.10.4:5173"



}



health(){


echo "================================"

echo " HEALTH"

echo "================================"



curl -s \
http://127.0.0.1:8000/api/system/health \
| python3 -m json.tool || true



}



logs(){


echo "============ BACKEND LOG ============"


tail -50 "$BACKEND_LOG" || true



echo


echo "============ FRONTEND LOG ============"


tail -50 "$FRONTEND_LOG" || true



}



backup(){


mkdir -p "$ROOT/backups"



tar -czf \
"$ROOT/backups/muteb_$(date +%F_%H%M).tar.gz" \
--exclude=venv \
--exclude=node_modules \
"$ROOT"



echo "Backup Completed"



}



menu(){


while true

do



clear



echo "================================"

echo " MUTEB SOC ENTERPRISE CONTROL"

echo "================================"



echo "1) START"

echo "2) STOP"

echo "3) RESTART"

echo "4) STATUS"

echo "5) HEALTH"

echo "6) LOGS"

echo "7) BACKUP"

echo "0) EXIT"



echo

read -p "OPTION: " op



case $op in


1) start ;;

2) stop ;;

3) restart ;;

4) status ;;

5) health ;;

6) logs ;;

7) backup ;;

0) exit ;;

*) echo "Wrong Option" ;;

esac



read -p "ENTER..."



done


}



case "${1:-menu}" in


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


backup)

backup

;;


menu)

menu

;;


*)

menu

;;


esac

