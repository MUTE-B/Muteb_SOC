#!/bin/bash

echo "======================================"
echo " MUTEB SOC GITHUB SHOWCASE FINAL"
echo " CODE 56"
echo "======================================"

cd ~/Muteb-SOC || exit 1


echo "[1] Create showcase structure"


mkdir -p showcase/evidence
mkdir -p showcase/screenshots



echo "[2] Create quick start guide"



cat > showcase/QUICK_START.md <<'EOF'

# MUTEB SOC Enterprise v2.1.1

## Quick Start Guide


## Requirements


- Linux Ubuntu
- Python 3
- Node.js
- Git


## Backend


Start backend service:

python app.py



## Frontend


Start frontend:


npm install

npm run dev




## Access


Frontend:

http://localhost:5173



## Demo Flow


1. Login

2. Open SOC Dashboard

3. Review Alerts

4. Check Reports



EOF




echo "[3] Create showcase summary"



cat > showcase/SHOWCASE.md <<'EOF'

# MUTEB SOC Enterprise Showcase


## Project


Defensive Cybersecurity SOC Laboratory Platform



## Demonstrated Skills


- SOC Monitoring
- Alert Analysis
- Incident Response
- Detection Engineering
- Linux Security
- Automation



## Release


v2.1.1


Status:

Professional Portfolio Edition



Developer:

Muteb Albalawi



EOF




echo "[4] Create evidence index"



cat > showcase/evidence/README.md <<'EOF'

# Evidence Files


Add:


- Screenshots
- Demo Results
- Test Reports
- Architecture Images



EOF



echo "[5] Git Status"


git status --short



echo ""
echo "======================================"
echo " SHOWCASE READY"
echo "======================================"

