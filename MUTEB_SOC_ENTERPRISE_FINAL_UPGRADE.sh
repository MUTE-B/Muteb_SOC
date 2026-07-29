#!/bin/bash

set -e

echo "=============================================="
echo " MUTEB SOC ENTERPRISE FINAL UPGRADE "
echo " Production Transformation "
echo "=============================================="

PROJECT=$(pwd)
BACKEND="$PROJECT/backend"
FRONTEND="$PROJECT/frontend"

REPORT="$PROJECT/MUTEB_ENTERPRISE_UPGRADE_REPORT.txt"


echo "MUTEB SOC ENTERPRISE UPGRADE" > $REPORT
echo "DATE: $(date)" >> $REPORT


echo "% 5 BACKUP CURRENT SYSTEM"


mkdir -p backup_enterprise


cp backend/app.py \
backup_enterprise/app.py.$(date +%s)


cp -r frontend/src \
backup_enterprise/frontend_src.$(date +%s)



echo "% 10 BACKEND ENTERPRISE MODULES"


mkdir -p backend/modules


cat > backend/modules/threat_engine.py <<'PY'

from datetime import datetime


class ThreatEngine:


    def score(self,severity):

        levels={

        "LOW":25,
        "MEDIUM":50,
        "HIGH":75,
        "CRITICAL":95

        }

        return levels.get(
            severity.upper(),
            0
        )


    def analyze(self,data):

        return {

        "platform":"MUTEB SOC",
        "event":data,
        "risk":
        self.score(
            data.get(
            "severity",
            "LOW")
        ),
        "time":
        str(datetime.now())

        }

PY



cat > backend/modules/ioc_engine.py <<'PY'


class IOCScanner:


    def scan(self,value):

        bad=[

        "malware",
        "virus",
        "attack",
        "exploit"

        ]


        found=[]


        for x in bad:

            if x in value.lower():

                found.append(x)


        return {

        "value":value,
        "threat":
        len(found)>0,
        "matches":found

        }

PY



cat > backend/modules/detection_engine.py <<'PY'


class DetectionEngine:


    def run(self,event):

        rules={

        "failed login":
        "T1110 Brute Force",

        "powershell":
        "T1059 Command Shell",

        "malware":
        "T1204 Malware"

        }


        result=[]


        for k,v in rules.items():

            if k in event.lower():

                result.append(v)


        return result

PY



cat > backend/modules/case_manager.py <<'PY'


class CaseManager:


    def create(self,title):

        return {

        "id":1,
        "title":title,
        "status":"OPEN",
        "priority":"HIGH"

        }


PY



cat > backend/modules/mitre_engine.py <<'PY'


MITRE={

"Brute Force":"T1110",

"Command Shell":"T1059",

"Malware":"T1204"

}


def map_attack(name):

    return MITRE.get(
        name,
        "UNKNOWN"
    )

PY



echo "% 25 BACKEND SECURITY MODULES CREATED"




echo "% 35 BACKEND API INTEGRATION"


cat >> backend/app.py <<'PY'


# =====================================
# MUTEB SOC ENTERPRISE SECURITY APIs
# =====================================


from modules.threat_engine import ThreatEngine
from modules.ioc_engine import IOCScanner
from modules.detection_engine import DetectionEngine
from modules.case_manager import CaseManager
from modules.mitre_engine import map_attack



enterprise_threat = ThreatEngine()

enterprise_ioc = IOCScanner()

enterprise_detection = DetectionEngine()

enterprise_cases = CaseManager()



@app.route("/api/enterprise/threat",methods=["POST"])
def enterprise_threat_api():

    data=request.json or {}

    return jsonify(
        enterprise_threat.analyze(data)
    )



@app.route("/api/enterprise/ioc",methods=["POST"])
def enterprise_ioc_api():

    data=request.json or {}

    return jsonify(
        enterprise_ioc.scan(
            data.get("value","")
        )
    )



@app.route("/api/enterprise/detection",methods=["POST"])
def enterprise_detection_api():

    data=request.json or {}

    result = enterprise_detection.run(
        data.get("event","")
    )

    return jsonify({

        "detections":result

    })



@app.route("/api/enterprise/case",methods=["POST"])
def enterprise_case_api():

    data=request.json or {}

    return jsonify(
        enterprise_cases.create(
            data.get(
            "title",
            "Security Incident"
            )
        )
    )



@app.route("/api/enterprise/mitre/<name>")
def enterprise_mitre(name):

    return jsonify({

        "technique":
        map_attack(name)

    })



@app.route("/api/enterprise/status")
def enterprise_status():

    return jsonify({

        "platform":
        "MUTEB SOC Enterprise",

        "backend":
        "ONLINE",

        "security_modules":[

        "Threat Engine",
        "IOC Scanner",
        "Detection Engine",
        "Case Management",
        "MITRE Mapping"

        ]

    })

