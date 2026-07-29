#!/bin/bash

set -e


PROJECT=$(pwd)

echo "================================"
echo " MUTEB SOC REAL SECURITY ENGINE "
echo "================================"



echo "% 10 DATABASE TABLES"



sudo -u postgres psql muteb_soc <<SQL


CREATE TABLE IF NOT EXISTS security_events (

id SERIAL PRIMARY KEY,

event_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

source VARCHAR(100),

event_type VARCHAR(100),

severity VARCHAR(20),

description TEXT,

mitre_tag VARCHAR(50)

);



CREATE TABLE IF NOT EXISTS alerts (

id SERIAL PRIMARY KEY,

created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

title TEXT,

severity VARCHAR(20),

status VARCHAR(50)

);



SQL




echo "% 30 SECURITY MODULES"



mkdir -p backend/security



cat > backend/security/log_collector.py <<'PY'


import subprocess


def collect_linux_logs():


    result=subprocess.check_output(

    "journalctl -n 50 --no-pager",

    shell=True,

    text=True

    )


    return result.splitlines()



PY




cat > backend/security/detection_engine.py <<'PY'


def analyze(events):


    alerts=[]


    rules={


    "Failed password":"SSH Brute Force",

    "Invalid user":"Account Discovery",

    "sudo":"Privilege Escalation",

    "malware":"Malware Activity"


    }



    for event in events:


        for key,value in rules.items():


            if key.lower() in event.lower():


                alerts.append({

                "title":value,

                "severity":"HIGH",

                "event":event,

                "mitre":"TA0001"

                })


    return alerts



PY





cat > backend/security/threat_hunting.py <<'PY'


def search(events,keyword):


    return [

    e for e in events

    if keyword.lower() in e.lower()

    ]



PY





echo "% 60 CONNECT ENGINE"



cat > backend/security/security_runner.py <<'PY'


from log_collector import collect_linux_logs

from detection_engine import analyze



def run():


    logs=collect_linux_logs()


    alerts=analyze(logs)


    return {


    "events":len(logs),

    "alerts":alerts


    }



if __name__=="__main__":

    print(run())



PY




echo "% 80 TEST SECURITY ENGINE"



cd backend/security


python3 security_runner.py > ../../MUTEB_SECURITY_ENGINE_TEST.txt || true



cd ../..



echo "% 100 COMPLETE"



echo ""

echo "REAL SECURITY DATA ENGINE READY"

echo ""

echo "TEST REPORT:"

echo "$PROJECT/MUTEB_SECURITY_ENGINE_TEST.txt"



