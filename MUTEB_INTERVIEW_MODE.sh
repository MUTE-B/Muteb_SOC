#!/bin/bash


echo "======================================"
echo " MUTEB INTERVIEW MODE"
echo " SOC ANALYST PRESENTATION"
echo "======================================"


mkdir -p interview



#################################
# PROJECT PRESENTATION
#################################

cat > interview/PROJECT_PRESENTATION.md <<'MD'


# MUTEB SOC ENTERPRISE Presentation


## Introduction


MUTEB SOC Enterprise is an integrated cybersecurity operations platform designed to simulate an enterprise Security Operations Center.



## Architecture Explanation


The platform contains:


1. Detection Layer


- SIEM

- EDR

- NDR



2. Intelligence Layer


- Threat Intelligence

- AI Security Copilot



3. Response Layer


- SOAR

- Incident Response



4. Governance Layer


- Risk Management

- Compliance

- Zero Trust



## Analyst Workflow


Alert Detection

↓

Investigation

↓

Threat Analysis

↓

Containment

↓

Recovery

↓

Report



MD




#################################
# ATTACK SCENARIO
#################################

cat > interview/ATTACK_SCENARIO.md <<'MD'


# SOC Attack Scenario



## Scenario


A user opens a malicious attachment.



## Detection


SIEM detects unusual behavior.



## Investigation


EDR identifies suspicious process activity.



## Intelligence


Threat Intelligence checks indicators.



## Response


SOAR executes containment actions.



## Recovery


DFIR analyzes evidence.



## Final Result


Threat removed and security controls improved.



MD




#################################
# SOC QUESTIONS
#################################

cat > interview/SOC_ANALYST_QA.md <<'MD'


# SOC Analyst Interview Questions



## What is SIEM?


A platform that collects and analyzes security logs from different sources.



## Difference between IDS and IPS?


IDS detects threats.

IPS detects and blocks threats.



## What is SOAR?


Automation platform for security response workflows.



## What is EDR?


Endpoint monitoring and threat response technology.



## What is Zero Trust?


Security model based on continuous verification and least privilege.



## Incident Response Steps?


Preparation

Identification

Containment

Eradication

Recovery

Lessons Learned



MD




#################################
# FINAL DEMO SCRIPT
#################################

cat > interview/DEMO_SCRIPT.md <<'MD'


# Demo Script


1.

Open SOC Dashboard


2.

Show Security Alert


3.

Explain Investigation


4.

Show AI Analysis


5.

Explain Response Automation


6.

Show Final Report



Duration:

5 Minutes



MD




echo ""

echo "======================================"
echo " INTERVIEW MODE COMPLETE"
echo "======================================"


