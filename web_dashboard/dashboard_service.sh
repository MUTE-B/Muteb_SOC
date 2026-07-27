#!/bin/bash

APP_DIR="$(cd "$(dirname "$0")/.." && pwd)"

cd "$APP_DIR"


echo "================================="
echo " MUTEB SOC DASHBOARD SERVICE"
echo "================================="


python3 web_dashboard/dashboard_health.py


python3 web_dashboard/dashboard_api.py

