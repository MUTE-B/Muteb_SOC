#!/bin/bash

echo "======================================"
echo " MUTEB SOC FINAL RELEASE PREPARATION"
echo " CODE 29"
echo "======================================"

cd ~/Muteb-SOC || exit 1


echo "[1] Creating final release notes"


cat > RELEASE_NOTES_v2.1.1.md <<'EOF'

# MUTEB SOC Enterprise v2.1.1


## Professional Portfolio Release


## Summary

MUTEB SOC is a defensive cybersecurity SOC laboratory platform that simulates Security Operations Center operations.


## Included Features


### SOC Platform

- Enterprise Login Interface
- SOC Analyst Dashboard
- Security Status Monitoring
- Alert Visualization
- Security Event Workflow


### Blue Team Capabilities

- Log Analysis Concepts
- Threat Investigation Workflow
- Incident Response Process
- Security Reporting


### Detection Engineering

- MITRE ATT&CK Mapping
- Sigma Rule Concepts
- IOC Analysis Workflow


## Technology Stack


Backend:

- Python Flask


Frontend:

- React


Database:

- SQLite


Operating Environment:

- Linux Ubuntu


Version Control:

- GitHub



## Portfolio Value


Demonstrates practical skills in:


- SOC Operations
- Blue Team Security
- Security Monitoring
- Detection Engineering
- Cybersecurity Documentation



## Developer


Muteb Albalawi

Cyber Security | IT Specialist | SOC Analyst Path


EOF





echo "[2] Update changelog"



cat > CHANGELOG_v2.1.1.md <<'EOF'

# CHANGELOG v2.1.1


## Added

- Professional SOC Dashboard Interface
- Enterprise Login Design
- Portfolio Documentation Package
- Demo Evidence Structure


## Improved

- User Interface Layout
- Project Documentation
- Release Organization


## Security Focus

- Blue Team Workflow
- SOC Analyst Simulation
- Detection Engineering Concepts


EOF





echo "[3] Git status"

git status --short



echo ""
echo "======================================"
echo " RELEASE PACKAGE READY"
echo "======================================"

