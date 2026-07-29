#!/bin/bash

echo "======================================"
echo " MUTEB SOC PUBLIC PRESENTATION PACKAGE"
echo " CODE 49"
echo "======================================"

cd ~/Muteb-SOC || exit 1


echo "[1] Create public documentation folder"

mkdir -p docs/public



echo "[2] Create project presentation"



cat > docs/public/PROJECT_PRESENTATION.md <<'EOF'

# MUTEB SOC Enterprise v2.1.1


## Cyber Security SOC Analyst Portfolio Project


## Overview


MUTEB SOC is a defensive cybersecurity laboratory platform that simulates Security Operations Center operations.


The project demonstrates practical Blue Team workflows including monitoring, alert analysis, investigation, and security reporting.



## Core Features


### SOC Dashboard

- Security overview
- Event monitoring
- Alert visibility
- Analyst workflow



### Security Operations

- Detection concepts
- Incident response workflow
- Threat investigation
- Security documentation



### Technology


Backend:

Python Flask


Frontend:

React


Environment:

Linux Ubuntu


Version Control:

GitHub



## Skills Demonstrated


- SOC Analyst Operations
- Blue Team Security
- Linux Administration
- Cybersecurity Automation
- Security Documentation



## Release


MUTEB SOC Enterprise v2.1.1



Developer:

Muteb Albalawi


EOF




echo "[3] Create public navigation file"



cat > docs/public/README.md <<'EOF'

# Public Documentation


Available Documents:


- Project Presentation
- Architecture Overview
- Release Information
- SOC Workflow


EOF



echo "[4] Status"

git status --short



echo ""
echo "======================================"
echo " PUBLIC PACKAGE READY"
echo "======================================"

