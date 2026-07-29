#!/bin/bash

echo "======================================"
echo " MUTEB SOC GITHUB PROFESSIONAL POLISH"
echo " CODE 13"
echo "======================================"

cd ~/Muteb-SOC || exit 1



echo "[1] Backup README"

cp README.md README.md.backup_final 2>/dev/null || true



echo "[2] Create Professional README"



cat > README.md <<'EOF'

# MUTEB SOC Enterprise v1.0.0

## Security Operations Center Portfolio Platform


## Overview

MUTEB SOC is a defensive cybersecurity laboratory platform that simulates a real Security Operations Center environment.

The project demonstrates practical SOC Analyst workflows including monitoring, detection, investigation, and reporting.



# Core Capabilities


## SOC Dashboard

- Security Event Monitoring
- Alert Overview
- Incident Tracking
- System Health Status



## Detection Engineering

- Sigma Rule Concepts
- MITRE ATT&CK Mapping
- IOC Analysis
- Threat Detection Workflow



## Incident Response

- Alert Investigation
- Security Reporting
- Analyst Workflow Simulation



# Technology Stack


Backend:

- Python
- Flask


Frontend:

- React
- Vite


Database:

- SQLite



# Architecture


Security Events

↓

Collection Layer

↓

Detection Engine

↓

Alert Management

↓

SOC Dashboard

↓

Incident Response



# Installation


Clone repository:


git clone https://github.com/MUTE-B/Muteb_SOC.git



Run Backend:


python3 run.py



Run Frontend:


cd frontend

npm install

npm run dev



# Demo Account


Username:

admin


Password:

Muteb@123



# Project Information


Version:

MUTEB SOC Enterprise v1.0.0



Developer:

Muteb Albalawi


Cyber Security | IT Specialist | SOC Analyst Path



EOF




echo "[3] Add Documentation Folder"

mkdir -p screenshots



echo "[4] Git Status"


git status --short



echo ""
echo "======================================"
echo " GITHUB POLISH COMPLETE"
echo "======================================"

