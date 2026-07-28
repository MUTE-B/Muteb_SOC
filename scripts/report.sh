#!/usr/bin/env bash

set -Eeuo pipefail


ROOT="$HOME/Muteb-SOC"

REPORT_DIR="$ROOT/reports"

mkdir -p "$REPORT_DIR"


REPORT="$REPORT_DIR/MUTEB_SOC_REPORT_$(date +%Y%m%d_%H%M%S).txt"



{

echo "================================================"

echo "          MUTEB SOC ENTERPRISE REPORT"

echo "================================================"

echo

echo "DATE: $(date)"

echo

echo "HOSTNAME: $(hostname)"

echo


echo "================ SYSTEM ================"

echo

uname -a

echo

uptime

echo


echo "================ MEMORY ================"

free -h


echo


echo "================ STORAGE ================"

df -h


echo


echo "================ NETWORK ================"

hostname -I

echo


echo "================ SERVICES ================"


ps aux | grep -E \
"python3 run.py|vite" \
| grep -v grep || true



echo


echo "================ PORTS ================"


ss -tulpn | grep -E "8000|5173|22|80" || true



echo


echo "================ PYTHON ================"


python3 --version


echo


echo "================ NODE ================"


node -v 2>/dev/null || echo "Node unavailable"


npm -v 2>/dev/null || echo "NPM unavailable"



echo


echo "================ PROJECT ================"


find "$ROOT/app" \
-type f \
-name "*.py" \
| wc -l


echo "Python files"


find "$ROOT/frontend/src" \
-type f \
| wc -l


echo "Frontend files"



echo


echo "================ GIT ================"


cd "$ROOT"

git status

echo

git log --oneline -5



echo


echo "================ SECURITY ================"


journalctl \
-u ssh \
--no-pager \
| grep Failed \
| tail -20 || true



echo


echo "================ END ================"


} > "$REPORT"



echo

echo "Report Generated"

echo "$REPORT"

