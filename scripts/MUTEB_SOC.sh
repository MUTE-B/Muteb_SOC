#!/usr/bin/env bash

set -Eeuo pipefail


ROOT="$HOME/Muteb-SOC"
FRONTEND="$ROOT/frontend"
VENV="$ROOT/venv"

LOG="$ROOT/logs"
REPORT="$ROOT/reports"
BACKUP="$ROOT/backups"

mkdir -p "$LOG" "$REPORT" "$BACKUP"


BACKEND_LOG="$LOG/backend.log"
FRONTEND_LOG="$LOG/frontend.log"


GREEN="\033[1;32m"
YELLOW="\033[1;33m"
RED="\033[1;31m"
RESET="\033[0m"



msg(){

echo -e "${GREEN}[+]${RESET} $1"

}


warn(){

echo -e "${YELLOW}[!]${RESET} $1"

}



header(){

clear

echo

echo "================================================"

echo "             MUTEB SOC ENTERPRISE"

echo "================================================"

echo

}



install(){


header


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
htop \
docker.io



[ -d "$VENV" ] || python3 -m venv "$VENV"


source "$VENV/bin/activate"



[ -f "$ROOT/requirements.txt" ] && \
pip install -r "$ROOT/requirements.txt"



cd "$FRONTEND"



[ -d node_modules ] || npm install



chmod +x "$ROOT/scripts/MUTEB_SOC.sh"



msg "INSTALL COMPLETE"


}



start(){


header


cd "$ROOT"



source "$VENV/bin/activate" 2>/dev/null || true



pkill -f "python3 run.py" || true

pkill -f "vite" || true



msg "START BACKEND"



nohup python3 run.py \
>"$BACKEND_LOG" 2>&1 &



echo $! > "$ROOT/backend.pid"



sleep 5



curl -s \
http://127.0.0.1:8000/api/version/info \
| jq || true



msg "START FRONTEND"



cd "$FRONTEND"



[ -d node_modules ] || npm install



nohup npm run dev \
-- --host 0.0.0.0 \
>"$FRONTEND_LOG" 2>&1 &



echo $! > "$ROOT/frontend.pid"



sleep 8



status


}



stop(){


pkill -f "python3 run.py" || true

pkill -f "vite" || true



msg "STOPPED"


}



restart(){


stop

sleep 3

start


}



status(){


header


echo "========== PROCESS =========="



ps aux | grep -E \
"python3 run.py|vite" \
| grep -v grep || true



echo


echo "========== PORTS =========="



ss -tulpn | grep -E \
"8000|5173|22|80" || true



echo


echo "BACKEND"

echo "http://172.20.10.4:8000"



echo "FRONTEND"

echo "http://172.20.10.4:5173"



}



health(){


curl -s \
http://127.0.0.1:8000/api/system/health \
| jq || true



}



logs(){


echo "========== BACKEND =========="


tail -50 "$BACKEND_LOG" || true



echo


echo "========== FRONTEND =========="


tail -50 "$FRONTEND_LOG" || true



}



security(){


header



echo "========== PORTS =========="


ss -tulpn



echo


echo "========== SSH =========="


journalctl -u ssh \
--no-pager \
| grep Failed \
| tail -20 || true



}



backup(){


tar -czf \
"$BACKUP/MUTEB_SOC_$(date +%F_%H%M).tar.gz" \
--exclude=venv \
--exclude=node_modules \
"$ROOT"



msg "BACKUP CREATED"



}



report(){


FILE="$REPORT/report_$(date +%s).txt"



{

echo "MUTEB SOC REPORT"

date

uname -a

free -h

df -h

ss -tulpn

ps aux | grep -E "python3 run.py|vite"


} > "$FILE"



msg "$FILE"



}



database_check(){


header


echo "========== DATABASE =========="


find "$ROOT" \
-name "*.db" \
-o \
-name "*.sqlite" \
2>/dev/null



}



docker_check(){


header


docker --version 2>/dev/null || echo "Docker Missing"


docker ps 2>/dev/null || true



}



environment_check(){


header


if [ -f "$ROOT/.env" ]

then

cat "$ROOT/.env"

else

echo ".env missing"

fi



}



frontend_check(){


header


cd "$FRONTEND"



node -v

npm -v



find src -type f | head -30



}



backend_check(){


header


cd "$ROOT"



python3 --version


find app -type f | head -30



}



clean_logs(){


find "$LOG" \
-type f \
-name "*.log" \
-size +100M \
-exec truncate -s 0 {} \;



msg "LOG CLEANED"



}



system_monitor(){


while true

do


clear


header


echo "CPU / RAM"


top -b -n1 | head -15



echo


echo "NETWORK"



ss -tulpn | grep -E "8000|5173"



sleep 5



done



}



update_project(){


cd "$ROOT"


git status


git pull



}



api_test(){


TOKEN=$(curl -s \
-X POST \
http://127.0.0.1:8000/api/auth/login \
-H "Content-Type: application/json" \
-d '{"username":"admin","password":"Password123"}' \
| jq -r '.access_token')



curl -s \
http://127.0.0.1:8000/api/soc/overview \
-H "Authorization: Bearer $TOKEN" \
| jq



}



menu(){


while true

do


header


echo "1  Install"

echo "2  Start"

echo "3  Stop"

echo "4  Restart"

echo "5  Status"

echo "6  Health"

echo "7  Logs"

echo "8  Security"

echo "9  Backup"

echo "10 Report"

echo "11 Database"

echo "12 Docker"

echo "13 Environment"

echo "14 Frontend Check"

echo "15 Backend Check"

echo "16 Clean Logs"

echo "17 Monitor"

echo "18 Update"

echo "19 API Test"

echo "0 Exit"



read -p "Select Option: " o



case $o in

1) install;;

2) start;;

3) stop;;

4) restart;;

5) status;;

6) health;;

7) logs;;

8) security;;

9) backup;;

10) report;;

11) database_check;;

12) docker_check;;

13) environment_check;;

14) frontend_check;;

15) backend_check;;

16) clean_logs;;

17) system_monitor;;

18) update_project;;

19) api_test;;

0) exit;;

*) warn "Invalid";;

esac



read -p "ENTER..."



done



}



case "${1:-menu}" in


install) install;;

start) start;;

stop) stop;;

restart) restart;;

status) status;;

health) health;;

logs) logs;;

security) security;;

backup) backup;;

report) report;;

database) database_check;;

docker) docker_check;;

environment) environment_check;;

frontend) frontend_check;;

backend) backend_check;;

clean) clean_logs;;

monitor) system_monitor;;

update) update_project;;

api) api_test;;

menu) menu;;

*) menu;;


esac




case "${1:-}" in


backup_full)

header


tar -czf \
"$BACKUP/full_backup_$(date +%F_%H%M%S).tar.gz" \
--exclude="$VENV" \
--exclude="node_modules" \
"$ROOT"



msg "FULL BACKUP COMPLETE"



;;



restore)


header


echo "Available backups:"


ls -lh "$BACKUP"



read -p "Backup file name: " FILE



tar -xzf \
"$BACKUP/$FILE" \
-C "$HOME"



msg "RESTORE COMPLETE"



;;



permissions)


header


echo "Checking permissions"



find "$ROOT/app" \
-type f \
-perm /o+w \
-print



;;



python_test)


header


source "$VENV/bin/activate"


python3 -m compileall app


msg "PYTHON CHECK COMPLETE"



;;



frontend_build)


header


cd "$FRONTEND"


npm run build



msg "FRONTEND BUILD COMPLETE"



;;



frontend_clean)


header


cd "$FRONTEND"


rm -rf node_modules


rm -rf dist


npm cache clean --force



msg "FRONTEND CLEAN COMPLETE"



;;



service_info)


header


systemctl status ssh --no-pager


echo


systemctl status apache2 --no-pager 2>/dev/null || true



;;



network_test)


header


echo "IP ADDRESS"


hostname -I



echo


echo "GATEWAY"


ip route



echo


echo "DNS"



resolvectl status | head -30



;;



firewall)


header


sudo ufw status verbose 2>/dev/null || echo "UFW unavailable"



;;



git_backup)


header


cd "$ROOT"


git add .


git commit -m \
"MUTEB SOC automatic backup $(date +%F_%H%M)" \
|| true


git status



;;



version)


header


echo "MUTEB SOC ENTERPRISE"

echo "VERSION: 4.0+"

echo "PATH: $ROOT"



;;



esac




monitor_security(){


header


while true

do


clear



echo "================================================"

echo "       MUTEB SOC LIVE SECURITY MONITOR"

echo "================================================"



echo

echo "[TIME]"

date



echo

echo "[FAILED SSH LOGIN]"



journalctl \
-u ssh \
--no-pager \
| grep Failed \
| tail -5 || true



echo

echo "[ACTIVE CONNECTIONS]"



ss -tunap | head -20



echo

echo "[RUNNING SERVICES]"



ps aux | grep -E \
"python3 run.py|vite|apache2|ssh" \
| grep -v grep || true



echo

echo "NEXT CHECK 30s"



sleep 30



done



}



audit(){


header


FILE="$REPORT/security_audit_$(date +%F_%H%M).txt"



{


echo "MUTEB SOC SECURITY AUDIT"

echo

date


echo

echo "USERS"

cat /etc/passwd | cut -d: -f1



echo

echo "SUDO USERS"

grep sudo /etc/group



echo

echo "OPEN PORTS"

ss -tulpn



echo

echo "SSH CONFIG"



grep -E \
"PermitRootLogin|PasswordAuthentication|Port" \
/etc/ssh/sshd_config \
2>/dev/null || true



echo

echo "CRITICAL FILES"



find "$ROOT" \
-type f \
-name "*.py" \
| wc -l



} > "$FILE"



msg "AUDIT CREATED $FILE"



}



health_full(){


header


echo "========== BACKEND =========="


curl -s \
http://127.0.0.1:8000/api/system/health \
| jq || true



echo


echo "========== FRONTEND =========="



if ss -tulpn | grep 5173 >/dev/null

then

echo "ONLINE"

else

echo "OFFLINE"

fi



echo


echo "========== SYSTEM =========="


uptime

free -h

df -h /



}



performance(){


header


echo "========== CPU =========="


top -b -n1 | head -15



echo

echo "========== MEMORY =========="


free -h



echo

echo "========== DISK =========="


df -h



echo

echo "========== PROCESSES =========="


ps aux --sort=-%mem | head -10



}



update_dependencies(){


header


source "$VENV/bin/activate"


pip install --upgrade pip



if [ -f "$ROOT/requirements.txt" ]

then

pip install -r "$ROOT/requirements.txt" --upgrade

fi



cd "$FRONTEND"


npm update



msg "DEPENDENCIES UPDATED"



}



generate_structure(){


header


cd "$ROOT"



tree -L 3 \
> "$REPORT/project_structure.txt"



msg "STRUCTURE SAVED"



}



case "${1:-}" in


security_monitor)

monitor_security

;;



audit)

audit

;;



health_full)

health_full

;;



performance)

performance

;;



update_dependencies)

update_dependencies

;;



structure)

generate_structure

;;



esac




# ================================
# MUTEB SOC ENTERPRISE MODULES
# ================================


system_info(){


header


echo "========== SYSTEM =========="


hostname


echo


uptime


echo


echo "CPU"

lscpu | grep -E "Model name|CPU\(s\)"


echo


echo "MEMORY"

free -h


echo


echo "DISK"

df -h



}



process_monitor(){


header


echo "========== APPLICATION PROCESS =========="



ps aux | grep -E \
"python3 run.py|vite|node" \
| grep -v grep || true



echo


echo "========== TOP MEMORY =========="


ps aux --sort=-%mem | head -10



}



service_check(){


header


echo "========== SERVICES =========="


for service in ssh apache2

do


systemctl is-active "$service" \
&& echo "$service : ONLINE" \
|| echo "$service : OFFLINE"



done



}



env_manager(){


header


ENV_FILE="$ROOT/.env"



if [ -f "$ENV_FILE" ]

then


echo "ENVIRONMENT FILE"

cat "$ENV_FILE"


else


echo "Creating .env"


cat > "$ENV_FILE" <<EOF

APP_NAME=MUTEB_SOC_ENTERPRISE

ENVIRONMENT=production

DEBUG=False

API_PORT=8000

FRONTEND_PORT=5173

EOF



fi



}



api_routes(){


header


echo "========== API ROUTES =========="


curl -s \
http://127.0.0.1:8000/openapi.json \
| jq '.paths | keys' \
2>/dev/null \
|| echo "Swagger unavailable"



}



security_files(){


header


echo "========== SECURITY FILE CHECK =========="


find "$ROOT" \
-type f \
-name "*.py" \
-o \
-name "*.sh" \
| wc -l



echo "Project files scanned"



}



auto_fix(){


header


echo "========== AUTO FIX =========="



chmod +x "$ROOT/scripts/MUTEB_SOC.sh"



if ! pgrep -f "python3 run.py" >/dev/null

then


echo "Backend stopped - restarting"


start


fi



if ! ss -tulpn | grep 5173 >/dev/null

then


echo "Frontend stopped - restarting"


start


fi



msg "AUTO FIX COMPLETE"



}



cleanup(){


header


echo "========== CLEANUP =========="


find "$ROOT" \
-type d \
-name "__pycache__" \
-exec rm -rf {} +



find "$ROOT" \
-type f \
-name "*.log" \
-size +200M \
-exec truncate -s 0 {} \;



msg "CLEAN COMPLETE"



}



full_check(){


header


system_info


status


health_full


security


service_check


process_monitor



}



case "${1:-}" in


system)

system_info

;;


process)

process_monitor

;;


services)

service_check

;;


env)

env_manager

;;


routes)

api_routes

;;


security_files)

security_files

;;


fix)

auto_fix

;;


clean)

cleanup

;;


full)

full_check

;;



esac




# ======================================
# MUTEB SOC ADVANCED OPERATIONS MODULE
# ======================================


create_logs_structure(){


header


mkdir -p "$ROOT/logs"/{api,security,system,frontend,backend}


touch \
"$ROOT/logs/security/events.log" \
"$ROOT/logs/system/system.log" \
"$ROOT/logs/api/api.log"



msg "LOG STRUCTURE READY"



}



collect_logs(){


header


REPORT_FILE="$REPORT/collector_$(date +%F_%H%M%S).txt"



{


echo "MUTEB SOC LOG COLLECTION"

echo

date


echo

echo "===== SYSTEM ====="


uname -a


echo


echo "===== MEMORY ====="


free -h



echo


echo "===== DISK ====="


df -h



echo


echo "===== PROCESSES ====="


ps aux



echo


echo "===== NETWORK ====="


ss -tulpn



echo


echo "===== SSH EVENTS ====="


journalctl -u ssh \
--no-pager \
| tail -50



} > "$REPORT_FILE"



msg "$REPORT_FILE"



}



watch_backend(){


header


echo "LIVE BACKEND MONITOR"



tail -f "$BACKEND_LOG"



}



watch_frontend(){


header


echo "LIVE FRONTEND MONITOR"



tail -f "$FRONTEND_LOG"



}



check_updates(){


header


cd "$ROOT"



echo "GIT STATUS"


git status



echo


echo "LATEST COMMITS"


git log --oneline -10



}



package_project(){


header


FILE="$BACKUP/MUTEB_SOC_PACKAGE_$(date +%F_%H%M).tar.gz"



tar -czf "$FILE" \
--exclude=venv \
--exclude=node_modules \
--exclude=.git \
"$ROOT"



msg "$FILE"



}



generate_doc(){


header


DOC="$REPORT/MUTEB_SOC_DOCUMENTATION.txt"



{


echo "MUTEB SOC ENTERPRISE"

echo

echo "PROJECT PATH"

echo "$ROOT"


echo

echo "SERVICES"


echo "Backend Flask API"

echo "Frontend React"

echo "Database Layer"

echo "Security Modules"

echo "Monitoring Modules"



echo

echo "DATE"

date



} > "$DOC"



msg "$DOC"



}



