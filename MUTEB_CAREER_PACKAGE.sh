#!/bin/bash


echo "======================================"
echo " MUTEB CAREER PACKAGE"
echo " FINAL JOB PRESENTATION"
echo "======================================"


mkdir -p career_package/{cv,interview,application}



#################################
# CV DESCRIPTION
#################################

cat > career_package/cv/MUTEB_CV_ENTRY.md <<'MD'


# CV Project Entry


## MUTEB SOC ENTERPRISE


AI Cyber Defense Platform


Developed an enterprise-style Security Operations platform integrating:


- SOC Monitoring

- Threat Intelligence

- AI Security Analysis

- Security Automation

- React Dashboard

- Flask API Backend



Technical Stack:


Python | Flask | React | Linux | Cyber Security Operations



Achievements:


✓ Designed security monitoring architecture

✓ Built cybersecurity dashboard

✓ Implemented automated security workflow simulation

✓ Created enterprise documentation package



MD




#################################
# INTERVIEW QUESTIONS
#################################

cat > career_package/interview/SOC_INTERVIEW_QA.md <<'MD'


# SOC Interview Preparation


## Q1:
What is MUTEB SOC?


Answer:

A cybersecurity platform simulating SOC operations including monitoring, analysis and response.



## Q2:
How does security workflow work?


Answer:


Log Collection

↓

Detection

↓

Investigation

↓

Response

↓

Reporting



## Q3:
What technologies were used?


Answer:


Python backend

React frontend

Linux environment

Security concepts



## Q4:
What security areas does it cover?


Answer:


SOC

Threat Intelligence

Automation

Incident Response



MD




#################################
# APPLICATION PLAN
#################################

cat > career_package/application/APPLICATION_PLAN.md <<'MD'


# Career Application Plan


Target Roles:


- SOC Analyst

- Cyber Security Analyst

- Security Engineer

- Blue Team Analyst



Present:


1. GitHub Repository

2. Project Demo

3. Architecture

4. Technical Explanation



MD




#################################
# PROJECT LINKS TEMPLATE
#################################

cat > career_package/application/PROJECT_LINKS.md <<'MD'


# Project Links


GitHub:

(Add Repository Link)



Demo:

(Add Demo Link)



Portfolio:

(Add Portfolio Link)



MD




git add .

git commit -m "MUTEB Career Presentation Package" || true

git push origin main || true



echo ""

echo "======================================"

echo " CAREER PACKAGE COMPLETE"

echo "======================================"


