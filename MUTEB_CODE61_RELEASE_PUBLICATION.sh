#!/bin/bash

echo "======================================"
echo " MUTEB SOC RELEASE PUBLICATION"
echo " CODE 61"
echo "======================================"

cd ~/Muteb-SOC || exit 1


mkdir -p release_notes



echo "[1] Creating GitHub Release Description"



cat > release_notes/GITHUB_RELEASE_v2.1.1.md <<'EOF'

# MUTEB SOC Enterprise v2.1.1


## Professional Portfolio Release


MUTEB SOC is a defensive cybersecurity SOC laboratory platform designed to demonstrate Security Operations Center workflows.



# Features


## SOC Dashboard

- Security monitoring
- Analyst view
- System status
- Event visibility


## Security Operations

- Alert workflow
- Investigation process
- Reporting workflow


## Technical Stack


Backend:

Python Flask


Frontend:

React


Environment:

Linux Ubuntu



# Skills Demonstrated


- SOC Analyst Operations
- Blue Team Methodology
- Cybersecurity Documentation
- Linux Administration
- Security Automation



# Release Status


Version:

v2.1.1


Status:

Professional Portfolio Edition



Developer:

Muteb Albalawi



EOF



echo "[2] Creating release checklist"



cat > release_notes/RELEASE_CHECKLIST.md <<'EOF'

# Release Checklist


[x] Source Code Ready

[x] Documentation Ready

[x] Security Cleanup Complete

[x] README Updated

[x] Portfolio Package Ready

[x] Version Verified



Release:

v2.1.1



EOF



echo "[3] Status"

git status --short



echo ""
echo "======================================"
echo " RELEASE NOTES READY"
echo "======================================"