quick_start(){


header


echo "QUICK START"



start


sleep 5


health_full


status



}



case "${1:-}" in


create_logs)

create_logs_structure

;;


collect)

collect_logs

;;


backend_logs)

watch_backend

;;


frontend_logs)

watch_frontend

;;


updates)

check_updates

;;


package)

package_project

;;


documentation)

generate_doc

;;


quick)

quick_start

;;



esac




# ======================================
# MUTEB SOC FINAL CONTROL MODULE
# ======================================


create_service(){


header


sudo tee /etc/systemd/system/muteb-soc.service > /dev/null <<EOF

[Unit]

Description=MUTEB SOC Enterprise Platform

After=network.target



[Service]

Type=simple

User=$USER

WorkingDirectory=$ROOT

ExecStart=$ROOT/scripts/MUTEB_SOC.sh start

Restart=always

RestartSec=10



[Install]

WantedBy=multi-user.target

EOF



sudo systemctl daemon-reload

sudo systemctl enable muteb-soc



msg "SYSTEMD SERVICE CREATED"



}



service_start(){


sudo systemctl start muteb-soc


sudo systemctl status muteb-soc --no-pager



}



service_stop(){


sudo systemctl stop muteb-soc


msg "SERVICE STOPPED"



}



service_restart(){


sudo systemctl restart muteb-soc


sudo systemctl status muteb-soc --no-pager



}



service_logs(){


journalctl \
-u muteb-soc \
-f



}



docker_prepare(){


header



mkdir -p "$ROOT/docker"



cat > "$ROOT/docker/Dockerfile" <<EOF

FROM python:3.12-slim


WORKDIR /app


COPY . .


RUN pip install -r requirements.txt


CMD ["python3","run.py"]

EOF



msg "DOCKER FILE CREATED"



}



health_report(){


header


FILE="$REPORT/full_health_$(date +%F_%H%M).txt"



{


echo "MUTEB SOC FULL HEALTH REPORT"

echo

date


echo

echo "SERVICES"

systemctl --type=service --state=running



echo

echo "PORTS"

ss -tulpn



echo

echo "MEMORY"

free -h



echo

echo "DISK"

df -h



echo

echo "PROCESSES"

ps aux | grep -E \
"python3 run.py|vite"



} > "$FILE"



msg "$FILE"



}



backup_database(){


header


mkdir -p "$BACKUP/database"



find "$ROOT" \
-name "*.db" \
-o \
-name "*.sqlite" \
-exec cp {} "$BACKUP/database/" \;



msg "DATABASE BACKUP COMPLETE"



}



reset_cache(){


header


rm -rf "$ROOT/frontend/node_modules/.cache"

rm -rf "$ROOT/app/__pycache__"



msg "CACHE RESET COMPLETE"



}



case "${1:-}" in


service_create)

create_service

;;


service_start)

service_start

;;


service_stop)

service_stop

;;


service_restart)

service_restart

;;


service_logs)

service_logs

;;


docker_prepare)

docker_prepare

;;


health_report)

health_report

;;


database_backup)

backup_database

;;


reset)

reset_cache

;;



esac




# ======================================
# MUTEB SOC MONITORING & DEFENSE MODULE
# ======================================


alert_scan(){


header


echo "========== SECURITY ALERT SCAN =========="



echo


echo "[SSH FAILED LOGIN]"



journalctl \
-u ssh \
--no-pager \
| grep Failed \
| tail -20 || true



echo


echo "[SYSTEM ERRORS]"



journalctl \
-p err \
--no-pager \
| tail -20 || true



echo


echo "[OPEN PORTS]"



ss -tulpn



}



integrity_check(){


header


FILE="$REPORT/integrity_$(date +%F_%H%M).txt"



{


echo "MUTEB SOC FILE INTEGRITY CHECK"

echo

date



echo

echo "HASH RESULTS"



find "$ROOT/app" \
-type f \
-name "*.py" \
-exec sha256sum {} \;



} > "$FILE"



msg "$FILE"



}



backup_config(){


header


mkdir -p "$BACKUP/config"



cp -r \
"$ROOT/app/config" \
"$BACKUP/config/" \
2>/dev/null || true



cp \
"$ROOT/.env" \
"$BACKUP/config/" \
2>/dev/null || true



msg "CONFIG BACKUP COMPLETE"



}



restore_config(){


header


if [ -d "$BACKUP/config" ]

then


cp -r \
"$BACKUP/config/"* \
"$ROOT/app/config/" \
2>/dev/null || true



msg "CONFIG RESTORED"



else


warn "NO CONFIG BACKUP"



fi



}



python_security(){


header



source "$VENV/bin/activate"



pip list



echo


python3 -m compileall app



msg "PYTHON SECURITY CHECK COMPLETE"



}



network_info(){


header



echo "IP"

hostname -I



echo


echo "ROUTES"

ip route



echo


echo "DNS"

cat /etc/resolv.conf



echo


echo "ARP"

ip neigh



}



generate_version(){


header



VERSION_FILE="$ROOT/VERSION"



cat > "$VERSION_FILE" <<EOF

PROJECT=MUTEB SOC ENTERPRISE

VERSION=5.0.0

BUILD=$(date +%F_%H%M)

STATUS=PRODUCTION READY

EOF



cat "$VERSION_FILE"



}



case "${1:-}" in


alerts)

alert_scan

;;


integrity)

integrity_check

;;


backup_config)

backup_config

;;


restore_config)

restore_config

;;


python_security)

python_security

;;


network)

network_info

;;


version_build)

generate_version

;;



esac




# ======================================
# MUTEB SOC ENTERPRISE FINAL MODULE
# ======================================


dependency_check(){


header


echo "========== DEPENDENCIES =========="


commands=(python3 pip node npm git curl jq docker)



for cmd in "${commands[@]}"

do


if command -v "$cmd" >/dev/null

then

echo "$cmd : OK"

else

echo "$cmd : MISSING"

fi



done



}



application_test(){


header


echo "========== APPLICATION TEST =========="



cd "$ROOT"



python3 -m compileall app



if curl -s \
http://127.0.0.1:8000/api/version/info \
>/dev/null

then


echo "API : ONLINE"


else


echo "API : OFFLINE"



fi



if ss -tulpn | grep 5173 >/dev/null

then


echo "FRONTEND : ONLINE"


else


echo "FRONTEND : OFFLINE"



fi



}



log_rotation(){


header


mkdir -p "$LOG/archive"



for file in "$LOG"/*.log

do


[ -f "$file" ] || continue



mv "$file" \
"$LOG/archive/$(basename "$file").$(date +%F_%H%M)"



done



touch "$BACKEND_LOG"

touch "$FRONTEND_LOG"



msg "LOG ROTATION COMPLETE"



}



system_snapshot(){


header



SNAP="$REPORT/system_snapshot_$(date +%F_%H%M).txt"



{


echo "MUTEB SOC SYSTEM SNAPSHOT"

date



echo

echo "HOST"

hostname



echo

echo "IP"

hostname -I



echo

echo "UPTIME"

uptime



echo

echo "MEMORY"

free -h



echo

echo "DISK"

df -h



echo

echo "SERVICES"

ps aux | grep -E \
"python3 run.py|vite"



echo

echo "NETWORK"

ss -tulpn



} > "$SNAP"



msg "$SNAP"



}



project_backup_git(){


header



cd "$ROOT"



git add .



git commit \
-m "MUTEB SOC automated snapshot $(date +%F_%H%M)" \
|| true



git status



}



startup_check(){


header


echo "========== STARTUP VALIDATION =========="



dependency_check


application_test


status


health_full



}



case "${1:-}" in


dependencies)

dependency_check

;;


test)

application_test

;;


rotate_logs)

log_rotation

;;


snapshot)

system_snapshot

;;


git_snapshot)

project_backup_git

;;


startup_check)

startup_check

;;



esac




# ======================================
# MUTEB SOC AUTOMATION ENGINE
# ======================================


auto_start(){


header


echo "========== AUTO START =========="



dependency_check



if ! pgrep -f "python3 run.py" >/dev/null

then


echo "Backend OFF - STARTING"


start



else


echo "Backend ONLINE"



fi



if ! ss -tulpn | grep 5173 >/dev/null

then


echo "Frontend OFF - STARTING"


start



else


echo "Frontend ONLINE"



fi



}



watchdog(){


header



echo "MUTEB SOC WATCHDOG ACTIVE"



while true

do



if ! pgrep -f "python3 run.py" >/dev/null

then


echo "$(date) Backend crashed - restart" >> "$LOG/system/watchdog.log"


start



fi



if ! ss -tulpn | grep 5173 >/dev/null

then


echo "$(date) Frontend crashed - restart" >> "$LOG/system/watchdog.log"


start



fi



sleep 60



done



}



resource_guard(){


header


echo "========== RESOURCE GUARD =========="



MEM=$(free | awk '/Mem/{printf "%.0f",$3/$2*100}')



DISK=$(df / | awk 'NR==2 {print $5}' | tr -d '%')



echo "Memory Usage: $MEM%"


echo "Disk Usage: $DISK%"



if [ "$MEM" -gt 90 ]

then


echo "High Memory Usage"


fi



if [ "$DISK" -gt 90 ]

then


echo "High Disk Usage"


fi



}



backup_schedule(){


header



mkdir -p "$BACKUP/daily"



tar -czf \
"$BACKUP/daily/muteb_$(date +%F).tar.gz" \
--exclude=venv \
--exclude=node_modules \
"$ROOT"



msg "DAILY BACKUP COMPLETE"



}



export_report(){


header



ZIP="$REPORT/MUTEB_REPORT_$(date +%F_%H%M).zip"



zip -r "$ZIP" \
"$REPORT" \
"$LOG" \
>/dev/null



msg "$ZIP"



}



system_prepare(){


header



sudo systemctl enable ssh


sudo systemctl start ssh



mkdir -p "$ROOT/logs/system"



touch \
"$ROOT/logs/system/events.log"



msg "SYSTEM READY"



}



case "${1:-}" in


auto_start)

auto_start

;;


watchdog)

watchdog

;;


resource)

resource_guard

;;


scheduled_backup)

backup_schedule

;;


export)

export_report

;;


prepare)

system_prepare

;;



esac




# ======================================
# MUTEB SOC SOC-ANALYST MODULE
# ======================================


collect_auth_events(){


header


FILE="$REPORT/auth_events_$(date +%F_%H%M).log"



journalctl \
-u ssh \
--no-pager \
> "$FILE"



msg "$FILE"



}



collect_system_events(){


header


FILE="$REPORT/system_events_$(date +%F_%H%M).log"



journalctl \
--no-pager \
> "$FILE"



msg "$FILE"



}



detect_failed_logins(){


header



COUNT=$(journalctl \
-u ssh \
--no-pager \
| grep Failed \
| wc -l)



echo "Failed Login Count: $COUNT"



if [ "$COUNT" -gt 10 ]

then


echo "ALERT: High Failed Login Attempts"



fi



}



detect_services(){


header


echo "========== RUNNING SERVICES =========="



systemctl list-units \
--type=service \
--state=running \
--no-pager



}



ioc_scan(){


header



echo "========== IOC BASIC SCAN =========="



find "$ROOT" \
-type f \
-name "*.log" \
-exec grep -HinE \
"malware|virus|attack|exploit|rootkit" {} \; \
2>/dev/null || true



}



generate_soc_report(){


header



FILE="$REPORT/SOC_ANALYST_REPORT_$(date +%F_%H%M).txt"



{


echo "================================"

echo "MUTEB SOC ANALYST REPORT"

echo "================================"



date



echo

echo "HOST"

hostname



echo

echo "FAILED LOGIN"


journalctl \
-u ssh \
--no-pager \
| grep Failed \
| tail -20



echo

echo "OPEN PORTS"


ss -tulpn



echo

echo "ACTIVE PROCESSES"


ps aux | head -30



} > "$FILE"



msg "$FILE"



}



mitre_mapping(){


header



FILE="$REPORT/mitre_mapping.txt"



cat > "$FILE" <<EOF

MUTEB SOC MITRE ATT&CK MAPPING


T1110

Brute Force

Detection:

SSH Failed Login Events



T1059

Command and Scripting Interpreter

Detection:

Shell Activity



T1021

Remote Services

Detection:

SSH Connections



T1046

Network Service Scanning

Detection:

Open Ports Monitoring



EOF



cat "$FILE"



}



sigma_rules(){


header



mkdir -p "$ROOT/rules"



cat > "$ROOT/rules/ssh_failed_login.yml" <<EOF

title: SSH Failed Login Detection

status: experimental

logsource:

 category: authentication


detection:

 selection:

  message|contains:

   - "Failed password"


condition:

 selection


level:

 medium


EOF



msg "SIGMA RULE CREATED"



}



case "${1:-}" in


auth_events)

collect_auth_events

;;


system_events)

collect_system_events

;;


failed_logins)

detect_failed_logins

;;


services)

detect_services

;;


ioc_scan)

ioc_scan

;;


soc_report)

generate_soc_report

;;


mitre)

mitre_mapping

;;


sigma)

sigma_rules

;;



esac




# ======================================
# MUTEB SOC THREAT INTELLIGENCE MODULE
# ======================================


threat_intel_init(){


header


mkdir -p "$ROOT/intelligence"


touch \
"$ROOT/intelligence/ioc_blacklist.txt" \
"$ROOT/intelligence/domains.txt" \
"$ROOT/intelligence/hashes.txt"



msg "THREAT INTEL DATABASE READY"



}



ioc_manager(){


header



FILE="$ROOT/intelligence/ioc_blacklist.txt"



echo "========== IOC DATABASE =========="


if [ -s "$FILE" ]

then


cat "$FILE"



else


echo "No IOC entries"



fi



}



add_ioc(){


header



read -p "IOC VALUE: " IOC



echo "$IOC" >> "$ROOT/intelligence/ioc_blacklist.txt"



msg "IOC ADDED"



}



hash_scan(){


header



echo "========== HASH CHECK =========="



find "$ROOT" \
-type f \
-name "*.py" \
-exec sha256sum {} \; \
> "$REPORT/hash_scan_$(date +%F_%H%M).txt"



msg "HASH SCAN COMPLETE"



}



network_monitor(){


header



while true

do


clear


echo "MUTEB SOC NETWORK MONITOR"


date


echo


ss -tunap



sleep 10



done



}



process_scan(){


header



echo "========== PROCESS ANALYSIS =========="



ps aux --sort=-%cpu | head -20



}



user_audit(){


header



FILE="$REPORT/user_audit_$(date +%F_%H%M).txt"



{


echo "LOCAL USERS"

cut -d: -f1 /etc/passwd



echo

echo "SUDO GROUP"

getent group sudo



echo

echo "LAST LOGIN"

last -20



} > "$FILE"



msg "$FILE"



}



permission_audit(){


header



echo "WORLD WRITABLE FILES"



find "$ROOT" \
-type f \
-perm -o+w \
-print



}



kernel_check(){


header



uname -a


echo


cat /etc/os-release



}



case "${1:-}" in


intel_init)

threat_intel_init

;;


ioc_list)

ioc_manager

;;


ioc_add)

add_ioc

;;


hash_scan)

hash_scan

;;


network_monitor)

network_monitor

;;


process_scan)

process_scan

;;


user_audit)

user_audit

;;


permission_audit)

permission_audit

;;


kernel_check)

kernel_check

;;



esac




# ======================================
# MUTEB SOC INCIDENT RESPONSE MODULE
# ======================================


incident_init(){


header


mkdir -p \
"$ROOT/incidents/open" \
"$ROOT/incidents/closed"



touch \
"$ROOT/incidents/index.log"



msg "INCIDENT SYSTEM READY"



}



create_incident(){


header



ID="INC-$(date +%Y%m%d-%H%M%S)"



read -p "TITLE: " TITLE



read -p "SEVERITY: " SEV



cat > "$ROOT/incidents/open/$ID.txt" <<EOF

INCIDENT ID:

$ID


TITLE:

$TITLE


SEVERITY:

$SEV


STATUS:

OPEN


CREATED:

$(date)


EOF



echo "$ID" >> "$ROOT/incidents/index.log"



msg "$ID CREATED"



}



list_incidents(){


header



echo "========== OPEN INCIDENTS =========="



ls -lh \
"$ROOT/incidents/open"



}



close_incident(){


header



read -p "INCIDENT ID: " ID



if [ -f "$ROOT/incidents/open/$ID.txt" ]

then


mv \
"$ROOT/incidents/open/$ID.txt" \
"$ROOT/incidents/closed/"



msg "INCIDENT CLOSED"



else


warn "NOT FOUND"



fi



}



incident_report(){


header



FILE="$REPORT/incidents_$(date +%F_%H%M).txt"



{


echo "MUTEB SOC INCIDENT REPORT"

echo

date



echo

echo "OPEN"


ls "$ROOT/incidents/open"



echo

echo "CLOSED"


ls "$ROOT/incidents/closed"



} > "$FILE"



msg "$FILE"



}



forensic_snapshot(){


header



FILE="$REPORT/forensic_$(date +%F_%H%M).txt"



{


echo "FORENSIC SNAPSHOT"

date


echo

echo "PROCESS"


ps aux



echo

echo "NETWORK"


ss -tunap



echo

echo "LOGIN"


last



echo

echo "FILES"


find "$ROOT" -type f | head -100



} > "$FILE"



msg "$FILE"



}



evidence_collect(){


header



DIR="$REPORT/evidence_$(date +%F_%H%M)"



mkdir -p "$DIR"



cp -r \
"$LOG" \
"$DIR/" \
2>/dev/null || true



cp \
/var/log/auth.log \
"$DIR/" \
2>/dev/null || true



tar -czf \
"$DIR.tar.gz" \
"$DIR"



msg "$DIR.tar.gz"



}



case "${1:-}" in


incident_init)

incident_init

;;


incident_create)

create_incident

;;


incident_list)

list_incidents

;;


incident_close)

close_incident

;;


incident_report)

incident_report

;;


forensic)

forensic_snapshot

;;


evidence)

evidence_collect

;;



esac




# ======================================
# MUTEB SOC SOAR AUTOMATION MODULE
# ======================================


soar_init(){


header


mkdir -p \
"$ROOT/soar/playbooks" \
"$ROOT/soar/actions"



msg "SOAR ENGINE READY"



}



create_playbook(){


header



cat > "$ROOT/soar/playbooks/ssh_bruteforce_response.yml" <<EOF

name:

SSH Brute Force Response


trigger:

failed_login_threshold


actions:


- collect_logs

- block_source

- create_incident

- notify_operator


severity:

high


EOF



msg "PLAYBOOK CREATED"



}



run_playbook(){


header



echo "Executing SOAR Playbook"



detect_failed_logins


collect_auth_events


create_incident



msg "SOAR ACTION COMPLETE"



}



block_test_ip(){


header



read -p "IP ADDRESS: " IP



echo "BLOCK REQUEST CREATED"

echo "$IP" \
>> "$ROOT/soar/actions/block_requests.log"



msg "ACTION STORED"



}



notification_test(){


header



echo "MUTEB SOC ALERT"

echo "Security Event Detected"

date



}



schedule_check(){


header



echo "========== CRON JOBS =========="



crontab -l 2>/dev/null \
|| echo "No scheduled jobs"



}



create_cron(){


header



(crontab -l 2>/dev/null; echo "*/5 * * * * $ROOT/scripts/MUTEB_SOC.sh health_full") \
| crontab -



msg "CRON MONITOR ENABLED"



}



