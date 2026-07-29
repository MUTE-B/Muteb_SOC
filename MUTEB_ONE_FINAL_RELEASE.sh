#!/bin/bash

echo "======================================"
echo " MUTEB SOC ENTERPRISE"
echo " ONE FINAL RELEASE"
echo " VERSION 10.0 FINAL"
echo "======================================"


############################
# CHECK
############################

echo "[1] Checking Project"

[ -d backend ] && echo "Backend OK"
[ -d frontend ] && echo "Frontend OK"



############################
# BACKEND
############################

echo "[2] Starting Backend"

cd backend

nohup python3 app.py > backend.log 2>&1 &

sleep 3

curl http://localhost:8000 || echo "API Running Check"



############################
# FRONTEND
############################

echo "[3] Starting Frontend"

cd ../frontend

nohup npm run dev > frontend.log 2>&1 &

sleep 5


echo "Frontend Started"



############################
# FINAL STRUCTURE
############################

cd ..

mkdir -p docs/images
mkdir -p docs/demo
mkdir -p final_package



############################
# DEMO
############################

cat > final_package/DEMO.md <<'EOF'

# MUTEB SOC ENTERPRISE DEMO


Show:


1. Dashboard

2. SOC Monitoring

3. AI Security Analysis

4. Threat Intelligence

5. Automation



Status:

Enterprise Ready


