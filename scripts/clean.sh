#!/usr/bin/env bash

set -Eeuo pipefail

ROOT="$HOME/Muteb-SOC"


echo "Stopping services..."

pkill -f "python3 run.py" || true

pkill -f "vite" || true


echo "Cleaning cache..."

rm -rf frontend/node_modules/.cache

rm -rf frontend/dist


echo "Removing temporary files..."

find "$ROOT" \
-name "*.pyc" \
-delete


find "$ROOT" \
-name "__pycache__" \
-type d \
-exec rm -rf {} +


echo "Cleaning completed"

