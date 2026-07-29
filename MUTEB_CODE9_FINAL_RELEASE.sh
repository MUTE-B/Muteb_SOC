#!/bin/bash

echo "======================================"
echo " MUTEB SOC ENTERPRISE FINAL RELEASE"
echo " CODE 9"
echo "======================================"

cd ~/Muteb-SOC || exit 1


echo "[1] Update Version"

echo "MUTEB SOC Enterprise v1.0.0" > VERSION



echo "[2] Create Release Notes"



cat > RELEASE_v1.0.0.md <<'EOF'

# MUTEB SOC Enterprise v1.0.0

## Overview

MUTEB SOC is a defensive Security Operations Center platform designed for SOC Analyst training and portfolio demonstration.


## Features

- Security Monitoring Dashboard
- Authentication System
- SOC Alert Management
- Incident Tracking
- Detection Engineering
- MITRE ATT&CK Mapping
- Sigma Rule Support
- Linux Security Monitoring
- Security Reporting


## Technology Stack

Backend:
- Python
- Flask
- SQLite


Frontend:
- React
- Vite
- Modern SOC Dashboard UI


Security Concepts:

- Blue Team Operations
- Threat Detection
- Incident Response
- Log Analysis


## Developer

Muteb Albalawi

Cyber Security | IT Specialist | SOC Analyst Path


EOF



echo "[3] Git Add"

git add .


echo "[4] Commit Release"


git commit -m "MUTEB SOC Enterprise v1.0.0 Final Release" || true



echo "[5] Create Tag"


git tag -a v1.0.0 -m "MUTEB SOC Enterprise v1.0.0" 2>/dev/null || true



echo ""
echo "======================================"
echo " RELEASE READY"
echo "======================================"

git status


