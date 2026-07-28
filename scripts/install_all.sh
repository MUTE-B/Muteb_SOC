#!/usr/bin/env bash

set -Eeuo pipefail


ROOT="$HOME/Muteb-SOC"

echo "================================================"

echo "     MUTEB SOC ENTERPRISE INSTALLER"

echo "================================================"


cd "$ROOT"



echo

echo "[1] SYSTEM UPDATE"


sudo apt update



echo

echo "[2] INSTALL SYSTEM TOOLS"



sudo apt install -y \
git \
curl \
wget \
python3 \
python3-pip \
python3-venv \
nodejs \
npm \
net-tools \
htop \
jq \
tree



echo

echo "[3] PYTHON ENVIRONMENT"



if [ ! -d venv ]

then

python3 -m venv venv

fi



source venv/bin/activate



echo

echo "[4] PYTHON PACKAGES"



if [ -f requirements.txt ]

then

pip install --upgrade pip

pip install -r requirements.txt

fi



echo

echo "[5] FRONTEND PACKAGES"



cd frontend


npm install


cd ..



echo

echo "[6] CREATE DIRECTORIES"



mkdir -p logs

mkdir -p reports

mkdir -p backups



echo

echo "[7] PERMISSIONS"



chmod +x scripts/*.sh



echo

echo "[8] VALIDATION"



python3 -m compileall app



echo

echo "================================================"

echo " INSTALLATION COMPLETE"

echo "================================================"



echo

echo "START COMMAND"

echo "./scripts/start.sh"



