#!/bin/bash

echo "======================================"
echo " MUTEB SOC DEMO EVIDENCE PACKAGE"
echo " CODE 18"
echo "======================================"

cd ~/Muteb-SOC || exit 1


echo "[1] Creating demo folders"

mkdir -p demo/screenshots
mkdir -p demo/evidence


echo "[2] Creating demo documentation"


cat > demo/DEMO_PRESENTATION.md <<'EOF'
# MUTEB SOC Enterprise v1.0.0

## Demo Overview

MUTEB SOC is a defensive cybersecurity SOC laboratory platform.

The project simulates Security Operations Center workflows:

- Security Monitoring
- Alert Analysis
- Detection Engineering
- Incident Response
- Security Reporting


## Application Flow

Authentication

↓

SOC Dashboard

↓

Security Events

↓

Alert Investigation

↓

Incident Response

↓

Reports


## Technology Stack

Backend:
Python Flask REST API

Frontend:
React + Vite

Database:
SQLite

Environment:
Linux Ubuntu


## Developer

Muteb Albalawi

Cyber Security | IT Specialist | SOC Analyst Path

EOF



cat > demo/screenshots/README.md <<'EOF'
# MUTEB SOC Screenshots

Required screenshots:

01-login.png

Login Interface


02-dashboard.png

SOC Dashboard


03-alerts.png

Security Alerts


04-reports.png

Security Reports

EOF



echo "[3] Checking files"

ls -la demo
ls -la demo/screenshots


echo ""
echo "======================================"
echo " DEMO PACKAGE READY"
echo "======================================"

