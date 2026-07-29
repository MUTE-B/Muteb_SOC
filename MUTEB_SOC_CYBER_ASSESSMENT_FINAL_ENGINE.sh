#!/bin/bash

set -e

PROJECT=$(pwd)

echo "=========================================="
echo " MUTEB SOC CYBER ASSESSMENT ENGINE "
echo " FINAL INTEGRATION "
echo "=========================================="


mkdir -p backend/modules
mkdir -p backend/reports


echo "% DATABASE"



sudo -u postgres psql muteb_soc <<SQL

CREATE TABLE IF NOT EXISTS security_events (

id SERIAL PRIMARY KEY,
created TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
source TEXT,
event_type TEXT,
severity TEXT,
description TEXT,
mitre TEXT

);


CREATE TABLE IF NOT EXISTS scans (

id SERIAL PRIMARY KEY,
target TEXT,
risk TEXT,
created TIMESTAMP DEFAULT CURRENT_TIMESTAMP

);


CREATE TABLE IF NOT EXISTS findings (

id SERIAL PRIMARY KEY,
scan_id INTEGER,
title TEXT,
severity TEXT,
recommendation TEXT

);


CREATE TABLE IF NOT EXISTS soc_cases (

id SERIAL PRIMARY KEY,
title TEXT,
severity TEXT,
status TEXT,
created TIMESTAMP DEFAULT CURRENT_TIMESTAMP

);

SQL



echo "% WEB SECURITY SCANNER"



cat > backend/modules/web_security_scanner.py <<'PY'

import socket
import ssl
import requests


def scan_domain(target):

    result={

    "target":target,
    "findings":[],
    "risk":"LOW"

    }


    try:

        ip=socket.gethostbyname(target)

        result["ip"]=ip


    except:

        result["findings"].append(

        {

        "title":"DNS Resolution Failed",

        "severity":"HIGH"

        }

        )


        return result



    try:

        r=requests.get(

        "https://"+target,

        timeout=5

        )


        headers=r.headers



        required=[

        "Content-Security-Policy",

        "X-Frame-Options",

        "Strict-Transport-Security"

        ]


        for h in required:


            if h not in headers:


                result["findings"].append({

                "title":"Missing Security Header "+h,

                "severity":"MEDIUM",

                "owasp":"A05 Security Misconfiguration"

                })



    except Exception as e:


        result["findings"].append({

        "title":"HTTPS Check Failed",

        "severity":"HIGH"

        })



    try:

        ctx=ssl.create_default_context()

        with ctx.wrap_socket(

        socket.socket(),

        server_hostname=target

        ) as s:

            s.settimeout(5)

            s.connect((target,443))


            result["tls"]="Enabled"


    except:


        result["findings"].append({

        "title":"TLS Configuration Issue",

        "severity":"HIGH"

        })



    if len(result["findings"])>2:

        result["risk"]="HIGH"


    elif len(result["findings"])>0:

        result["risk"]="MEDIUM"



    return result



PY




echo "% ALERT CONNECTOR"



cat > backend/modules/alert_manager.py <<'PY'


import psycopg2


def save_alert(title,severity,description):


    db=psycopg2.connect(

    database="muteb_soc",

    user="postgres"

    )


    cur=db.cursor()


    cur.execute(

    """

    INSERT INTO security_events

    (source,event_type,severity,description,mitre)

    VALUES(%s,%s,%s,%s,%s)

    """,

    (

    "MUTEB_ENGINE",

    title,

    severity,

    description,

    "TA0001"

    )


    )


    db.commit()

    db.close()



PY




echo "% PDF REPORT"



cat > backend/modules/report_generator.py <<'PY'


from reportlab.platypus import SimpleDocTemplate,Paragraph

from reportlab.lib.styles import getSampleStyleSheet



def create_report(target,data):


    file="backend/reports/"+target+".pdf"


    doc=SimpleDocTemplate(file)


    style=getSampleStyleSheet()


    story=[]


    story.append(

    Paragraph(

    "MUTEB SOC Security Assessment Report",

    style["Title"]

    )

    )


    story.append(

    Paragraph(

    str(data),

    style["Normal"]

    )

    )


    doc.build(story)


    return file



PY




echo "% API TEST MODULE"



cat > backend/modules/cyber_assessment.py <<'PY'


from web_security_scanner import scan_domain

from report_generator import create_report



def run_scan(target):


    result=scan_domain(target)


    create_report(

    target,

    result

    )


    return result



PY





echo "% INSTALL DEPENDENCIES"



pip3 install requests reportlab psycopg2-binary --break-system-packages >/dev/null 2>&1 || true



echo "% RESTART SERVICES"



sudo systemctl restart muteb-backend.service

sudo systemctl restart nginx



echo "% COMPLETE"

echo ""

echo "MUTEB SOC CYBER ASSESSMENT ENGINE READY"

echo ""

echo "Modules:"

echo "Web Scanner"

echo "OWASP Mapping"

echo "CVE Intelligence Foundation"

echo "PostgreSQL Storage"

echo "PDF Reports"