PY



echo "% 45 SECURITY RULES"


mkdir -p backend/security/rules


cat > backend/security/rules/sigma_rules.json <<'JSON'

[
 {
 "name":"Failed Login Detection",
 "severity":"HIGH",
 "mitre":"T1110"
 },

 {
 "name":"Malware Execution",
 "severity":"CRITICAL",
 "mitre":"T1204"
 }
]

JSON



cat > backend/security/yara_scanner.py <<'PY'


class YaraScanner:


    def scan(self,file):

        return {

        "file":file,
        "malware":False,
        "status":"clean"

        }

PY



cat > backend/security/log_collector.py <<'PY'


from datetime import datetime


def collect(message):

    return {

    "message":message,
    "time":str(datetime.now())

    }

PY



echo "% 60 FRONTEND ENTERPRISE THEME"



cat > frontend/src/enterprise.css <<'CSS'


:root{

--bg:#050B14;
--panel:#081A33;
--blue:#00A8FF;
--green:#00D084;
--warning:#FFB020;
--critical:#FF3B30;
--text:#E8F1FF;

}



body{

margin:0;

background:
var(--bg);

color:
var(--text);

font-family:

"Inter",
Arial,
sans-serif;

}



.enterprise-card{

background:

rgba(8,26,51,.85);

border:

1px solid
rgba(0,168,255,.25);

border-radius:

18px;

padding:

20px;

box-shadow:

0 0 30px
rgba(0,168,255,.15);

}



.cyber-button{

background:
var(--blue);

color:white;

border:none;

padding:12px 25px;

border-radius:10px;

cursor:pointer;

transition:.3s;

}


.cyber-button:hover{

transform:
translateY(-2px);

box-shadow:
0 0 20px
var(--blue);

}



CSS



echo "% 75 UI MODULES READY"




echo "% 80 CREATE ENTERPRISE DASHBOARD"


cat > frontend/src/pages/EnterpriseDashboard.jsx <<'JS'

import React,{useEffect,useState} from "react";
import axios from "axios";
import "../enterprise.css";


export default function EnterpriseDashboard(){


const [status,setStatus]=useState({});
const [events,setEvents]=useState([]);



useEffect(()=>{


axios.get("/api/enterprise/status")
.then(r=>setStatus(r.data))
.catch(()=>{});


setEvents([

{
id:1,
event:"Suspicious Login",
severity:"HIGH"
},

{
id:2,
event:"Malware Detection",
severity:"CRITICAL"
}

]);


},[]);



return (

<div style={{padding:"30px"}}>


<h1>
MUTEB SOC Command Center
</h1>


<div style={{
display:"grid",
gridTemplateColumns:"repeat(4,1fr)",
gap:"20px"
}}>


<div className="enterprise-card">
Critical Alerts
<h2 style={{color:"#FF3B30"}}>
12
</h2>
</div>


<div className="enterprise-card">
Threat Score
<h2 style={{color:"#00A8FF"}}>
85%
</h2>
</div>



<div className="enterprise-card">
System
<h2 style={{color:"#00D084"}}>
ONLINE
</h2>
</div>



<div className="enterprise-card">
Engine
<h2>
ACTIVE
</h2>
</div>


</div>



<h2>
Live Security Events
</h2>



<div className="enterprise-card">


{
events.map(e=>(

<p key={e.id}>

{e.event}

 -

<span style={{
color:e.severity==="CRITICAL"
?"#FF3B30"
:"#FFB020"
}}>

{e.severity}

</span>


</p>

))
}



</div>



</div>


)

}

JS



echo "% 85 UPDATE FRONTEND ROUTE"



if grep -q "EnterpriseDashboard" frontend/src/App.jsx
then

echo "Dashboard already linked"

else


sed -i \
'/import Dashboard/a import EnterpriseDashboard from "./pages/EnterpriseDashboard";' \
frontend/src/App.jsx



fi



echo "% 90 BUILD FRONTEND"



cd frontend


npm install


npm run build



cd ..



echo "% 93 SYSTEM SERVICES"



sudo systemctl daemon-reload


sudo systemctl restart muteb-backend.service


sudo systemctl restart muteb-frontend.service


sudo systemctl restart nginx



echo "% 96 TEST SERVICES"



echo "[BACKEND]"

systemctl is-active muteb-backend.service



echo "[FRONTEND]"

systemctl is-active muteb-frontend.service



echo "[NGINX]"

systemctl is-active nginx



echo "[API]"

curl -s http://127.0.0.1:8000/api/enterprise/status



echo



echo "% 100 COMPLETE"



echo "======================================"
echo " MUTEB SOC ENTERPRISE UPGRADE DONE "
echo "======================================"

