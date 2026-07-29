#!/bin/bash


echo "======================================"
echo " MUTEB ENTERPRISE DEMO ENVIRONMENT"
echo "======================================"


mkdir -p demo_environment/events
mkdir -p demo_environment/incidents
mkdir -p demo_environment/threats
mkdir -p demo_environment/reports



####################################
# DEMO SECURITY EVENTS
####################################


cat > demo_environment/events/security_events.json <<'JSON'
[
{
"event":"Multiple Failed Logins",
"source":"Windows Server",
"severity":"HIGH",
"status":"INVESTIGATING"
},

{
"event":"Malware Detection",
"source":"Endpoint",
"severity":"CRITICAL",
"status":"CONTAINED"
},

{
"event":"Suspicious Network Traffic",
"source":"Firewall",
"severity":"MEDIUM",
"status":"MONITORING"
}
]
JSON




####################################
# INCIDENT SCENARIOS
####################################


cat > demo_environment/incidents/scenarios.md <<'MD'


# MUTEB Demo Incident Scenarios



## Scenario 1

Phishing Attack Detection


Response:

- Alert Created
- IOC Extracted
- User Investigated
- Threat Contained



## Scenario 2

Malware Infection


Response:

- Endpoint Isolation
- Evidence Collection
- Recovery Process



MD




####################################
# THREAT DATA
####################################


cat > demo_environment/threats/demo_ioc.json <<'JSON'
[
{
"type":"IP",
"value":"192.168.1.50",
"risk":"HIGH"
},

{
"type":"HASH",
"value":"a8f92-example",
"risk":"CRITICAL"
}
]
JSON




####################################
# DEMO REPORT
####################################


cat > demo_environment/reports/DEMO_REPORT.md <<'MD'


# MUTEB Enterprise Demo Report



Environment:

SOC Simulation



Includes:


✓ Security Events

✓ Threat Detection

✓ Incident Response

✓ IOC Analysis

✓ Security Reporting



Status:


Demo Ready



MD





echo ""

echo "======================================"

echo " CODE 930 COMPLETE"

echo "======================================"


