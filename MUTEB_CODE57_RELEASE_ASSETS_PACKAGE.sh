#!/bin/bash

echo "======================================"
echo " MUTEB SOC RELEASE ASSETS PACKAGE"
echo " CODE 57"
echo "======================================"

cd ~/Muteb-SOC || exit 1


echo "[1] Create release assets folders"


mkdir -p release_assets/screenshots
mkdir -p release_assets/documents



echo "[2] Create screenshot documentation"



cat > release_assets/screenshots/README.md <<'EOF'

# MUTEB SOC Screenshots Evidence


Required Images:


## 01-login.png

Authentication Interface


## 02-dashboard.png

SOC Main Dashboard


## 03-alerts.png

Security Alerts


## 04-events.png

Security Events Monitoring


## 05-reports.png

Security Reports



## 06-system-status.png

System Health Status



EOF



echo "[3] Create release notes"



cat > release_assets/RELEASE_ASSETS.md <<'EOF'

# MUTEB SOC Enterprise v2.1.1


## Release Assets


Included:


- Source Code
- Documentation
- SOC Dashboard
- Security Workflow
- Portfolio Evidence



## Demonstration Areas


- Authentication
- Monitoring
- Alerts
- Events
- Reports



## Release Type


Professional Cybersecurity Portfolio Edition



EOF



echo "[4] Create final delivery checklist"



cat > release_assets/FINAL_DELIVERY_CHECKLIST.md <<'EOF'

# Final Delivery Checklist


## Application


[ ] Backend Tested

[ ] Frontend Tested

[ ] Login Tested


## Documentation


[ ] README

[ ] Architecture

[ ] Portfolio Files


## Release


[ ] Tag Verified

[ ] Screenshots Added

[ ] GitHub Release Published



EOF



echo "[5] Git Status"

git status --short


echo ""
echo "======================================"
echo " RELEASE ASSETS READY"
echo "======================================"

