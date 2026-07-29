#!/bin/bash

set -e

PROJECT="/home/mte-b/Muteb-SOC"

echo "======================================"
echo " MUTEB SOC GOLD FINAL UPGRADE"
echo "======================================"

cd $PROJECT


echo "[1] BACKUP CURRENT SYSTEM"

mkdir -p gold_backup

cp backend/app.py gold_backup/app.py.$(date +%s)

cp -r frontend/src gold_backup/frontend_src.$(date +%s)


echo "[2] FIX BACKEND ENVIRONMENT"

cd backend

if [ ! -d venv ]; then
python3 -m venv venv
fi


./venv/bin/pip install --upgrade pip

./venv/bin/pip install \
flask \
flask-cors \
flask-jwt-extended \
psycopg2-binary \
werkzeug \
requests


echo "[3] CHECK BACKEND SYNTAX"

./venv/bin/python -m py_compile app.py


cd $PROJECT


echo "[4] REMOVE OLD TEMP FILES"

find . -name "*.save" -delete 2>/dev/null || true

rm -rf backup_clean 2>/dev/null || true


echo "PART 1 COMPLETE"

