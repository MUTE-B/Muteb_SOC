#!/bin/bash

echo "======================================"
echo " MUTEB SOC GITHUB RELEASE READY"
echo " CODE 63"
echo "======================================"

cd ~/Muteb-SOC || exit 1


mkdir -p github_release



cat > github_release/RELEASE_DESCRIPTION_v2.1.1.md <<'EOF'

# MUTEB SOC Enterprise v2.1.1


## Professional Portfolio Release



## Overview


MUTEB SOC is a defensive cybersecurity SOC laboratory platform that simulates Security Operations Center workflows.


The project demonstrates practical Blue Team operations, monitoring, investigation, and security documentation.



## Main Features


### SOC Dashboard

- Security overview
- Monitoring interface
- Analyst workflow
- Event visibility



### Security Operations


- Alert review
- Investigation workflow
- Detection concepts
- Reporting process



## Technology Stack


Backend:

Python Flask


Frontend:

React


Database:

SQLite


Environment:

Linux Ubuntu



## Security Improvements


- Removed exposed demo credentials
- Protected environment files
- Improved repository security
- Organized documentation



## Portfolio Skills Demonstrated


- SOC Analyst Workflow
- Blue Team Operations
- Cybersecurity Monitoring
- Linux Administration
- Security Automation
- Technical Documentation



## Version


v2.1.1



## Status


Final Professional Portfolio Edition



Developer:

Muteb Albalawi



EOF




cat > github_release/RELEASE_ATTACHMENTS.md <<'EOF'

# Release Attachments


Recommended attachments:


- Source Code

- Documentation

- Screenshots

- Architecture Files

- Demo Evidence



EOF



echo "[1] Git Status"

git status --short



echo ""
echo "======================================"
echo " GITHUB RELEASE PACKAGE READY"
echo "======================================"

