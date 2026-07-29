#!/bin/bash

echo "======================================"
echo " MUTEB SOC FINAL SHOWCASE PACKAGE"
echo " CODE 30"
echo "======================================"

cd ~/Muteb-SOC || exit 1


echo "[1] Create showcase folder"

mkdir -p showcase



echo "[2] Create company presentation file"


cat > showcase/COMPANY_PRESENTATION.md <<'EOF'

# MUTEB SOC Enterprise v2.1.1

## Cyber Security SOC Analyst Portfolio


## Project Description

MUTEB SOC is a defensive cybersecurity laboratory platform designed to simulate a real Security Operations Center environment.


## Demonstrated Skills


### SOC Operations

- Security Monitoring
- Alert Review
- Event Analysis
- Incident Workflow


### Blue Team Security

- Threat Detection Concepts
- Investigation Process
- Security Reporting


### Technical Skills

- Python Flask Backend
- React Frontend
- Linux Administration
- GitHub Version Control
- Cybersecurity Documentation



## Architecture Flow


Security Events

↓

Log Collection

↓

Detection Analysis

↓

Alerts

↓

SOC Dashboard

↓

Incident Response



## Release

MUTEB SOC Enterprise v2.1.1



## Developer

Muteb Albalawi


Cyber Security | IT Specialist | SOC Analyst Path


EOF




echo "[3] Create Demo Instructions"



cat > showcase/DEMO_RUNBOOK.md <<'EOF'

# MUTEB SOC Demo Runbook


## Demo Flow


1. Open Application


2. Login as SOC Analyst


3. Review Dashboard


4. Check Security Status


5. Analyze Alerts


6. Review Security Events


7. Present Documentation



## Expected Demonstration


The platform demonstrates SOC monitoring workflow and Blue Team security operations.


EOF





echo "[4] Git status"

git status --short



echo ""
echo "======================================"
echo " SHOWCASE PACKAGE READY"
echo "======================================"

