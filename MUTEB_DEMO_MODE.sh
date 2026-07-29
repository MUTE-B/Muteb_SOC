#!/bin/bash


echo "======================================"
echo " MUTEB SOC DEMO MODE"
echo " INCIDENT SIMULATION ENVIRONMENT"
echo "======================================"


mkdir -p demo/{alerts,incidents,logs,scenarios,reports}



#################################
# DEMO ALERT DATA
#################################

cat > demo/alerts/security_alerts.json <<'JSON'


[
 {
  "id":1,
  "type":"Malware Detection",
  "severity":"HIGH",
  "source":"Endpoint",
  "status":"INVESTIGATING"
 },

 {
  "id":2,
  "type":"Suspicious Login",
  "severity":"MEDIUM",
  "source":"Identity System",
  "status":"MONITORING"
 },

 {
  "id":3,
  "type":"Network Anomaly",
  "severity":"CRITICAL",
  "source":"NDR",
  "status":"RESPONDING"
 }
]


JSON




#################################
# INCIDENT RESPONSE SCENARIO
#################################

cat > demo/scenarios/incident_case.md <<'MD'


# Incident Case


## Scenario


Detected suspicious network activity followed by abnormal endpoint behavior.



## SOC Workflow


1. Alert Detection


2. Investigation


3. Threat Analysis


4. Containment


5. Recovery


6. Lessons Learned



## Tools Used


✓ SIEM

✓ EDR

✓ NDR

✓ Threat Intelligence

✓ DFIR



Status:


Resolved



MD




#################################
# DEMO ENGINE
#################################

cat > demo/demo_engine.py <<'PY'


import json



class DemoSOC:


    def load_alerts(self):

        with open(
        "demo/alerts/security_alerts.json"
        ) as file:

            return json.load(file)



    def run(self):

        alerts=self.load_alerts()


        return {


        "demo":

        "ACTIVE",


        "alerts":

        len(alerts),


        "workflow":

        "SOC INVESTIGATION"



        }



if __name__=="__main__":


    print(

    DemoSOC().run()

    )



PY




#################################
# DEMO REPORT
#################################

cat > demo/reports/DEMO_REPORT.md <<'MD'


# MUTEB SOC Demo Report


Environment:


Demo Security Operations Center



Included:


✓ Alert Simulation

✓ Incident Response

✓ Threat Investigation

✓ Security Workflow



Purpose:


SOC Analyst Demonstration



MD




#################################
# RUN DEMO
#################################

python3 demo/demo_engine.py



echo ""

echo "======================================"
echo " DEMO MODE READY"
echo "======================================"


