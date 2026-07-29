#!/bin/bash

echo "======================================"
echo " MUTEB SOC PORTFOLIO DOCUMENTATION"
echo " CODE 12"
echo "======================================"

cd ~/Muteb-SOC || exit 1


echo "[1] Create Portfolio Documentation"



cat > PORTFOLIO_OVERVIEW.md <<'EOF'

# MUTEB SOC Enterprise

## Security Operations Center Portfolio Project


## Purpose

MUTEB SOC is a defensive cybersecurity platform that simulates a real SOC environment.


## Demonstrated Skills

- SOC Monitoring
- Security Analysis
- Incident Response
- Threat Detection
- Log Investigation
- Detection Engineering
- Linux Administration
- Python Automation



## Architecture


Security Events

↓

Log Collection

↓

Detection Engine

↓

Alert Management

↓

SOC Dashboard

↓

Incident Response



## Technology

Backend:
Python Flask


Frontend:
React + Vite


Database:
SQLite



## Security Frameworks

MITRE ATT&CK

Sigma Rules

IOC Analysis



Developer:

Muteb Albalawi


EOF





echo "[2] Create Demo Guide"



cat > DEMO_GUIDE.md <<'EOF'

# MUTEB SOC Demo Guide


## Login

Username:

admin


Password:

Muteb@123



## Dashboard

The dashboard displays:

- Security Events
- Alerts
- Incident Status
- System Health



## Analyst Workflow

1. Review alerts

2. Investigate events

3. Analyze indicators

4. Document incidents



EOF





echo "[3] Create Skills Mapping"



cat > SKILLS_MAPPING.md <<'EOF'

# MUTEB SOC Skills Mapping


SOC Analyst:

✓ Alert Triage

✓ Incident Investigation

✓ Log Analysis


Blue Team:

✓ Detection Engineering

✓ Threat Hunting

✓ Security Monitoring


IT Administration:

✓ Linux

✓ Networking

✓ Automation


Programming:

✓ Python

✓ Bash

✓ React


EOF





echo "[4] Git Status"


git status --short



echo ""
echo "======================================"
echo " PORTFOLIO PACKAGE COMPLETE"
echo "======================================"

