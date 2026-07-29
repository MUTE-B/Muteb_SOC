#!/bin/bash


echo "======================================"
echo " MUTEB SOC ENTERPRISE DEMO READY"
echo " FINAL PRESENTATION SETUP"
echo "======================================"


mkdir -p demo_ready/{screenshots,video,cv}



#################################
# DEMO GUIDE
#################################

cat > demo_ready/DEMO_RUNBOOK.md <<'MD'

# MUTEB SOC ENTERPRISE DEMO


## Step 1

Start Backend:

python3 backend/app.py



## Step 2

Start Frontend:

npm run dev



## Step 3

Open Dashboard


Show:


✓ SOC Status

✓ AI Security

✓ Threat Intelligence

✓ Automation

✓ Cloud Status



## Step 4

Explain Security Flow:


Event

↓

Detection

↓

AI Analysis

↓

Response

↓

Report



MD




#################################
# CV DESCRIPTION
#################################

cat > demo_ready/cv/PROJECT_CV_DESCRIPTION.md <<'MD'


# CV Project Description


## MUTEB SOC ENTERPRISE


Developed an AI-powered Cyber Defense Platform simulating enterprise SOC operations.


Key Skills Demonstrated:


- Security Operations Center (SOC)

- Threat Intelligence

- Security Automation

- Python Development

- Linux Administration

- React Dashboard Development

- API Integration



Role:

Cyber Security Platform Developer



MD




#################################
# VIDEO SCRIPT
#################################

cat > demo_ready/video/VIDEO_SCRIPT.md <<'MD'


# Demo Video Script


Duration:

3-5 Minutes



Introduction:


"This is MUTEB SOC Enterprise, an AI-powered cyber defense platform."



Demonstration:


1. Dashboard Overview

2. Security Status

3. AI Analysis

4. Threat Monitoring

5. Automated Response



Conclusion:


"The platform provides an integrated approach for modern cybersecurity operations."



MD




#################################
# FINAL STATUS
#################################

cat > demo_ready/READY_STATUS.txt <<'TXT'


MUTEB SOC ENTERPRISE

DEMO STATUS:

READY


Presentation:
READY

Portfolio:
READY

Interview:
READY


TXT




echo ""

echo "Creating final commit..."


git add .


git commit -m "MUTEB Demo and Career Presentation Package" || true


git push origin main || true



echo ""

echo "======================================"

echo " MUTEB DEMO PACKAGE COMPLETE"

echo "======================================"


