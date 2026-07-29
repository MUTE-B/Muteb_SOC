#!/bin/bash

echo "======================================"
echo " MUTEB SOC PROJECT INFORMATION SYNC"
echo " CODE 19"
echo "======================================"

cd ~/Muteb-SOC || exit 1


echo "[1] Updating VERSION"

cat > VERSION <<'EOF'
MUTEB SOC Enterprise v1.0.0
EOF



echo "[2] Updating Project Overview"

cat > PROJECT_OVERVIEW.md <<'EOF'
# MUTEB SOC Enterprise v1.0.0

## Overview

MUTEB SOC is a defensive cybersecurity SOC laboratory platform designed to simulate Security Operations Center workflows.

The project demonstrates practical Blue Team operations including:

- Security Monitoring
- Alert Investigation
- Detection Engineering
- Incident Response
- Security Reporting


## Technology Stack

Backend:
Python Flask REST API

Frontend:
React + Vite

Database:
SQLite

Environment:
Linux Ubuntu


## Career Alignment

Designed for:

- SOC Analyst
- Junior Security Analyst
- Blue Team Analyst
- Cyber Security Analyst


## Developer

Muteb Albalawi

Cyber Security | IT Specialist | SOC Analyst Path
EOF




echo "[3] Updating Architecture"

cat > ARCHITECTURE.md <<'EOF'
# MUTEB SOC Architecture

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

↓

Security Reports


## Components

Backend:
Python Flask


Frontend:
React Dashboard


Database:
SQLite


Security Concepts:

- MITRE ATT&CK
- Sigma Rules
- IOC Analysis
EOF



echo "[4] Updating Release Notes"

cat > RELEASE_NOTES.md <<'EOF'
# MUTEB SOC Enterprise v1.0.0

## Final Release

Features:

- SOC Dashboard
- Authentication System
- Security Monitoring
- Alert Management
- Detection Workflow
- Incident Response Documentation


Status:

Enterprise Portfolio Release
EOF



echo "[5] Update Git Status"

git status --short


echo ""
echo "======================================"
echo " PROJECT INFORMATION SYNC COMPLETE"
echo "======================================"

