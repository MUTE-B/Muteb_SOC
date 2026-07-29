#!/bin/bash

echo "======================================"
echo " MUTEB SOC PORTFOLIO DEMO PACKAGE"
echo " CODE 25"
echo "======================================"

cd ~/Muteb-SOC || exit 1


echo "[1] Create portfolio folders"


mkdir -p portfolio/screenshots
mkdir -p portfolio/demo



echo "[2] Create portfolio overview"



cat > portfolio/PROJECT_SHOWCASE.md <<'EOF'

# MUTEB SOC Enterprise v2.1.1

## Cyber Security SOC Analyst Portfolio Project


## Overview

MUTEB SOC is a defensive cybersecurity laboratory platform designed to simulate a real Security Operations Center environment.


## Main Capabilities


### Security Monitoring

- System status monitoring
- Security event review
- Alert visibility
- Analyst workflow simulation


### Detection Engineering

- Detection concepts
- Sigma rule concepts
- MITRE ATT&CK mapping
- IOC analysis


### Incident Response

- Alert investigation workflow
- Security reporting
- Analyst documentation


## Technology Stack


Backend:

- Python Flask


Frontend:

- React


Database:

- SQLite


Environment:

- Linux Ubuntu


Version Control:

- GitHub



## Demonstration Flow


1. Open Login Interface

2. Authenticate SOC Analyst User

3. Access Dashboard

4. Review Security Status

5. Analyze Alerts

6. Review Security Events

7. Generate Reports



## Developer


Muteb Albalawi

Cyber Security | IT Specialist | SOC Analyst Path


EOF





echo "[3] Create screenshot guide"



cat > portfolio/screenshots/README.md <<'EOF'

# MUTEB SOC Screenshots


Required screenshots:


01-login.png

Login interface


02-dashboard.png

Main SOC Dashboard


03-alerts.png

Security Alerts


04-events.png

Security Events


05-reports.png

Security Reports



EOF





echo "[4] Git status"


git status --short



echo ""
echo "======================================"
echo " PORTFOLIO PACKAGE READY"
echo "======================================"

