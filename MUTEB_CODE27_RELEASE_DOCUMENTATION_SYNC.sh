#!/bin/bash

echo "======================================"
echo " MUTEB SOC RELEASE DOCUMENTATION SYNC"
echo " CODE 27"
echo "======================================"

cd ~/Muteb-SOC || exit 1


echo "[1] Updating Release Documentation"


cat > RELEASE_V2.1.1.md <<'EOF'

# MUTEB SOC Enterprise v2.1.1

## Professional SOC Analyst Portfolio Release


## Overview

MUTEB SOC is a defensive cybersecurity SOC laboratory platform designed to simulate Security Operations Center workflows.

The project demonstrates practical Blue Team operations including monitoring, detection concepts, alert investigation, and security reporting.


## Core Capabilities


### Security Operations

- SOC Dashboard
- Security Monitoring
- Alert Management
- Event Analysis
- Analyst Workflow Simulation


### Detection Engineering

- MITRE ATT&CK Concepts
- Sigma Detection Concepts
- IOC Analysis
- Security Investigation Workflow


### Incident Response

- Alert Review
- Investigation Process
- Security Reporting


## Technology Stack


Backend:

Python Flask


Frontend:

React


Database:

SQLite


Environment:

Linux Ubuntu


Version Control:

GitHub



## Project Purpose


Designed as a practical portfolio project for:


- SOC Analyst
- Blue Team Analyst
- Cyber Security Analyst



## Developer


Muteb Albalawi

Cyber Security | IT Specialist | SOC Analyst Path


EOF





echo "[2] Updating version information"


echo "MUTEB SOC Enterprise v2.1.1" > VERSION



echo "[3] Git status"


git status --short



echo ""
echo "======================================"
echo " RELEASE DOCUMENTATION READY"
echo "======================================"