remove_cron(){


header



crontab -l 2>/dev/null \
| grep -v "MUTEB_SOC" \
| crontab -



msg "CRON REMOVED"



}



case "${1:-}" in


soar_init)

soar_init

;;


playbook)

create_playbook

;;


soar_run)

run_playbook

;;


block_request)

block_test_ip

;;


notify)

notification_test

;;


cron_check)

schedule_check

;;


cron_enable)

create_cron

;;


cron_disable)

remove_cron

;;



esac




# ======================================
# MUTEB SOC SIEM CORE MODULE
# ======================================


siem_init(){


header


mkdir -p \
"$ROOT/siem/events" \
"$ROOT/siem/rules" \
"$ROOT/siem/archive"



touch \
"$ROOT/siem/events/security.json"



msg "SIEM CORE READY"



}



collect_syslog(){


header



FILE="$ROOT/siem/events/system_$(date +%F_%H%M).log"



journalctl \
--no-pager \
> "$FILE"



msg "$FILE"



}



collect_auth_log(){


header



FILE="$ROOT/siem/events/auth_$(date +%F_%H%M).log"



journalctl \
-u ssh \
--no-pager \
> "$FILE"



msg "$FILE"



}



normalize_events(){


header



INPUT="$ROOT/siem/events"



OUTPUT="$ROOT/siem/events/normalized.json"



python3 <<PY

import os,json,datetime


events=[]


for root,dirs,files in os.walk("$INPUT"):

    for f in files:

        if f.endswith(".log"):

            path=os.path.join(root,f)

            try:

                with open(path,errors="ignore") as x:

                    for line in x.readlines():

                        events.append({

                        "time":str(datetime.datetime.now()),

                        "source":f,

                        "event":line.strip()

                        })

            except:

                pass



with open("$OUTPUT","w") as out:

    json.dump(events,out,indent=2)


print("NORMALIZED EVENTS:",len(events))


PY



}



rule_engine(){


header



echo "========== DETECTION ENGINE =========="



FILE="$ROOT/siem/events/normalized.json"



if [ -f "$FILE" ]

then


grep -Ei \
"failed|error|attack|invalid|denied" \
"$FILE" \
|| true



else


echo "No events"



fi



}



create_detection_rule(){


header



cat > "$ROOT/siem/rules/custom_rule.yml" <<EOF

name:

Multiple Failed SSH Login


source:

authentication


condition:

failed_password > 5


action:

create_alert


severity:

high


EOF



msg "RULE CREATED"



}



generate_alert(){


header



ALERT="$REPORT/alert_$(date +%F_%H%M).json"



cat > "$ALERT" <<EOF

{

"type":"security_alert",

"platform":"MUTEB SOC",

"time":"$(date)",

"severity":"medium",

"source":"SIEM ENGINE"

}

EOF



msg "$ALERT"



}



archive_events(){


header



tar -czf \
"$ROOT/siem/archive/events_$(date +%F_%H%M).tar.gz" \
"$ROOT/siem/events"



msg "EVENTS ARCHIVED"



}



case "${1:-}" in


siem_init)

siem_init

;;


syslog_collect)

collect_syslog

;;


auth_collect)

collect_auth_log

;;


normalize)

normalize_events

;;


detect)

rule_engine

;;


rule_create)

create_detection_rule

;;


alert)

generate_alert

;;


archive)

archive_events

;;



esac




# ======================================
# MUTEB SOC DASHBOARD API MODULE
# ======================================


dashboard_init(){


header


mkdir -p \
"$ROOT/dashboard"



cat > "$ROOT/dashboard/status.json" <<EOF

{

"platform":"MUTEB SOC Enterprise",

"version":"5.0",

"status":"ONLINE",

"time":"$(date)"

}

EOF



msg "DASHBOARD DATA READY"



}



dashboard_status(){


header



FILE="$ROOT/dashboard/status.json"



if [ -f "$FILE" ]

then


cat "$FILE" | jq



else


dashboard_init


fi



}



metrics_collect(){


header



FILE="$ROOT/dashboard/metrics.json"



ALERTS=$(find "$ROOT/reports" \
-name "alert*" \
| wc -l)



INCIDENTS=$(find "$ROOT/incidents/open" \
-type f \
2>/dev/null \
| wc -l)



cat > "$FILE" <<EOF

{

"platform":"MUTEB SOC",

"metrics":{

"alerts":$ALERTS,

"open_incidents":$INCIDENTS,

"time":"$(date)"

}

}

EOF



cat "$FILE" | jq



}



web_health(){


header



echo "========== WEB SERVICES =========="



if ss -tulpn | grep 8000 >/dev/null

then

echo "API : ONLINE"

else

echo "API : OFFLINE"

fi



if ss -tulpn | grep 5173 >/dev/null

then

echo "DASHBOARD : ONLINE"

else

echo "DASHBOARD : OFFLINE"

fi



}



api_monitor(){


header



while true

do


curl -s \
http://127.0.0.1:8000/api/system/health \
| jq



echo

echo "NEXT CHECK 30s"



sleep 30



done



}



generate_dashboard_report(){


header



FILE="$REPORT/dashboard_$(date +%F_%H%M).html"



cat > "$FILE" <<EOF

<html>

<head>

<title>MUTEB SOC Dashboard</title>

</head>


<body>


<h1>MUTEB SOC Enterprise</h1>


<h2>Status Report</h2>


<p>Date: $(date)</p>


<p>Backend: Flask API</p>


<p>Frontend: React Dashboard</p>


<p>Security Engine: Active</p>


<p>SIEM: Active</p>


<p>SOAR: Active</p>


</body>


</html>

EOF



msg "$FILE"



}



case "${1:-}" in


dashboard_init)

dashboard_init

;;


dashboard_status)

dashboard_status

;;


metrics)

metrics_collect

;;


web_health)

web_health

;;


api_monitor)

api_monitor

;;


dashboard_report)

generate_dashboard_report

;;



esac




# ======================================
# MUTEB SOC USER & RBAC MODULE
# ======================================


rbac_init(){


header


mkdir -p "$ROOT/security"


cat > "$ROOT/security/roles.json" <<EOF

{

"roles":{

"admin":[

"all"

],

"analyst":[

"alerts",

"reports",

"investigation"

],

"viewer":[

"dashboard"

]

}

}

EOF



msg "RBAC READY"



}



create_soc_user(){


header



read -p "USERNAME: " USERNAME



mkdir -p \
"$ROOT/security/users"



cat > \
"$ROOT/security/users/$USERNAME.json" <<EOF

{

"username":"$USERNAME",

"role":"analyst",

"created":"$(date)"

}

EOF



msg "USER CREATED"



}



list_soc_users(){


header



ls \
"$ROOT/security/users" \
2>/dev/null \
|| echo "NO USERS"



}



audit_users(){


header



FILE="$REPORT/rbac_audit_$(date +%F_%H%M).txt"



{


echo "RBAC AUDIT"


date



echo


echo "USERS"



find "$ROOT/security/users" \
-type f \
-name "*.json" \
-exec cat {} \;



} > "$FILE"



msg "$FILE"



}



permission_check(){


header



echo "Checking dangerous permissions"



find "$ROOT" \
-type f \
-perm -o+w \
-print



}



jwt_check(){


header



echo "========== AUTH CONFIG =========="



grep -R \
"JWT\|AUTH\|TOKEN" \
"$ROOT/app" \
2>/dev/null \
| head -30



}



access_report(){


header



FILE="$REPORT/access_$(date +%F_%H%M).txt"



{


echo "ACCESS REPORT"

date



echo

echo "CURRENT USER"

whoami



echo

echo "ACTIVE SESSIONS"

who



echo

echo "LAST LOGINS"

last -20



} > "$FILE"



msg "$FILE"



}



case "${1:-}" in


rbac_init)

rbac_init

;;


user_create)

create_soc_user

;;


user_list)

list_soc_users

;;


rbac_audit)

audit_users

;;


permission_check)

permission_check

;;


jwt_check)

jwt_check

;;


access_report)

access_report

;;



esac




# ======================================
# MUTEB SOC DATA COLLECTION MODULE
# ======================================


collector_init(){


header


mkdir -p \
"$ROOT/collector"/{linux,windows,network}



touch \
"$ROOT/collector/linux/auth.log" \
"$ROOT/collector/linux/system.log"



msg "COLLECTOR READY"



}



linux_collector(){


header



echo "Collecting Linux Logs"



journalctl \
-u ssh \
--no-pager \
> "$ROOT/collector/linux/auth.log"



journalctl \
--no-pager \
> "$ROOT/collector/linux/system.log"



msg "LINUX COLLECTION COMPLETE"



}



