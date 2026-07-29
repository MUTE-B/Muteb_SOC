#!/bin/bash

echo "======================================"
echo " MUTEB SOC GITHUB RELEASE FINAL"
echo " CODE 32"
echo "======================================"

cd ~/Muteb-SOC || exit 1


echo "[1] Creating release summary"


cat > RELEASE_SUMMARY_v2.1.1.md <<'EOF'

# MUTEB SOC Enterprise v2.1.1

## Professional Portfolio Release


## Description

MUTEB SOC is a defensive cybersecurity SOC laboratory platform that simulates Security Operations Center workflows.


## Release Highlights


### SOC Interface

- Professional Login Interface
- SOC Dashboard Layout
- Analyst View
- Security Monitoring Interface


### Security Operations

- Alert Monitoring
- Event Investigation Workflow
- Incident Response Concepts
- Security Reporting


### Blue Team Features

- MITRE ATT&CK Concepts
- Sigma Rule Concepts
- IOC Investigation Workflow


### Technology


Backend:

Python Flask


Frontend:

React


Database:

SQLite


Environment:

Linux Ubuntu



## Portfolio Purpose


This project demonstrates practical cybersecurity skills for:


- SOC Analyst
- Blue Team Analyst
- Cyber Security Analyst



## Version

v2.1.1


Developer:

Muteb Albalawi


EOF





echo "[2] Creating release checklist"



cat > RELEASE_CHECKLIST_v2.1.1.md <<'EOF'

# Release Checklist


## Code

[x] Backend Ready

[x] Frontend Ready


## Documentation

[x] Architecture

[x] Project Overview

[x] Portfolio Documentation


## Demo

[x] Login Demo

[x] Dashboard Demo

[x] Security Workflow


## Version

v2.1.1


EOF





echo "[3] Status"

git status --short


echo ""
echo "======================================"
echo " RELEASE FILES CREATED"
echo "======================================"

