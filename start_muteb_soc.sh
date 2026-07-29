#!/bin/bash

echo "Starting MUTEB SOC Enterprise"


echo "[1] Starting Backend"

cd ~/Muteb-SOC

source venv/bin/activate

python app.py &


sleep 5


echo "[2] Starting Frontend"


cd ~/Muteb-SOC/frontend

npm run dev