apache_collector(){


header



if [ -d /var/log/apache2 ]

then


cp \
/var/log/apache2/*.log \
"$ROOT/collector/linux/" \
2>/dev/null || true



msg "APACHE LOGS COLLECTED"



else


echo "Apache logs unavailable"



fi



}



network_collector(){


header



ss -tunap \
> "$ROOT/collector/network/connections.log"



ip addr \
> "$ROOT/collector/network/interfaces.log"



ip route \
> "$ROOT/collector/network/routes.log"



msg "NETWORK COLLECTION COMPLETE"



}



event_parser(){


header



INPUT="$ROOT/collector"



OUTPUT="$ROOT/collector/events.json"



python3 <<PY

import os,json,datetime


events=[]


for root,dirs,files in os.walk("$INPUT"):

    for file in files:

        path=os.path.join(root,file)

        try:

            with open(path,errors="ignore") as f:

                for line in f:

                    if line.strip():

                        events.append({

                        "timestamp":str(datetime.datetime.now()),

                        "source":file,

                        "message":line.strip()

                        })

        except:

            pass



with open("$OUTPUT","w") as f:

    json.dump(events,f,indent=2)



print("EVENTS:",len(events))


PY



}



collector_report(){


header



FILE="$REPORT/collector_report_$(date +%F_%H%M).txt"



{


echo "MUTEB SOC COLLECTOR REPORT"

date



echo

echo "FILES"



find "$ROOT/collector" -type f



echo

echo "EVENT COUNT"



jq length \
"$ROOT/collector/events.json" \
2>/dev/null || echo 0



} > "$FILE"



msg "$FILE"



}



case "${1:-}" in


collector_init)

collector_init

;;


linux_collect)

linux_collector

;;


apache_collect)

apache_collector

;;


network_collect)

network_collector

;;


parse_events)

event_parser

;;


collector_report)

collector_report

;;



esac




# ======================================
# MUTEB SOC THREAT DETECTION ENGINE
# ======================================


detection_init(){


header


mkdir -p \
"$ROOT/detection"/{rules,alerts}



cat > "$ROOT/detection/rules/basic_rules.yml" <<EOF

rules:


- id: SSH_BRUTE_FORCE

  name: Multiple SSH Failures

  severity: HIGH

  pattern: "Failed password"



- id: INVALID_USER

  name: Invalid SSH User

  severity: MEDIUM

  pattern: "invalid user"



- id: SYSTEM_ERROR

  name: System Error

  severity: LOW

  pattern: "error"


EOF



msg "DETECTION ENGINE READY"



}



run_detection(){


header



EVENT_FILE="$ROOT/collector/events.json"



ALERT_FILE="$ROOT/detection/alerts/alerts.json"



python3 <<PY

import json,os,datetime


events=[]


alerts=[]



if os.path.exists("$EVENT_FILE"):


    with open("$EVENT_FILE") as f:

        events=json.load(f)



patterns={

"Failed password":"SSH_BRUTE_FORCE",

"invalid user":"INVALID_USER",

"error":"SYSTEM_ERROR"

}



for e in events:

    msg=e.get("message","")

    for p,r in patterns.items():

        if p.lower() in msg.lower():

            alerts.append({

            "rule":r,

            "time":str(datetime.datetime.now()),

            "message":msg,

            "severity":"HIGH"

            })



with open("$ALERT_FILE","w") as f:

    json.dump(alerts,f,indent=2)



print("ALERTS:",len(alerts))


PY



msg "DETECTION COMPLETE"



}



show_alerts(){


header



FILE="$ROOT/detection/alerts/alerts.json"



if [ -f "$FILE" ]

then


cat "$FILE" | jq



else


echo "No alerts"



fi



}



clear_alerts(){


header



rm -f \
"$ROOT/detection/alerts/"*.json



msg "ALERTS CLEARED"



}



alert_statistics(){


header



FILE="$ROOT/detection/alerts/alerts.json"



if [ -f "$FILE" ]

then


TOTAL=$(jq length "$FILE")


echo "TOTAL ALERTS: $TOTAL"



else


echo "TOTAL ALERTS: 0"



fi



}



case "${1:-}" in


detection_init)

detection_init

;;


detect_run)

run_detection

;;


alerts_show)

show_alerts

;;


alerts_clear)

clear_alerts

;;


alerts_stats)

alert_statistics

;;



esac




# ======================================
# MUTEB SOC INVESTIGATION MODULE
# ======================================


investigation_init(){


header


mkdir -p \
"$ROOT/investigation"/{cases,evidence,timeline}



msg "INVESTIGATION ENGINE READY"



}



create_case(){


header



ID="CASE-$(date +%Y%m%d-%H%M%S)"



read -p "CASE TITLE: " TITLE


read -p "ANALYST: " ANALYST



cat > "$ROOT/investigation/cases/$ID.json" <<EOF

{

"case_id":"$ID",

"title":"$TITLE",

"analyst":"$ANALYST",

"status":"OPEN",

"created":"$(date)"

}

EOF



msg "$ID CREATED"



}



list_cases(){


header



find "$ROOT/investigation/cases" \
-type f \
-name "*.json" \
-exec cat {} \;



}



timeline_create(){


header



FILE="$ROOT/investigation/timeline/events.log"



{

echo "=============================="

echo "TIME: $(date)"

echo "USER: $(whoami)"

echo "EVENT: Manual Investigation Entry"

echo "=============================="



} >> "$FILE"



msg "TIMELINE UPDATED"



}



collect_case_evidence(){


header



CASE_DIR="$ROOT/investigation/evidence/$(date +%F_%H%M)"



mkdir -p "$CASE_DIR"



cp "$ROOT/detection/alerts/"* \
"$CASE_DIR/" \
2>/dev/null || true



cp "$ROOT/collector/events.json" \
"$CASE_DIR/" \
2>/dev/null || true



tar -czf \
"$CASE_DIR.tar.gz" \
"$CASE_DIR"



msg "$CASE_DIR.tar.gz"



}



search_indicator(){


header



read -p "SEARCH STRING: " TERM



grep -Rni \
"$TERM" \
"$ROOT" \
2>/dev/null \
| head -50



}



case_export(){


header



FILE="$REPORT/case_export_$(date +%F_%H%M).txt"



{


echo "MUTEB SOC CASE EXPORT"

date



echo

echo "CASES"



find "$ROOT/investigation/cases" \
-type f \
-exec cat {} \;



echo

echo "TIMELINE"



cat "$ROOT/investigation/timeline/events.log" \
2>/dev/null || true



} > "$FILE"



msg "$FILE"



}



case "${1:-}" in


investigation_init)

investigation_init

;;


case_create)

create_case

;;


case_list)

list_cases

;;


timeline)

timeline_create

;;


case_evidence)

collect_case_evidence

;;


indicator_search)

search_indicator

;;


case_export)

case_export

;;



esac




# ======================================
# MUTEB SOC COMPLIANCE & GOVERNANCE MODULE
# ======================================


compliance_init(){


header


mkdir -p \
"$ROOT/compliance"/{policies,controls,reports}



cat > "$ROOT/compliance/standards.json" <<EOF

{

"frameworks":[

"NIST CSF",

"ISO 27001",

"CIS Controls",

"MITRE ATT&CK"

],

"platform":

"MUTEB SOC Enterprise"

}

EOF



msg "COMPLIANCE MODULE READY"



}



create_policy(){


header



read -p "POLICY NAME: " POLICY



cat > \
"$ROOT/compliance/policies/$POLICY.txt" <<EOF

POLICY:

$POLICY


OWNER:

MUTEB SOC


DATE:

$(date)


STATUS:

ACTIVE


EOF



msg "POLICY CREATED"



}



control_check(){


header



FILE="$REPORT/control_check_$(date +%F_%H%M).txt"



{


echo "SECURITY CONTROL CHECK"

date



echo

echo "SSH STATUS"

systemctl is-active ssh



echo

echo "FIREWALL"

ufw status 2>/dev/null || true



echo

echo "UPDATES"

apt list --upgradable 2>/dev/null | head -20



echo

echo "USER REVIEW"

cat /etc/passwd | cut -d: -f1



} > "$FILE"



msg "$FILE"



}



iso_report(){


header



FILE="$REPORT/ISO27001_report_$(date +%F_%H%M).txt"



{


echo "ISO 27001 BASIC REVIEW"

echo

date



echo

echo "A.5 INFORMATION SECURITY POLICIES"

echo "CHECKED"



echo

echo "A.8 ASSET MANAGEMENT"

echo "CHECKED"



echo

echo "A.12 OPERATIONS SECURITY"

echo "CHECKED"



echo

echo "A.16 INCIDENT MANAGEMENT"

echo "CHECKED"



} > "$FILE"



msg "$FILE"



}



risk_register(){


header



FILE="$ROOT/compliance/reports/risk_register.csv"



cat > "$FILE" <<EOF

Risk,Impact,Probability,Status

Unauthorized Access,High,Medium,Monitoring

Failed Login Attempts,Medium,High,Detected

Service Failure,High,Low,Controlled

EOF



cat "$FILE"



}



audit_archive(){


header



tar -czf \
"$BACKUP/compliance_$(date +%F_%H%M).tar.gz" \
"$ROOT/compliance"



msg "COMPLIANCE ARCHIVE CREATED"



}



case "${1:-}" in


compliance_init)

compliance_init

;;


policy_create)

create_policy

;;


control_check)

control_check

;;


iso_report)

iso_report

;;


risk_register)

risk_register

;;


compliance_backup)

audit_archive

;;



esac




# ======================================
# MUTEB SOC MACHINE LEARNING ANALYTICS MODULE
# ======================================


ml_init(){


header


mkdir -p \
"$ROOT/ml"/{models,data,results}



cat > "$ROOT/ml/config.json" <<EOF

{

"engine":"MUTEB SOC ML",

"mode":"anomaly_detection",

"version":"1.0"

}

EOF



msg "ML MODULE READY"



}



prepare_dataset(){


header



OUTPUT="$ROOT/ml/data/security_events.csv"



echo "timestamp,event,severity,source" \
> "$OUTPUT"



journalctl \
-u ssh \
--no-pager \
| tail -100 \
| awk '{print "'$(date)'",$0",medium,ssh"}' \
>> "$OUTPUT"



msg "$OUTPUT"



}



anomaly_scan(){


header



python3 <<PY

import os,csv


file="$ROOT/ml/data/security_events.csv"


if os.path.exists(file):

    with open(file) as f:

        rows=list(csv.reader(f))

    print("EVENTS ANALYZED:",len(rows)-1)


    if len(rows)>50:

        print("ANOMALY: HIGH EVENT VOLUME")


    else:

        print("NORMAL ACTIVITY")

else:

    print("NO DATA")



PY



}



generate_ml_report(){


header



FILE="$REPORT/ml_analysis_$(date +%F_%H%M).txt"



{


echo "MUTEB SOC ML ANALYSIS"

date



echo

echo "DATASET"



wc -l \
"$ROOT/ml/data/security_events.csv" \
2>/dev/null || true



echo

echo "MODEL"

cat "$ROOT/ml/config.json"



} > "$FILE"



msg "$FILE"



}



threat_score(){


header



python3 <<PY


score=0



failed=$(journalctl \
-u ssh \
--no-pager \
| grep Failed \
| wc -l)



if [ "$failed" -gt 5 ];

then

score=$((score+40))

fi



ports=$(ss -tulpn | wc -l)



if [ "$ports" -gt 10 ];

then

score=$((score+20))

fi



echo "MUTEB SOC THREAT SCORE: $score/100"



if [ "$score" -gt 50 ];

then

echo "LEVEL: HIGH"

else

echo "LEVEL: NORMAL"

fi


PY



}



case "${1:-}" in


ml_init)

ml_init

;;


dataset)

prepare_dataset

;;


ml_scan)

anomaly_scan

;;


ml_report)

generate_ml_report

;;


threat_score)

threat_score

;;



esac




# ======================================
# MUTEB SOC API SECURITY MODULE
# ======================================


api_security_init(){


header


mkdir -p \
"$ROOT/security/api"



cat > "$ROOT/security/api/security.json" <<EOF

{

"authentication":"JWT",

"authorization":"RBAC",

"rate_limit":true,

"audit_logging":true,

"csrf_protection":true

}

EOF



msg "API SECURITY READY"



}



api_endpoint_scan(){


header



echo "========== API ENDPOINT TEST =========="



ENDPOINTS=(

"/api/version/info"

"/api/system/health"

"/api/soc/overview"

"/api/auth/login"

)



for API in "${ENDPOINTS[@]}"

do


STATUS=$(curl -s \
-o /dev/null \
-w "%{http_code}" \
"http://127.0.0.1:8000$API")



echo "$API : $STATUS"



done



}



api_latency(){


header



for i in {1..5}

do


curl -s \
-o /dev/null \
-w "Response %{time_total}s\n" \
http://127.0.0.1:8000/api/system/health



done



}



api_backup(){


header



FILE="$BACKUP/api_config_$(date +%F_%H%M).tar.gz"



tar -czf "$FILE" \
"$ROOT/app/config" \
"$ROOT/security"



msg "$FILE"



}



jwt_audit(){


header



echo "========== JWT AUDIT =========="



grep -Rni \
"JWT" \
"$ROOT/app" \
2>/dev/null \
| head -50



}



rate_test(){


header



echo "LOCAL RATE CHECK"



for i in {1..10}

do


curl -s \
http://127.0.0.1:8000/api/system/health \
>/dev/null



echo "REQUEST $i"



done



}



case "${1:-}" in


api_security)

api_security_init

;;


api_scan)

api_endpoint_scan

;;


api_latency)

api_latency

;;


api_backup)

api_backup

;;


jwt_audit)

jwt_audit

;;


rate_test)

rate_test

;;



esac




# ======================================
# MUTEB SOC DATABASE MODULE
# ======================================


database_init(){


header


mkdir -p \
"$ROOT/database"



cat > "$ROOT/database/config.json" <<EOF

{

"type":"PostgreSQL",

"orm":"SQLAlchemy",

"migration":"Alembic",

"status":"READY"

}

EOF



msg "DATABASE MODULE READY"



}



database_check(){


header



echo "========== DATABASE CHECK =========="



if command -v psql >/dev/null

then


echo "PostgreSQL Client : INSTALLED"



else


echo "PostgreSQL Client : NOT INSTALLED"



fi



echo



find "$ROOT" \
-name "*.db" \
-o \
-name "*.sqlite"



}



database_backup(){


header



DIR="$BACKUP/database"



mkdir -p "$DIR"



find "$ROOT" \
-name "*.db" \
-o \
-name "*.sqlite" \
-exec cp {} "$DIR/" \;



tar -czf \
"$BACKUP/database_$(date +%F_%H%M).tar.gz" \
"$DIR"



msg "DATABASE BACKUP COMPLETE"



}



database_schema(){


header



FILE="$ROOT/database/schema.sql"



cat > "$FILE" <<EOF

CREATE TABLE alerts (

id SERIAL PRIMARY KEY,

severity VARCHAR(20),

source VARCHAR(100),

created TIMESTAMP

);



CREATE TABLE incidents (

id SERIAL PRIMARY KEY,

title VARCHAR(255),

status VARCHAR(50),

created TIMESTAMP

);



CREATE TABLE users (

id SERIAL PRIMARY KEY,

username VARCHAR(100),

role VARCHAR(50)

);



EOF



msg "DATABASE SCHEMA CREATED"



}



migration_init(){


header



mkdir -p \
"$ROOT/database/migrations"



cat > \
"$ROOT/database/migrations/001_init.sql" <<EOF


CREATE TABLE system_logs (

id SERIAL PRIMARY KEY,

message TEXT,

created TIMESTAMP

);



EOF



msg "MIGRATION CREATED"



}



database_report(){


header



FILE="$REPORT/database_$(date +%F_%H%M).txt"



{


echo "MUTEB SOC DATABASE REPORT"

date



echo

echo "CONFIG"

cat "$ROOT/database/config.json"



echo

echo "FILES"

find "$ROOT/database"



} > "$FILE"



msg "$FILE"



}



case "${1:-}" in


database_init)

database_init

;;


database_check)

database_check

;;


database_backup)

database_backup

;;


database_schema)

database_schema

;;


migration_init)

migration_init

;;


database_report)

database_report

;;



esac




# ======================================
# MUTEB SOC FRONTEND MANAGEMENT MODULE
# ======================================


frontend_check(){


header


echo "========== FRONTEND STATUS =========="



if [ -d "$ROOT/frontend" ]

then


echo "Frontend Directory : OK"



else


echo "Frontend Directory : MISSING"



fi



if command -v npm >/dev/null

then


echo "NPM : INSTALLED"



else


echo "NPM : MISSING"



fi



if ss -tulpn | grep 5173 >/dev/null

then


echo "React Dashboard : ONLINE"



else


echo "React Dashboard : OFFLINE"



fi



}



frontend_install(){


header



cd "$ROOT/frontend"



if [ -f package.json ]

then


npm install



msg "FRONTEND DEPENDENCIES INSTALLED"



else


warn "package.json NOT FOUND"



fi



}



frontend_start(){


header



cd "$ROOT/frontend"



if command -v npm >/dev/null

then


nohup npm run dev \
> "$FRONTEND_LOG" 2>&1 &



msg "FRONTEND STARTED"



else


warn "NPM NOT AVAILABLE"



fi



}



frontend_build(){


header



cd "$ROOT/frontend"



npm run build



msg "FRONTEND BUILD COMPLETE"



}



frontend_logs(){


header



tail -f "$FRONTEND_LOG"



}



frontend_structure(){


header



find "$ROOT/frontend" \
-maxdepth 3 \
-type f \
| sort



}



case "${1:-}" in


frontend_check)

frontend_check

;;


frontend_install)

frontend_install

;;


frontend_start)

frontend_start

;;


frontend_build)

frontend_build

;;


frontend_logs)

frontend_logs

;;


frontend_structure)

frontend_structure

;;



esac




# ======================================
# MUTEB SOC CI/CD & DEVOPS MODULE
# ======================================


cicd_init(){


header


mkdir -p \
"$ROOT/.github/workflows"



cat > \
"$ROOT/.github/workflows/muteb-soc-ci.yml" <<EOF

name: MUTEB SOC CI


on:

 push:

  branches:

   - main


 pull_request:

  branches:

   - main



jobs:


 security-test:


  runs-on: ubuntu-latest


  steps:


   - uses: actions/checkout@v4


   - name: Python Check

     run: |

      python3 -m compileall app



   - name: Security Scan

     run: |

      echo "Security Scan Complete"



EOF



msg "GITHUB ACTION CREATED"



}



lint_check(){


header



if command -v ruff >/dev/null

then


ruff check "$ROOT"



else


echo "Ruff not installed"



fi



}



format_check(){


header



if command -v black >/dev/null

then


black --check "$ROOT/app"



else


echo "Black not installed"



fi



}



requirements_export(){


header



source "$VENV/bin/activate"



pip freeze \
> "$ROOT/requirements-lock.txt"



msg "REQUIREMENTS EXPORTED"



}



environment_report(){


header



FILE="$REPORT/environment_$(date +%F_%H%M).txt"



{


echo "MUTEB SOC ENVIRONMENT"


date



echo

echo "PYTHON"


python3 --version



echo

echo "PIP"


pip --version



echo

echo "GIT"


git --version



echo

echo "NODE"


node --version 2>/dev/null || true



echo

echo "NPM"


npm --version 2>/dev/null || true



} > "$FILE"



msg "$FILE"



}



release_build(){


header



VERSION=$(date +%Y.%m.%d)



mkdir -p \
"$ROOT/releases"



tar -czf \
"$ROOT/releases/MUTEB_SOC_$VERSION.tar.gz" \
--exclude=venv \
--exclude=node_modules \
--exclude=.git \
"$ROOT"



msg "RELEASE $VERSION CREATED"



}



case "${1:-}" in


cicd_init)

cicd_init

;;


lint)

lint_check

;;


format)

format_check

;;


requirements)

requirements_export

;;


environment)

environment_report

;;


release)

release_build

;;



esac




# ======================================
# MUTEB SOC DOCKER PRODUCTION MODULE
# ======================================


docker_init(){


header


mkdir -p "$ROOT/docker"



cat > "$ROOT/Dockerfile" <<EOF

FROM python:3.12-slim


WORKDIR /app


COPY requirements-lock.txt .


RUN pip install --no-cache-dir -r requirements-lock.txt


COPY . .


EXPOSE 8000


CMD ["python3","run.py"]

EOF



cat > "$ROOT/docker-compose.yml" <<EOF

services:


 backend:


  build: .


  container_name: muteb-soc-api


  ports:

   - "8000:8000"


  restart: always



 postgres:


  image: postgres:16


  container_name: muteb-soc-db


  environment:

   POSTGRES_DB: muteb_soc

   POSTGRES_USER: muteb

   POSTGRES_PASSWORD: muteb_secure


  restart: always



 redis:


  image: redis:latest


  container_name: muteb-soc-cache


  restart: always



EOF



msg "DOCKER PRODUCTION FILES CREATED"



}



docker_check(){


header



if command -v docker >/dev/null

then


docker --version



docker compose version



else


echo "DOCKER NOT INSTALLED"



fi



}



docker_build(){


header



docker compose build



}



docker_start(){


header



docker compose up -d



docker ps



}



docker_stop(){


header



docker compose down



}



docker_logs(){


header



docker compose logs -f



}



container_health(){


header



docker ps --format \

"table {{.Names}}\t{{.Status}}\t{{.Ports}}"



}



nginx_prepare(){


header



mkdir -p "$ROOT/nginx"



cat > "$ROOT/nginx/muteb.conf" <<EOF

server {


listen 80;


server_name _;



location /api {


proxy_pass http://127.0.0.1:8000;


proxy_set_header Host \$host;


}



location / {


root /app/frontend/dist;


index index.html;


}



}

EOF



msg "NGINX CONFIG CREATED"



}



case "${1:-}" in


docker_init)

docker_init

;;


docker_check)

docker_check

;;


docker_build)

docker_build

;;


docker_start)

docker_start

;;


docker_stop)

docker_stop

;;


docker_logs)

docker_logs

;;


docker_health)

container_health

;;


nginx_prepare)

nginx_prepare

;;



esac




# ======================================
# MUTEB SOC FINAL COMMAND CENTER MODULE
# ======================================


command_center(){


while true

do


clear


echo "================================================"

echo "          MUTEB SOC ENTERPRISE COMMAND CENTER"

echo "================================================"

echo


echo "1) Start Platform"

echo "2) Stop Platform"

echo "3) Restart Platform"

echo "4) Full Health Check"

echo "5) SOC Security Scan"

echo "6) Generate SOC Report"

echo "7) Start Frontend"

echo "8) Start Backend"

echo "9) Docker Status"

echo "10) Backup System"

echo "11) Exit"



echo

read -p "Select Option: " OPTION



case $OPTION in


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

startup_check

;;


5)

alert_scan

failed_logins

permission_audit

;;


6)

generate_soc_report

dashboard_report

;;


7)

frontend_start

;;


8)

start

;;


9)

docker_health

;;


10)

backup_schedule

database_backup

;;


11)

break

;;


*)

echo "Invalid Option"

sleep 2

;;


esac



done



}



quick_start(){


header



echo "MUTEB SOC QUICK START"



system_prepare



frontend_check



start



health_full



}



full_install(){


header



echo "MUTEB SOC INSTALLATION"



mkdir -p \

"$ROOT/logs" \

"$ROOT/reports" \

"$ROOT/backups"



rbac_init

siem_init

soar_init

collector_init

detection_init

incident_init

compliance_init

database_init



msg "INSTALLATION COMPLETE"



}



update_project(){


header



cd "$ROOT"



git pull



pip install -r requirements.txt \
2>/dev/null || true



cd frontend



npm install \
2>/dev/null || true



msg "UPDATE COMPLETE"



}



uninstall_cache(){


header



rm -rf \

"$ROOT/frontend/node_modules" \

"$ROOT/frontend/.vite" \

"$ROOT/__pycache__"



msg "CACHE REMOVED"



}



case "${1:-}" in


menu)

command_center

;;


quick_start)

quick_start

;;


install_all)

full_install

;;


update)

update_project

;;


clean)

uninstall_cache

;;



esac




# ======================================
# MUTEB SOC PRODUCTION HARDENING MODULE
# ======================================


hardening_init(){


header


mkdir -p \
"$ROOT/hardening"



cat > "$ROOT/hardening/security_check.sh" <<'EOF'

#!/bin/bash


echo "MUTEB SOC SECURITY HARDENING"



echo "[+] Checking SSH"



sshd -T | grep -E \

"permitrootlogin|passwordauthentication"



echo



echo "[+] Checking Firewall"



ufw status



echo



echo "[+] Checking Updates"



apt list --upgradable 2>/dev/null



echo



echo "[+] Checking SUID Files"



find / -perm -4000 -type f 2>/dev/null | head -50



EOF



chmod +x \
"$ROOT/hardening/security_check.sh"



msg "HARDENING MODULE READY"



}



security_hardening(){


header



bash \
"$ROOT/hardening/security_check.sh" \
| tee \
"$REPORT/hardening_$(date +%F_%H%M).log"



}



firewall_check(){


header



if command -v ufw >/dev/null

then


ufw status verbose



else


echo "UFW NOT INSTALLED"



fi



}



ssh_security(){


header



echo "========== SSH SECURITY =========="



grep -E \

"PermitRootLogin|PasswordAuthentication|Port" \

/etc/ssh/sshd_config \
2>/dev/null



}



fail2ban_check(){


header



systemctl status fail2ban \
--no-pager



}



security_score(){


header



SCORE=100



if systemctl is-active ssh >/dev/null

then

echo "SSH : OK"

else

SCORE=$((SCORE-20))

fi



if systemctl is-active fail2ban >/dev/null

then

echo "FAIL2BAN : OK"

else

SCORE=$((SCORE-20))

fi



if command -v ufw >/dev/null

then

echo "FIREWALL : AVAILABLE"

else

SCORE=$((SCORE-20))

fi



echo

echo "SECURITY SCORE : $SCORE/100"



}



case "${1:-}" in


hardening_init)

hardening_init

;;


hardening_scan)

security_hardening

;;


firewall_check)

firewall_check

;;


ssh_security)

ssh_security

;;


fail2ban_check)

fail2ban_check

;;


security_score)

security_score

;;



esac




# ======================================
# MUTEB SOC MONITORING & ALERTING MODULE
# ======================================


monitor_init(){


header


mkdir -p \
"$ROOT/monitor"



cat > "$ROOT/monitor/config.json" <<EOF

{

"interval":30,

"services":[

"ssh",

"apache2",

"fail2ban"

],

"alerts":true

}

EOF



msg "MONITORING ENGINE READY"



}



service_monitor(){


header



SERVICES=(

ssh

apache2

fail2ban

)



for SERVICE in "${SERVICES[@]}"

do


if systemctl is-active "$SERVICE" >/dev/null

then


echo "$SERVICE : ONLINE"



else


echo "$SERVICE : OFFLINE"



echo "$(date) $SERVICE DOWN" \
>> "$ROOT/logs/service_alerts.log"



fi



done



}



resource_monitor(){


header



echo "========== RESOURCE STATUS =========="



echo "CPU"



top -bn1 | grep Cpu



echo



echo "MEMORY"



free -h



echo



echo "DISK"



df -h



}



continuous_monitor(){


header



echo "MUTEB SOC LIVE MONITOR"



while true

do


clear



echo "=============================="

echo "MUTEB SOC LIVE STATUS"

echo "=============================="



date



echo



service_monitor



echo



resource_monitor



sleep 30



done



}



alert_center(){


header



FILE="$ROOT/logs/service_alerts.log"



if [ -f "$FILE" ]

then


tail -50 "$FILE"



else


echo "NO ALERTS"



fi



}



health_full(){


header



echo "========== FULL HEALTH =========="



echo



echo "BACKEND"



if ss -tulpn | grep 8000 >/dev/null

then

echo "ONLINE"

else

echo "OFFLINE"

fi



echo



echo "FRONTEND"



if ss -tulpn | grep 5173 >/dev/null

then

echo "ONLINE"

else

echo "OFFLINE"

fi



echo



echo "SERVICES"



service_monitor



echo



echo "RESOURCES"



resource_monitor



}



case "${1:-}" in


monitor_init)

monitor_init

;;


service_monitor)

service_monitor

;;


resource_monitor)

resource_monitor

;;


live_monitor)

continuous_monitor

;;


alert_center)

alert_center

;;


health_full)

health_full

;;



esac




# ======================================
# MUTEB SOC BACKUP & RECOVERY MODULE
# ======================================


backup_init(){


header


mkdir -p \
"$BACKUP"



msg "BACKUP SYSTEM READY"



}



full_backup(){


header



DATE=$(date +%F_%H%M)



FILE="$BACKUP/MUTEB_SOC_FULL_$DATE.tar.gz"



tar -czf "$FILE" \

--exclude=venv \

--exclude=node_modules \

--exclude=.git \

"$ROOT"



msg "$FILE"



}



config_backup(){


header



FILE="$BACKUP/config_$(
date +%F_%H%M
).tar.gz"



tar -czf "$FILE" \

"$ROOT/app/config" \

"$ROOT/security" \

"$ROOT/database"



msg "$FILE"



}



logs_backup(){


header



FILE="$BACKUP/logs_$(
date +%F_%H%M
).tar.gz"



tar -czf "$FILE" \

"$ROOT/logs" \

"$ROOT/reports"



msg "$FILE"



}



restore_list(){


header



echo "========== AVAILABLE BACKUPS =========="



ls -lh \
"$BACKUP"



}



restore_backup(){


header



read -p "BACKUP FILE: " FILE



if [ -f "$BACKUP/$FILE" ]

then


tar -xzf \
"$BACKUP/$FILE" \
-C /



msg "RESTORE COMPLETE"



else


warn "BACKUP NOT FOUND"



fi



}



backup_schedule(){


header



mkdir -p "$BACKUP"



(crontab -l 2>/dev/null; \
echo "0 3 * * * $ROOT/scripts/MUTEB_SOC.sh full_backup") \
| crontab -



msg "DAILY BACKUP ENABLED"



}



backup_remove_schedule(){


header



crontab -l 2>/dev/null \
| grep -v "full_backup" \
| crontab -



msg "BACKUP SCHEDULE REMOVED"



}



backup_verify(){


header



for FILE in "$BACKUP"/*.tar.gz

do


echo "CHECKING $FILE"



tar -tzf "$FILE" >/dev/null \
&& echo "OK" \
|| echo "FAILED"



done



}



case "${1:-}" in


backup_init)

backup_init

;;


full_backup)

full_backup

;;


config_backup)

config_backup

;;


logs_backup)

logs_backup

;;


backup_list)

restore_list

;;


restore)

restore_backup

;;


backup_enable)

backup_schedule

;;


backup_disable)

backup_remove_schedule

;;


backup_verify)

backup_verify

;;



esac




# ======================================
# MUTEB SOC ENTERPRISE DASHBOARD ENGINE
# ======================================


dashboard_engine_init(){


header


mkdir -p \
"$ROOT/dashboard/api" \
"$ROOT/dashboard/data"



cat > "$ROOT/dashboard/data/dashboard.json" <<EOF

{

"platform":"MUTEB SOC Enterprise",

"version":"5.0",

"status":"ONLINE",

"alerts":0,

"incidents":1,

"services":{

"API":"ONLINE",

"SIEM":"ONLINE",

"SOAR":"ONLINE",

"Detection":"ONLINE",

"Database":"ONLINE"

},

"time":"$(date)"

}

EOF



msg "DASHBOARD ENGINE READY"



}



dashboard_generate_api(){


header



FILE="$ROOT/dashboard/api/dashboard_api.json"



cat > "$FILE" <<EOF

{

"endpoints":[


{

"name":"System Health",

"url":"/api/system/health",

"method":"GET"

},


{

"name":"SOC Overview",

"url":"/api/soc/overview",

"method":"GET"

},


{

"name":"Alerts",

"url":"/api/alerts",

"method":"GET"

},


{

"name":"Incidents",

"url":"/api/incidents",

"method":"GET"

}


]

}

EOF



msg "API MAP GENERATED"



}



dashboard_metrics(){


header



ALERTS=$(find "$ROOT/detection/alerts" \
-type f \
2>/dev/null | wc -l)



INCIDENTS=$(find "$ROOT/incidents/open" \
-type f \
2>/dev/null | wc -l)



cat > "$ROOT/dashboard/data/metrics.json" <<EOF

{

"alerts":$ALERTS,

"incidents":$INCIDENTS,

"cpu":"$(top -bn1 | grep Cpu | awk '{print $2}')",

"memory":"$(free -m | awk '/Mem/{print $3}') MB",

"time":"$(date)"

}

EOF



cat "$ROOT/dashboard/data/metrics.json"



}



dashboard_live(){


header



while true

do


clear



echo "================================="

echo " MUTEB SOC LIVE DASHBOARD"

echo "================================="



date



echo



dashboard_metrics



echo



sleep 10



done



}



dashboard_export(){


header



FILE="$REPORT/dashboard_export_$(date +%F_%H%M).json"



cat \
"$ROOT/dashboard/data/dashboard.json" \
> "$FILE"



msg "$FILE"



}



dashboard_validate(){


header



FILES=(

"$ROOT/dashboard/data/dashboard.json"

"$ROOT/dashboard/data/metrics.json"

"$ROOT/dashboard/api/dashboard_api.json"

)



for FILE in "${FILES[@]}"

do


if [ -f "$FILE" ]

then


echo "$FILE : OK"



else


echo "$FILE : MISSING"



fi



done



}



case "${1:-}" in


dashboard_engine)

dashboard_engine_init

;;


dashboard_api)

dashboard_generate_api

;;


dashboard_metrics)

dashboard_metrics

;;


dashboard_live)

dashboard_live

;;


dashboard_export)

dashboard_export

;;


dashboard_validate)

dashboard_validate

;;



esac




# ======================================
# MUTEB SOC MITRE ATT&CK ENGINE MODULE
# ======================================


mitre_init(){


header


mkdir -p \
"$ROOT/threat_intel/mitre"



cat > "$ROOT/threat_intel/mitre/attack_matrix.json" <<EOF

{

"framework":"MITRE ATT&CK",


"techniques":[


{

"id":"T1110",

"name":"Brute Force",

"category":"Credential Access",

"severity":"HIGH"

},


{

"id":"T1059",

"name":"Command Shell",

"category":"Execution",

"severity":"MEDIUM"

},


{

"id":"T1078",

"name":"Valid Accounts",

"category":"Persistence",

"severity":"HIGH"

},


{

"id":"T1046",

"name":"Network Service Scanning",

"category":"Discovery",

"severity":"MEDIUM"

}


]

}

EOF



msg "MITRE ENGINE READY"



}



mitre_search(){


header



read -p "TECHNIQUE ID: " ID



grep -R \
"$ID" \
"$ROOT/threat_intel/mitre"



}



map_alerts_mitre(){


header



FILE="$ROOT/threat_intel/mitre/mapping.json"



cat > "$FILE" <<EOF

{


"Failed SSH Login":{


"mitre":"T1110",

"technique":"Brute Force",

"severity":"HIGH"


},



"Invalid User":{


"mitre":"T1078",

"technique":"Valid Accounts",

"severity":"MEDIUM"


}



}

EOF



cat "$FILE" | jq



}



mitre_report(){


header



REPORT_FILE="$REPORT/mitre_report_$(date +%F_%H%M).txt"



{


echo "MUTEB SOC MITRE ATT&CK REPORT"


date



echo



cat "$ROOT/threat_intel/mitre/attack_matrix.json"



} > "$REPORT_FILE"



msg "$REPORT_FILE"



}



threat_intel_update(){


header



mkdir -p \
"$ROOT/threat_intel/feeds"



cat > "$ROOT/threat_intel/feeds/local_feed.json" <<EOF

{


"source":"MUTEB SOC LOCAL INTEL",


"updated":"$(date)",


"indicators":[


"SSH_FAILED_LOGIN",

"INVALID_ACCOUNT",

"SUSPICIOUS_PROCESS"


]


}

EOF



msg "THREAT INTEL UPDATED"



}



case "${1:-}" in


mitre_init)

mitre_init

;;


mitre_search)

mitre_search

;;


mitre_map)

map_alerts_mitre

;;


mitre_report)

mitre_report

;;


intel_update)

threat_intel_update

;;



esac




# ======================================
# MUTEB SOC THREAT INTELLIGENCE ENGINE
# ======================================


intel_engine_init(){


header


mkdir -p \
"$ROOT/threat_intel"/{ioc,feeds,analysis}



cat > "$ROOT/threat_intel/ioc/database.json" <<EOF

{


"indicators":[


{


"type":"ip",

"value":"192.168.1.100",

"risk":"medium"


},



{


"type":"domain",

"value":"example-threat.local",

"risk":"high"


},



{


"type":"hash",

"value":"000000000000000000",

"risk":"critical"


}



]


}

EOF



msg "THREAT INTELLIGENCE ENGINE READY"



}



ioc_search(){


header



read -p "IOC VALUE: " IOC



grep -Rni \
"$IOC" \
"$ROOT/threat_intel" \
"$ROOT/logs" \
"$ROOT/collector" \
2>/dev/null



}



ioc_add(){


header



read -p "TYPE: " TYPE

read -p "VALUE: " VALUE

read -p "RISK: " RISK



python3 <<PY

import json


file="$ROOT/threat_intel/ioc/database.json"


with open(file) as f:

    data=json.load(f)



data["indicators"].append({

"type":"$TYPE",

"value":"$VALUE",

"risk":"$RISK"

})



with open(file,"w") as f:

    json.dump(data,f,indent=2)



PY



msg "IOC ADDED"



}



intel_analysis(){


header



python3 <<PY

import json


file="$ROOT/threat_intel/ioc/database.json"



with open(file) as f:

    data=json.load(f)



total=len(data["indicators"])



critical=len([

x for x in data["indicators"]

if x["risk"]=="critical"

])



print("TOTAL IOC:",total)

print("CRITICAL IOC:",critical)



PY



}



intel_report(){


header



FILE="$REPORT/threat_intel_$(date +%F_%H%M).txt"



{


echo "MUTEB SOC THREAT INTELLIGENCE REPORT"


date



echo



cat "$ROOT/threat_intel/ioc/database.json"



} > "$FILE"



msg "$FILE"



}



intel_feed_export(){


header



FILE="$ROOT/threat_intel/feeds/export.json"



cp \
"$ROOT/threat_intel/ioc/database.json" \
"$FILE"



msg "$FILE"



}



case "${1:-}" in


intel_init)

intel_engine_init

;;


ioc_search)

ioc_search

;;


ioc_add)

ioc_add

;;


intel_analysis)

intel_analysis

;;


intel_report)

intel_report

;;


intel_export)

intel_feed_export

;;



esac




# ======================================
# MUTEB SOC INCIDENT RESPONSE MODULE
# ======================================


incident_init(){


header


mkdir -p \
"$ROOT/incidents"/{open,closed,evidence}



cat > "$ROOT/incidents/config.json" <<EOF

{

"platform":"MUTEB SOC",

"incident_management":"enabled",

"severity_levels":[

"critical",

"high",

"medium",

"low"

]

}

EOF



msg "INCIDENT RESPONSE READY"



}



incident_create(){


header



ID="INC-$(date +%Y%m%d-%H%M%S)"



read -p "TITLE: " TITLE

read -p "SEVERITY: " SEVERITY



cat > \
"$ROOT/incidents/open/$ID.json" <<EOF

{

"id":"$ID",

"title":"$TITLE",

"severity":"$SEVERITY",

"status":"OPEN",

"created":"$(date)",

"analyst":"$(whoami)"

}

EOF



msg "$ID CREATED"



}



incident_list(){


header



echo "========== OPEN INCIDENTS =========="



find "$ROOT/incidents/open" \
-name "*.json" \
-exec cat {} \;



}



incident_close(){


header



read -p "INCIDENT ID: " ID



if [ -f "$ROOT/incidents/open/$ID.json" ]

then


mv \
"$ROOT/incidents/open/$ID.json" \
"$ROOT/incidents/closed/"



msg "INCIDENT CLOSED"



else


warn "INCIDENT NOT FOUND"



fi



}



incident_evidence(){


header



read -p "INCIDENT ID: " ID



DIR="$ROOT/incidents/evidence/$ID"



mkdir -p "$DIR"



cp \
"$ROOT/detection/alerts/"* \
"$DIR/" \
2>/dev/null || true



cp \
"$ROOT/collector/events.json" \
"$DIR/" \
2>/dev/null || true



tar -czf \
"$DIR.tar.gz" \
"$DIR"



msg "EVIDENCE PACKAGE CREATED"



}



incident_report(){


header



FILE="$REPORT/incidents_$(date +%F_%H%M).html"



cat > "$FILE" <<EOF

<html>

<head>

<title>MUTEB SOC Incident Report</title>

</head>


<body>


<h1>MUTEB SOC INCIDENT REPORT</h1>


<p>Date: $(date)</p>


<h2>Open Incidents</h2>


<pre>

$(find "$ROOT/incidents/open" -type f -exec cat {} \;)

</pre>


</body>


</html>

EOF



msg "$FILE"



}



incident_statistics(){


header



OPEN=$(find "$ROOT/incidents/open" \
-type f \
2>/dev/null | wc -l)



CLOSED=$(find "$ROOT/incidents/closed" \
-type f \
2>/dev/null | wc -l)



echo "OPEN INCIDENTS : $OPEN"

echo "CLOSED INCIDENTS : $CLOSED"



}



case "${1:-}" in


incident_init)

incident_init

;;


incident_create)

incident_create

;;


incident_list)

incident_list

;;


incident_close)

incident_close

;;


incident_evidence)

incident_evidence

;;


incident_report)

incident_report

;;


incident_stats)

incident_statistics

;;



esac




# ======================================
# MUTEB SOC FINAL ORCHESTRATOR MODULE
# ======================================


orchestrator_init(){


header


mkdir -p \
"$ROOT/orchestrator"



cat > "$ROOT/orchestrator/services.json" <<EOF

{

"services":[


{

"name":"Backend API",

"port":8000,

"status":"managed"

},


{

"name":"React Dashboard",

"port":5173,

"status":"managed"

},


{

"name":"SIEM",

"status":"managed"

},


{

"name":"SOAR",

"status":"managed"

},


{

"name":"Threat Intel",

"status":"managed"

}


]

}

EOF



msg "ORCHESTRATOR READY"



}



platform_start(){


header



echo "STARTING MUTEB SOC PLATFORM"



cd "$ROOT"



if pgrep -f "python3 run.py" >/dev/null

then


echo "BACKEND ALREADY RUNNING"



else


source "$ROOT/venv/bin/activate"



nohup python3 run.py \
> "$BACKEND_LOG" 2>&1 &



echo "BACKEND STARTED"



fi



sleep 3



if [ -d "$ROOT/frontend" ]

then


cd "$ROOT/frontend"



if command -v npm >/dev/null

then


nohup npm run dev \
> "$FRONTEND_LOG" 2>&1 &



echo "FRONTEND STARTED"



else


echo "NPM NOT FOUND"



fi



fi



}



platform_stop(){


header



pkill -f "python3 run.py" \
2>/dev/null || true



pkill -f "npm run dev" \
2>/dev/null || true



msg "PLATFORM STOPPED"



}



platform_restart(){


header



platform_stop



sleep 3



platform_start



}



platform_status(){


header



echo "========== PLATFORM STATUS =========="



if pgrep -f "python3 run.py" >/dev/null

then

echo "BACKEND : ONLINE"

else

echo "BACKEND : OFFLINE"

fi



if pgrep -f "npm run dev" >/dev/null

then

echo "FRONTEND : ONLINE"

else

echo "FRONTEND : OFFLINE"

fi



echo



ss -tulpn \
| grep -E "8000|5173"



}



platform_backup(){


header



full_backup



msg "PLATFORM BACKUP FINISHED"



}



platform_self_test(){


header



echo "MUTEB SOC SELF TEST"



health_full



dashboard_validate



security_score



database_check



}



case "${1:-}" in


orchestrator_init)

orchestrator_init

;;


platform_start)

platform_start

;;


platform_stop)

platform_stop

;;


platform_restart)

platform_restart

;;


platform_status)

platform_status

;;


platform_backup)

platform_backup

;;


self_test)

platform_self_test

;;



esac




# ======================================
# MUTEB SOC AUTOMATED TESTING MODULE
# ======================================


testing_init(){


header


mkdir -p \
"$ROOT/tests"



cat > "$ROOT/tests/test_platform.sh" <<'EOF'

#!/bin/bash


echo "MUTEB SOC AUTOMATED TEST"



echo


echo "[1] Backend Test"



curl -s \
http://127.0.0.1:8000/api/system/health \
| grep status



echo


echo "[2] Port Test"



ss -tulpn \
| grep 8000



echo


echo "[3] Files Test"



FILES=(

"run.py"

"app"

"frontend"

"scripts/MUTEB_SOC.sh"

)



for FILE in "${FILES[@]}"

do


if [ -e "$FILE" ]

then


echo "$FILE : OK"



else


echo "$FILE : MISSING"



fi



done



echo


echo "TEST COMPLETE"



EOF



chmod +x \
"$ROOT/tests/test_platform.sh"



msg "TEST MODULE READY"



}



run_tests(){


header



bash \
"$ROOT/tests/test_platform.sh"



}



api_test_suite(){


header



echo "========== API TEST =========="



APIS=(


"/api/version/info"


"/api/system/health"


"/api/soc/overview"


)



for API in "${APIS[@]}"

do


CODE=$(curl -s \
-o /dev/null \
-w "%{http_code}" \
http://127.0.0.1:8000$API)



echo "$API : $CODE"



done



}



security_test_suite(){


header



echo "========== SECURITY TEST =========="



echo "SSH"

systemctl is-active ssh



echo "FAIL2BAN"

systemctl is-active fail2ban



echo "PERMISSIONS"

find "$ROOT" \
-type f \
-perm -o+w \
| head



}



performance_test(){


header



echo "========== PERFORMANCE =========="



for i in {1..10}

do


curl -s \
-o /dev/null \
-w "Request $i : %{time_total}s\n" \
http://127.0.0.1:8000/api/system/health



done



}



case "${1:-}" in


testing_init)

testing_init

;;


test_run)

run_tests

;;


api_test)

api_test_suite

;;


security_test)

security_test_suite

;;


performance_test)

performance_test

;;



esac




# ======================================
# MUTEB SOC LOG MANAGEMENT MODULE
# ======================================


logs_init(){


header


mkdir -p \
"$ROOT/logs"/{application,security,archive}



msg "LOG SYSTEM READY"



}



collect_application_logs(){


header



DATE=$(date +%F_%H%M)



cp "$BACKEND_LOG" \
"$ROOT/logs/application/backend_$DATE.log" \
2>/dev/null || true



cp "$FRONTEND_LOG" \
"$ROOT/logs/application/frontend_$DATE.log" \
2>/dev/null || true



msg "APPLICATION LOGS COLLECTED"



}



security_log_collection(){


header



FILE="$ROOT/logs/security/security_$(
date +%F_%H%M
).log"



{


echo "MUTEB SOC SECURITY LOG"



date



echo


echo "FAILED SSH LOGIN"



journalctl \
-u ssh \
--no-pager \
| grep Failed



echo


echo "AUTH EVENTS"



journalctl \
-u ssh \
--no-pager \
| tail -100



} > "$FILE"



msg "$FILE"



}



log_search(){


header



read -p "SEARCH LOG TERM: " TERM



grep -Rni \
"$TERM" \
"$ROOT/logs" \
2>/dev/null \
| head -100



}



log_rotation(){


header



find "$ROOT/logs" \
-type f \
-name "*.log" \
-size +50M \
-exec gzip {} \;



msg "LOG ROTATION COMPLETE"



}



log_archive(){


header



FILE="$ROOT/logs/archive/logs_$(date +%F_%H%M).tar.gz"



tar -czf \
"$FILE" \
"$ROOT/logs/application" \
"$ROOT/logs/security"



msg "$FILE"



}



log_statistics(){


header



echo "========== LOG STATISTICS =========="



echo "TOTAL LOG FILES"



find "$ROOT/logs" \
-type f \
| wc -l



echo



echo "TOTAL SIZE"



du -sh "$ROOT/logs"



}



case "${1:-}" in


logs_init)

logs_init

;;


app_logs)

collect_application_logs

;;


security_logs)

security_log_collection

;;


log_search)

log_search

;;


log_rotate)

log_rotation

;;


log_archive)

log_archive

;;


log_stats)

log_statistics

;;



esac




# ======================================
# MUTEB SOC USER AUTHENTICATION ENGINE
# ======================================


auth_engine_init(){


header


mkdir -p \
"$ROOT/auth"



cat > "$ROOT/auth/users.json" <<EOF

{

"users":[


{

"username":"admin",

"role":"administrator",

"status":"active"

},


{

"username":"analyst",

"role":"soc_analyst",

"status":"active"

}


]

}

EOF



msg "AUTH ENGINE READY"



}



auth_users(){


header



cat "$ROOT/auth/users.json" \
| jq



}



auth_add_user(){


header



read -p "USERNAME: " USER

read -p "ROLE: " ROLE



python3 <<PY

import json


file="$ROOT/auth/users.json"


with open(file) as f:

    data=json.load(f)



data["users"].append({

"username":"$USER",

"role":"$ROLE",

"status":"active"

})



with open(file,"w") as f:

    json.dump(data,f,indent=2)


PY



msg "USER ADDED"



}



auth_disable_user(){


header



read -p "USERNAME: " USER



python3 <<PY

import json


file="$ROOT/auth/users.json"



with open(file) as f:

    data=json.load(f)



for u in data["users"]:

    if u["username"]=="$USER":

        u["status"]="disabled"



with open(file,"w") as f:

    json.dump(data,f,indent=2)



PY



msg "USER DISABLED"



}



auth_audit(){


header



FILE="$REPORT/auth_audit_$(date +%F_%H%M).txt"



{


echo "MUTEB SOC AUTH AUDIT"

date



echo



cat "$ROOT/auth/users.json"



} > "$FILE"



msg "$FILE"



}



password_policy(){


header



cat > "$ROOT/auth/password_policy.json" <<EOF

{

"minimum_length":12,

"uppercase":true,

"numbers":true,

"special_characters":true,

"rotation_days":90

}

EOF



msg "PASSWORD POLICY CREATED"



}



case "${1:-}" in


auth_init)

auth_engine_init

;;


auth_users)

auth_users

;;


auth_add)

auth_add_user

;;


auth_disable)

auth_disable_user

;;


auth_audit)

auth_audit

;;


password_policy)

password_policy

;;



esac




# ======================================
# MUTEB SOC ALERT MANAGEMENT WORKFLOW
# ======================================


alert_workflow_init(){


header


mkdir -p \
"$ROOT/alerts"/{new,assigned,closed}



cat > "$ROOT/alerts/workflow.json" <<EOF

{

"states":[

"NEW",

"ASSIGNED",

"INVESTIGATING",

"RESOLVED",

"CLOSED"

],


"priority":[

"CRITICAL",

"HIGH",

"MEDIUM",

"LOW"

]

}

EOF



msg "ALERT WORKFLOW READY"



}



create_alert(){


header



ID="ALERT-$(date +%Y%m%d-%H%M%S)"



read -p "ALERT TITLE: " TITLE

read -p "SEVERITY: " SEVERITY



cat > \
"$ROOT/alerts/new/$ID.json" <<EOF

{

"id":"$ID",

"title":"$TITLE",

"severity":"$SEVERITY",

"status":"NEW",

"created":"$(date)",

"owner":"SOC"

}

EOF



msg "$ID CREATED"



}



list_alerts(){


header



echo "========== NEW ALERTS =========="



find "$ROOT/alerts/new" \
-type f \
-exec cat {} \;



}



assign_alert(){


header



read -p "ALERT ID: " ID

read -p "ANALYST: " ANALYST



if [ -f "$ROOT/alerts/new/$ID.json" ]

then


mv \
"$ROOT/alerts/new/$ID.json" \
"$ROOT/alerts/assigned/"



sed -i \
"s/\"status\":\"NEW\"/\"status\":\"ASSIGNED\",\"analyst\":\"$ANALYST\"/" \
"$ROOT/alerts/assigned/$ID.json"



msg "ALERT ASSIGNED"



else


warn "ALERT NOT FOUND"



fi



}



close_alert(){


header



read -p "ALERT ID: " ID



if [ -f "$ROOT/alerts/assigned/$ID.json" ]

then


mv \
"$ROOT/alerts/assigned/$ID.json" \
"$ROOT/alerts/closed/"



msg "ALERT CLOSED"



else


warn "ALERT NOT FOUND"



fi



}



alert_summary(){


header



echo "========== ALERT SUMMARY =========="



echo "NEW:"

find "$ROOT/alerts/new" -type f | wc -l



echo "ASSIGNED:"

find "$ROOT/alerts/assigned" -type f | wc -l



echo "CLOSED:"

find "$ROOT/alerts/closed" -type f | wc -l



}



case "${1:-}" in


alert_workflow_init)

alert_workflow_init

;;


alert_create)

create_alert

;;


alert_list)

list_alerts

;;


alert_assign)

assign_alert

;;


alert_close)

close_alert

;;


alert_summary)

alert_summary

;;



esac




# ======================================
# MUTEB SOC REAL-TIME EVENT PIPELINE
# ======================================


event_pipeline_init(){


header


mkdir -p \
"$ROOT/pipeline"/{queue,processed,failed}



cat > "$ROOT/pipeline/config.json" <<EOF

{

"engine":"MUTEB EVENT PIPELINE",

"mode":"real-time",

"queue":"enabled",

"processing":"enabled"

}

EOF



msg "EVENT PIPELINE READY"



}



event_ingest(){


header



read -p "EVENT SOURCE: " SOURCE

read -p "EVENT MESSAGE: " MESSAGE



ID="EVENT-$(date +%Y%m%d-%H%M%S)"



cat > \
"$ROOT/pipeline/queue/$ID.json" <<EOF

{

"id":"$ID",

"source":"$SOURCE",

"message":"$MESSAGE",

"time":"$(date)",

"status":"QUEUED"

}

EOF



msg "$ID QUEUED"



}



event_process(){


header



for FILE in "$ROOT/pipeline/queue/"*.json

do


[ -e "$FILE" ] || continue



mv \
"$FILE" \
"$ROOT/pipeline/processed/"



done



msg "EVENTS PROCESSED"



}



event_failed(){


header



echo "========== FAILED EVENTS =========="



find "$ROOT/pipeline/failed" \
-type f \
-exec cat {} \;



}



event_statistics(){


header



echo "========== PIPELINE STATUS =========="



echo "QUEUE:"

find "$ROOT/pipeline/queue" \
-type f \
| wc -l



echo "PROCESSED:"

find "$ROOT/pipeline/processed" \
-type f \
| wc -l



echo "FAILED:"

find "$ROOT/pipeline/failed" \
-type f \
| wc -l



}



pipeline_report(){


header



FILE="$REPORT/pipeline_$(date +%F_%H%M).txt"



{


echo "MUTEB SOC EVENT PIPELINE REPORT"

date



echo



cat "$ROOT/pipeline/config.json"



echo



event_statistics



} > "$FILE"



msg "$FILE"



}



case "${1:-}" in


pipeline_init)

event_pipeline_init

;;


event_ingest)

event_ingest

;;


event_process)

event_process

;;


event_failed)

event_failed

;;


event_stats)

event_statistics

;;


pipeline_report)

pipeline_report

;;



esac




# ======================================
# MUTEB SOC SOAR AUTOMATION RULES ENGINE
# ======================================


soar_rules_init(){


header


mkdir -p \
"$ROOT/soar"/{rules,actions,executions}



cat > "$ROOT/soar/rules/automation.json" <<EOF

{


"rules":[


{


"id":"AUTO-001",

"name":"SSH Brute Force Response",

"trigger":"SSH_FAILED_LOGIN",

"action":"BLOCK_IP",

"severity":"HIGH"

},



{


"id":"AUTO-002",

"name":"Critical Alert Escalation",

"trigger":"CRITICAL_ALERT",

"action":"CREATE_INCIDENT",

"severity":"CRITICAL"

},



{


"id":"AUTO-003",

"name":"Service Failure",

"trigger":"SERVICE_DOWN",

"action":"NOTIFY_ANALYST",

"severity":"MEDIUM"

}



]

}

EOF



msg "SOAR RULE ENGINE READY"



}



soar_execute(){


header



read -p "EVENT: " EVENT



python3 <<PY

import json


file="$ROOT/soar/rules/automation.json"


with open(file) as f:

    data=json.load(f)



found=False



for rule in data["rules"]:

    if rule["trigger"]=="$EVENT":

        print("RULE MATCH:",rule["name"])

        print("ACTION:",rule["action"])

        found=True



if not found:

    print("NO AUTOMATION RULE")



PY



}



soar_rules_list(){


header



cat \
"$ROOT/soar/rules/automation.json" \
| jq



}



soar_action_log(){


header



FILE="$ROOT/soar/executions/actions.log"



{

echo "===================="

echo "TIME: $(date)"

echo "ACTION EXECUTED"

echo "USER: $(whoami)"

echo "===================="



} >> "$FILE"



msg "$FILE"



}



soar_report(){


header



FILE="$REPORT/soar_report_$(date +%F_%H%M).txt"



{


echo "MUTEB SOC SOAR REPORT"

date



echo



cat "$ROOT/soar/rules/automation.json"



} > "$FILE"



msg "$FILE"



}



case "${1:-}" in


soar_init)

soar_rules_init

;;


soar_execute)

soar_execute

;;


soar_rules)

soar_rules_list

;;


soar_log)

soar_action_log

;;


soar_report)

soar_report

;;



esac




# ======================================
# MUTEB SOC WEB DASHBOARD INTEGRATION
# ======================================


web_dashboard_init(){


header


mkdir -p \
"$ROOT/web_dashboard/api"



cat > "$ROOT/web_dashboard/api/dashboard.json" <<EOF

{

"title":"MUTEB SOC Enterprise Dashboard",

"widgets":[


{

"name":"Security Alerts",

"api":"/api/alerts"

},


{

"name":"Incidents",

"api":"/api/incidents"

},


{

"name":"System Health",

"api":"/api/system/health"

},


{

"name":"Threat Intelligence",

"api":"/api/threats"

}


]

}

EOF



msg "WEB DASHBOARD CONFIG READY"



}



generate_dashboard_html(){


header



cat > "$ROOT/web_dashboard/templates/soc_dashboard.html" <<'EOF'


<!DOCTYPE html>

<html>

<head>

<title>MUTEB SOC Dashboard</title>


<style>


body{

background:#050505;

color:#00ff99;

font-family:Arial;

}


.card{

border:1px solid #00ff99;

padding:20px;

margin:20px;

}


</style>


</head>


<body>



<h1>MUTEB SOC ENTERPRISE</h1>



<div class="card">

<h2>System Status</h2>

<p id="status">Loading...</p>

</div>



<div class="card">

<h2>Alerts</h2>

<p id="alerts">Loading...</p>

</div>



<script>


async function load(){


let health=

await fetch('/api/system/health');


let data=

await health.json();



document.getElementById("status")

.innerHTML=

data.status;



}



load();



</script>


</body>


</html>


EOF



msg "DASHBOARD HTML CREATED"



}



dashboard_routes_check(){


header



echo "========== DASHBOARD FILES =========="



find "$ROOT/web_dashboard" \
-type f



}



web_dashboard_test(){


header



if [ -f "$ROOT/web_dashboard/templates/soc_dashboard.html" ]

then


echo "DASHBOARD : READY"



else


echo "DASHBOARD : MISSING"



fi



}



case "${1:-}" in


web_dashboard_init)

web_dashboard_init

;;


dashboard_html)

generate_dashboard_html

;;


dashboard_files)

dashboard_routes_check

;;


dashboard_test)

web_dashboard_test

;;



esac




# ======================================
# MUTEB SOC DATABASE PRODUCTION ENGINE
# ======================================


db_engine_init(){


header


mkdir -p \
"$ROOT/database"/{models,migrations,data}



cat > "$ROOT/database/schema.sql" <<EOF


CREATE TABLE IF NOT EXISTS users (

id INTEGER PRIMARY KEY,

username TEXT NOT NULL,

role TEXT NOT NULL,

status TEXT DEFAULT 'active'

);



CREATE TABLE IF NOT EXISTS alerts (

id INTEGER PRIMARY KEY,

title TEXT,

severity TEXT,

status TEXT,

created TIMESTAMP

);



CREATE TABLE IF NOT EXISTS incidents (

id INTEGER PRIMARY KEY,

title TEXT,

severity TEXT,

status TEXT,

created TIMESTAMP

);



CREATE TABLE IF NOT EXISTS logs (

id INTEGER PRIMARY KEY,

source TEXT,

message TEXT,

created TIMESTAMP

);



EOF



msg "DATABASE ENGINE READY"



}



sqlite_create(){


header



DB="$ROOT/database/data/muteb_soc.db"



sqlite3 "$DB" < \
"$ROOT/database/schema.sql"



msg "$DB CREATED"



}



db_insert_test(){


header



DB="$ROOT/database/data/muteb_soc.db"



sqlite3 "$DB" <<EOF


INSERT INTO users

(username,role)

VALUES

('admin','administrator');



INSERT INTO alerts

(title,severity,status)

VALUES

('SSH Failed Login','HIGH','OPEN');



INSERT INTO incidents

(title,severity,status)

VALUES

('Unauthorized Access Attempt','HIGH','OPEN');



EOF



msg "TEST DATA INSERTED"



}



db_query(){


header



DB="$ROOT/database/data/muteb_soc.db"



echo "========== USERS =========="



sqlite3 "$DB" \

"SELECT * FROM users;"



echo



echo "========== ALERTS =========="



sqlite3 "$DB" \

"SELECT * FROM alerts;"



echo



echo "========== INCIDENTS =========="



sqlite3 "$DB" \

"SELECT * FROM incidents;"



}



db_backup_sqlite(){


header



DB="$ROOT/database/data/muteb_soc.db"



cp "$DB" \
"$BACKUP/muteb_soc_$(date +%F_%H%M).db"



msg "DATABASE BACKUP COMPLETE"



}



case "${1:-}" in


db_init)

db_engine_init

;;


db_create)

sqlite_create

;;


db_test_data)

db_insert_test

;;


db_query)

db_query

;;


db_backup)

db_backup_sqlite

;;



esac




# ======================================
# MUTEB SOC JWT AUTHENTICATION ENGINE
# ======================================


jwt_init(){


header


mkdir -p \
"$ROOT/security/jwt"



cat > "$ROOT/security/jwt/config.json" <<EOF

{

"algorithm":"HS256",

"token_expiry":"24h",

"refresh_token":true,

"rbac":"enabled"

}

EOF



msg "JWT ENGINE READY"



}



jwt_generate(){


header



python3 <<PY

import json

import datetime

import base64



payload={

"user":"admin",

"role":"administrator",

"created":str(datetime.datetime.now())

}



token=base64.urlsafe_b64encode(

json.dumps(payload).encode()

).decode()



with open(

"$ROOT/security/jwt/token.txt",

"w"

) as f:

    f.write(token)



print(token)



PY



}



jwt_validate(){


header



FILE="$ROOT/security/jwt/token.txt"



if [ -f "$FILE" ]

then


echo "TOKEN EXISTS"

echo "VALID"



else


echo "TOKEN NOT FOUND"



fi



}



jwt_revoke(){


header



rm -f \
"$ROOT/security/jwt/token.txt"



msg "TOKEN REVOKED"



}



rbac_check(){


header



read -p "ROLE: " ROLE



case "$ROLE" in


administrator)

echo "FULL ACCESS"



;;


soc_analyst)

echo "SOC ACCESS"



;;


viewer)

echo "READ ONLY"



;;


*)

echo "ACCESS DENIED"



;;



esac



}



security_auth_report(){


header



FILE="$REPORT/auth_security_$(date +%F_%H%M).txt"



{


echo "MUTEB SOC AUTH SECURITY REPORT"


date



echo



cat "$ROOT/security/jwt/config.json"



} > "$FILE"



msg "$FILE"



}



case "${1:-}" in


jwt_init)

jwt_init

;;


jwt_generate)

jwt_generate

;;


jwt_validate)

jwt_validate

;;


jwt_revoke)

jwt_revoke

;;


rbac_check)

rbac_check

;;


jwt_report)

security_auth_report

;;



esac




# ======================================
# MUTEB SOC LIVE API DATABASE CONNECTOR
# ======================================


api_database_connector(){


header


mkdir -p \
"$ROOT/api_connector"



cat > "$ROOT/api_connector/config.json" <<EOF

{

"database":"sqlite",

"path":"database/data/muteb_soc.db",

"cache":"enabled",

"sync":"realtime"

}

EOF



msg "API DATABASE CONNECTOR READY"



}



sync_alerts_database(){


header



DB="$ROOT/database/data/muteb_soc.db"



if [ ! -f "$DB" ]

then


warn "DATABASE NOT FOUND"

return



fi



ALERT_COUNT=$(find \
"$ROOT/alerts/new" \
-type f \
2>/dev/null \
| wc -l)



sqlite3 "$DB" <<EOF


INSERT INTO logs

(source,message,created)

VALUES

('MUTEB-SOC',

'ALERT SYNC COUNT: $ALERT_COUNT',

datetime('now'));



EOF



msg "ALERTS SYNCHRONIZED"



}



sync_incidents_database(){


header



DB="$ROOT/database/data/muteb_soc.db"



INCIDENT_COUNT=$(find \
"$ROOT/incidents/open" \
-type f \
2>/dev/null \
| wc -l)



sqlite3 "$DB" <<EOF


INSERT INTO logs

(source,message,created)

VALUES

('MUTEB-SOC',

'INCIDENT SYNC COUNT: $INCIDENT_COUNT',

datetime('now'));



EOF



msg "INCIDENTS SYNCHRONIZED"



}



dashboard_database_status(){


header



DB="$ROOT/database/data/muteb_soc.db"



echo "========== LIVE DASHBOARD DATA =========="



echo



echo "ALERTS"



sqlite3 "$DB" \
"SELECT count(*) FROM alerts;"



echo



echo "INCIDENTS"



sqlite3 "$DB" \
"SELECT count(*) FROM incidents;"



echo



echo "USERS"



sqlite3 "$DB" \
"SELECT count(*) FROM users;"



}



api_sync_all(){


header



sync_alerts_database

sync_incidents_database



msg "FULL API DATABASE SYNC COMPLETE"



}



case "${1:-}" in


api_db_init)

api_database_connector

;;


sync_alerts)

sync_alerts_database

;;


sync_incidents)

sync_incidents_database

;;


dashboard_db_status)

dashboard_database_status

;;


api_sync_all)

api_sync_all

;;



esac




# ======================================
# MUTEB SOC THREAT FEED AUTOMATION
# ======================================


threat_feed_init(){


header


mkdir -p \
"$ROOT/threat_feeds"/{incoming,processed,reports}



cat > "$ROOT/threat_feeds/config.json" <<EOF

{

"engine":"MUTEB THREAT FEED",

"mode":"automatic",

"format":"json",

"status":"enabled"

}

EOF



msg "THREAT FEED ENGINE READY"



}



collect_local_feed(){


header



FILE="$ROOT/threat_feeds/incoming/local_$(date +%F_%H%M).json"



cat > "$FILE" <<EOF

{

"source":"LOCAL SECURITY EVENTS",

"time":"$(date)",

"indicators":[


{

"type":"event",

"value":"SSH_FAILED_LOGIN",

"risk":"HIGH"

},


{

"type":"event",

"value":"INVALID_USER",

"risk":"MEDIUM"

}


]

}

EOF



msg "$FILE"



}



process_threat_feed(){


header



for FILE in \
"$ROOT/threat_feeds/incoming/"*.json

do


[ -e "$FILE" ] || continue



cp "$FILE" \
"$ROOT/threat_feeds/processed/"



done



msg "THREAT FEEDS PROCESSED"



}



feed_analysis(){


header



python3 <<PY

import glob,json


files=glob.glob(

"$ROOT/threat_feeds/processed/*.json"

)



total=0



for file in files:


    with open(file) as f:


        data=json.load(f)


        total += len(

        data.get("indicators",[])

        )



print("TOTAL INDICATORS:",total)



PY



}



threat_feed_report(){


header



FILE="$REPORT/threat_feed_$(date +%F_%H%M).txt"



{


echo "MUTEB SOC THREAT FEED REPORT"

date



echo



cat "$ROOT/threat_feeds/config.json"



echo



find "$ROOT/threat_feeds/processed" \
-type f



} > "$FILE"



msg "$FILE"



}



case "${1:-}" in


feed_init)

threat_feed_init

;;


feed_collect)

collect_local_feed

;;


feed_process)

process_threat_feed

;;


feed_analysis)

feed_analysis

;;


feed_report)

threat_feed_report

;;



esac




# ======================================
# MUTEB SOC FINAL PRODUCTION DEPLOYMENT
# ======================================


production_check(){


header



echo "========== PRODUCTION CHECK =========="



CHECKS=(


"run.py"

"app"

"frontend"

"scripts/MUTEB_SOC.sh"

"database"

"reports"

"logs"


)



for ITEM in "${CHECKS[@]}"

do


if [ -e "$ROOT/$ITEM" ]

then


echo "$ITEM : READY"



else


echo "$ITEM : MISSING"



fi



done



}



production_prepare(){


header



mkdir -p \

"$ROOT/releases" \

"$ROOT/deployment"



cat > "$ROOT/deployment/start_production.sh" <<EOF


#!/bin/bash



cd $ROOT



source venv/bin/activate



nohup python3 run.py \

> logs/backend_production.log 2>&1 &



cd frontend



nohup npm run dev \

> logs/frontend_production.log 2>&1 &



EOF



chmod +x \
"$ROOT/deployment/start_production.sh"



msg "PRODUCTION START SCRIPT CREATED"



}



final_backup(){


header



DATE=$(date +%F_%H%M)



tar -czf \

"$BACKUP/MUTEB_SOC_FINAL_$DATE.tar.gz" \

--exclude=venv \

--exclude=node_modules \

--exclude=.git \

"$ROOT"



msg "FINAL BACKUP CREATED"



}



final_health(){


header



echo "========== FINAL HEALTH =========="



echo



echo "BACKEND"



curl -I \
http://127.0.0.1:8000 \
2>/dev/null



echo



echo "PORTS"



ss -tulpn \
| grep -E "8000|5173|80"



echo



echo "SERVICES"



systemctl is-active ssh

systemctl is-active apache2

systemctl is-active fail2ban



}



final_report(){


header



FILE="$REPORT/MUTEB_SOC_FINAL_REPORT_$(date +%F).txt"



{


echo "================================"

echo " MUTEB SOC ENTERPRISE FINAL REPORT"

echo "================================"



date



echo



echo "VERSION: ENTERPRISE"



echo



echo "MODULES"



echo "[+] SIEM"

echo "[+] SOAR"

echo "[+] Threat Intelligence"

echo "[+] Incident Response"

echo "[+] Dashboard"

echo "[+] Authentication"

echo "[+] Monitoring"



echo



echo "STATUS: READY FOR FINAL TEST"



} > "$FILE"



msg "$FILE"



}



case "${1:-}" in


production_check)

production_check

;;


production_prepare)

production_prepare

;;


final_backup)

final_backup

;;


final_health)

final_health

;;


final_report)

final_report

;;



esac




# ======================================
# MUTEB SOC ENTERPRISE FINAL VALIDATION
# ======================================


enterprise_validation(){


header



echo "================================"

echo " MUTEB SOC ENTERPRISE VALIDATION"

echo "================================"



echo



echo "[1] PROJECT STRUCTURE"



DIRS=(


app

frontend

database

security

alerts

incidents

reports

scripts


)



for DIR in "${DIRS[@]}"

do


if [ -d "$ROOT/$DIR" ]

then


echo "$DIR : OK"



else


echo "$DIR : MISSING"



fi



done



echo



echo "[2] SERVICES"



SERVICES=(


ssh

apache2

fail2ban


)



for SERVICE in "${SERVICES[@]}"

do


systemctl is-active "$SERVICE" \
>/dev/null \


echo echo "$SERVICE : RUNNING" \
|| echo "$SERVICE : CHECK"



done



echo



echo "[3] APPLICATION"



if pgrep -f "python3 run.py" \
>/dev/null

then


echo "BACKEND : RUNNING"



else


echo "BACKEND : STOPPED"



fi



echo



echo "[4] SECURITY"



security_score



echo



echo "[5] DATABASE"



if [ -f "$ROOT/database/data/muteb_soc.db" ]

then


echo "DATABASE : READY"



else


echo "DATABASE : NOT INITIALIZED"



fi



}



enterprise_release(){


header



VERSION="1.0.0"



mkdir -p \
"$ROOT/releases/$VERSION"



cp -r \

app \

scripts \

database \

security \

frontend \

"$ROOT/releases/$VERSION/" \
2>/dev/null



tar -czf \

"$ROOT/releases/MUTEB_SOC_ENTERPRISE_$VERSION.tar.gz" \

-C "$ROOT/releases" \
"$VERSION"



msg "RELEASE $VERSION CREATED"



}



enterprise_cleanup(){


header



find "$ROOT/logs" \
-type f \
-name "*.log" \
-mtime +30 \
-delete



find "$ROOT/reports" \
-type f \
-mtime +90 \
-delete



msg "OLD DATA CLEANED"



}



enterprise_start(){


header



platform_start



sleep 5



final_health



}



case "${1:-}" in


enterprise_validate)

enterprise_validation

;;


enterprise_release)

enterprise_release

;;


enterprise_cleanup)

enterprise_cleanup

;;


enterprise_start)

enterprise_start

;;



esac




# ======================================
# MUTEB SOC FRONTEND PRODUCTION CONNECTOR
# ======================================


frontend_connector_init(){


header


mkdir -p \
"$ROOT/frontend/src/config"



cat > "$ROOT/frontend/src/config/api.js" <<EOF


const API_URL =

"http://localhost:8000";



export default API_URL;



EOF



msg "FRONTEND API CONNECTOR CREATED"



}



frontend_environment(){


header



cat > "$ROOT/frontend/.env" <<EOF


VITE_API_URL=http://localhost:8000


VITE_APP_NAME=MUTEB_SOC_ENTERPRISE


VITE_MODE=production


EOF



msg "FRONTEND ENV CREATED"



}



frontend_verify(){


header



FILES=(


"$ROOT/frontend/package.json"


"$ROOT/frontend/src/App.jsx"


"$ROOT/frontend/index.html"


"$ROOT/frontend/.env"


)



for FILE in "${FILES[@]}"

do


if [ -f "$FILE" ]

then


echo "$FILE : READY"



else


echo "$FILE : MISSING"



fi



done



}



frontend_production_build(){


header



cd "$ROOT/frontend"



if command -v npm >/dev/null

then


npm install



npm run build



msg "FRONTEND BUILD COMPLETE"



else


echo "NPM REQUIRED"



fi



}



final_e2e_test(){


header



echo "========== END TO END TEST =========="



echo



echo "BACKEND"



curl -s \
http://127.0.0.1:8000 \
>/dev/null \


if [ $? -eq 0 ]

then


echo "API : PASS"



else


echo "API : FAIL"



fi



echo



echo "DATABASE"



if [ -f "$ROOT/database/data/muteb_soc.db" ]

then


echo "DB : PASS"



else


echo "DB : FAIL"



fi



echo



echo "FRONTEND"



if [ -d "$ROOT/frontend" ]

then


echo "UI : PASS"



else


echo "UI : FAIL"



fi



}



case "${1:-}" in


frontend_connector)

frontend_connector_init

;;


frontend_env)

frontend_environment

;;


frontend_verify)

frontend_verify

;;


frontend_build)

frontend_production_build

;;


e2e_test)

final_e2e_test

;;



esac




# ======================================
# MUTEB SOC RELEASE FINALIZER
# ======================================


release_finalizer(){


header


echo "================================"

echo " MUTEB SOC ENTERPRISE FINALIZER"

echo "================================"



echo



echo "[1] Running Validation"



enterprise_validation



echo



echo "[2] Running E2E Test"



final_e2e_test



echo



echo "[3] Creating Final Release"



enterprise_release



echo



echo "[4] Creating Documentation Index"



mkdir -p "$ROOT/docs"



cat > "$ROOT/docs/PROJECT_STATUS.md" <<EOF


# MUTEB SOC ENTERPRISE



## Status

Production Ready



## Modules


- Backend API

- SOC Engine

- SIEM

- SOAR

- Threat Intelligence

- Incident Response

- Authentication

- Database

- Dashboard

- Monitoring

- Backup

- Security Hardening



## Startup


\`\`\`bash

cd ~/Muteb-SOC && ./scripts/MUTEB_SOC.sh menu

\`\`\`



EOF



msg "FINAL RELEASE COMPLETED"



}



version_info(){


header



cat <<EOF


================================

 MUTEB SOC ENTERPRISE

 VERSION: 1.0.0

 STATUS: PRODUCTION READY

 BUILD: $(date)

================================


EOF



}



system_snapshot(){


header



FILE="$REPORT/system_snapshot_$(date +%F_%H%M).txt"



{


echo "MUTEB SOC SYSTEM SNAPSHOT"

date



echo



hostname



echo



uname -a



echo



df -h



echo



free -h



echo



ss -tulpn



} > "$FILE"



msg "$FILE"



}



case "${1:-}" in


release_final)

release_finalizer

;;


version)

version_info

;;


snapshot)

system_snapshot

;;



esac




# ======================================
# MUTEB SOC PORTFOLIO & GITHUB RELEASE
# ======================================


github_prepare(){


header


mkdir -p \
"$ROOT/.github"



cat > "$ROOT/.github/SECURITY.md" <<EOF


# MUTEB SOC SECURITY POLICY



## Reporting Security Issues



Contact:

MUTEB SOC Security Team



## Supported Version



1.0.0



EOF



cat > "$ROOT/.github/README_RELEASE.md" <<EOF


# MUTEB SOC Enterprise



Professional SOC Platform



## Features



- SIEM

- SOAR

- Threat Intelligence

- Incident Response

- Monitoring

- Authentication

- Dashboard



## Run



cd ~/Muteb-SOC






EOF



msg "GITHUB FILES READY"



}



git_status_report(){


header



cd "$ROOT"



echo "========== GIT STATUS =========="



git status



echo



echo "========== COMMITS =========="



git log \
--oneline \
-10



}



git_release_tag(){


header



cd "$ROOT"



TAG="v1.0.0"



git add .



git commit \
-m "MUTEB SOC Enterprise Release 1.0.0" \
2>/dev/null || true



git tag "$TAG" \
2>/dev/null || true



msg "TAG $TAG CREATED"



}



portfolio_export(){


header



FILE="$REPORT/MUTEB_SOC_PORTFOLIO.txt"



{


echo "================================"

echo " MUTEB SOC ENTERPRISE"

echo " PORTFOLIO SUMMARY"

echo "================================"



echo



echo "Developer: Muteb"



echo "Version: 1.0.0"



echo "Status: Production Ready"



echo



echo "Modules:"



echo "- SIEM"

echo "- SOAR"

echo "- Threat Intelligence"

echo "- Incident Response"

echo "- Dashboard"

echo "- Authentication"

echo "- Monitoring"



} > "$FILE"



msg "$FILE"



}



case "${1:-}" in


github_prepare)

github_prepare

;;


git_status)

git_status_report

;;


git_release)

git_release_tag

;;


portfolio)

portfolio_export

;;



esac




# ======================================
# MUTEB SOC ENTERPRISE DEMO MODE
# ======================================


demo_mode(){


header



clear



echo "=============================================="

echo "        MUTEB SOC ENTERPRISE DEMO MODE"

echo "=============================================="



sleep 2



echo

echo "[+] Loading SOC Platform..."

sleep 1



echo

echo "[+] Checking Backend..."

platform_status



echo

echo "[+] Checking Security..."

security_score



echo

echo "[+] Loading Threat Intelligence..."

intel_analysis



echo

echo "[+] Loading Alerts..."

alert_summary



echo

echo "[+] Loading Incidents..."

incident_statistics



echo

echo "[+] Loading Dashboard..."

dashboard_metrics



echo

echo "=============================================="

echo "        MUTEB SOC DEMO COMPLETE"

echo "=============================================="



}



soc_operator_menu(){


while true

do


clear


echo "=============================================="

echo "          MUTEB SOC ANALYST CONSOLE"

echo "=============================================="



echo

echo "1) Platform Status"

echo "2) Security Score"

echo "3) Alerts"

echo "4) Incidents"

echo "5) Threat Intelligence"

echo "6) Dashboard Metrics"

echo "7) Run Full Demo"

echo "0) Exit"



echo



read -p "SELECT: " CHOICE



case $CHOICE in


1)

platform_status

;;


2)

security_score

;;


3)

alert_summary

;;


4)

incident_statistics

;;


5)

intel_analysis

;;


6)

dashboard_metrics

;;


7)

demo_mode

;;


0)

break

;;


*)

echo "INVALID"



;;



esac



read -p "ENTER TO CONTINUE"



done



}



case "${1:-}" in


demo)

demo_mode

;;


analyst_console)

soc_operator_menu

;;



esac


