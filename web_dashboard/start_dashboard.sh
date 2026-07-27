#!/bin/bash

echo "================================="
echo "   MUTEB SOC DASHBOARD START"
echo "================================="


python3 web_dashboard/dashboard_health.py


python3 web_dashboard/dashboard_api.py

