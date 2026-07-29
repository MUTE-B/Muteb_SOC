#!/bin/bash

set -e


echo "=============================================="
echo " MUTEB SOC WEB SECURITY ASSESSMENT ENGINE "
echo " Enterprise Cyber Scanner "
echo "=============================================="


PROJECT=$(pwd)

BACKEND="$PROJECT/backend"

FRONTEND="$PROJECT/frontend"

REPORT="$PROJECT/WEB_SCANNER_INSTALL_REPORT.txt"



echo "MUTEB WEB SECURITY ENGINE" > $REPORT

echo "DATE: $(date)" >> $REPORT



echo "% 10 BACKUP CURRENT SYSTEM"


mkdir -p enterprise_backup


cp backend/app.py \
enterprise_backup/app.py.$(date +%s)



cp -r frontend/src \
enterprise_backup/frontend.$(date +%s)



echo "% 20 CREATE SECURITY SCANNER ENGINE"


mkdir -p backend/security_scanner



touch backend/security_scanner/__init__.py



cat > backend/security_scanner/domain_engine.py <<'PY'

import socket


class DomainEngine:


    def analyze(self,domain):

        result={

            "domain":domain,
            "ip":None,
            "status":"unknown"

        }


        try:

            result["ip"] = socket.gethostbyname(domain)

            result["status"]="resolved"


        except Exception as e:

            result["error"]=str(e)


        return result

PY



cat > backend/security_scanner/dns_engine.py <<'PY'


import socket


class DNSEngine:


    def scan(self,domain):

        records=[]


        try:

            ip=socket.gethostbyname(domain)

            records.append({

            "type":"A",
            "value":ip

            })


        except:

            pass


        return records

PY



cat > backend/security_scanner/port_engine.py <<'PY'


import socket



class PortEngine:


    def scan(self,host):


        ports=[

        21,
        22,
        25,
        53,
        80,
        443,
        8080

        ]


        result=[]


        for port in ports:


            try:

                sock=socket.socket()

                sock.settimeout(1)


                status=sock.connect_ex(
                    (host,port)
                )


                if status==0:

                    result.append({

                    "port":port,
                    "status":"OPEN"

                    })


                sock.close()


            except:

                pass



        return result

PY



cat > backend/security_scanner/asset_engine.py <<'PY'


from .domain_engine import DomainEngine

from .dns_engine import DNSEngine

from .port_engine import PortEngine




class AssetEngine:



    def scan(self,domain):


        asset=DomainEngine().analyze(domain)


        dns=DNSEngine().scan(domain)


        ports=[]


        if asset.get("ip"):

            ports=PortEngine().scan(
                asset["ip"]
            )



        return {

        "target":domain,

        "asset":asset,

        "dns":dns,

        "ports":ports

        }

PY



echo "% 35 ASSET DISCOVERY ENGINE READY"




echo "% 40 WEB SECURITY ANALYSIS ENGINE"



cat > backend/security_scanner/header_engine.py <<'PY'


import requests



class HeaderEngine:


    def analyze(self,url):


        result={}


        try:

            r=requests.get(
                url,
                timeout=5
            )


            headers=r.headers


            security=[

            "Content-Security-Policy",
            "X-Frame-Options",
            "X-Content-Type-Options",
            "Strict-Transport-Security"

            ]


            missing=[]


            for h in security:

                if h not in headers:

                    missing.append(h)



            result={

            "server":
            headers.get("Server"),

            "missing_headers":
            missing,

            "status":
            r.status_code

            }


        except Exception as e:

            result["error"]=str(e)


        return result

PY





cat > backend/security_scanner/ssl_engine.py <<'PY'


import ssl

import socket



class SSLEngine:



    def check(self,domain):


        result={}


        try:


            ctx=ssl.create_default_context()


            with socket.create_connection(

                (domain,443),

                timeout=5

            ) as sock:


                with ctx.wrap_socket(

                    sock,
                    server_hostname=domain

                ) as s:


                    result={

                    "tls":
                    s.version(),

                    "cipher":
                    s.cipher()[0],

                    "status":
                    "secure"

                    }



        except Exception as e:

            result={

            "status":"failed",

            "error":str(e)

            }


        return result

PY





cat > backend/security_scanner/technology_engine.py <<'PY'


import requests



class TechnologyEngine:



    def detect(self,url):


        try:

            r=requests.get(

            url,

            timeout=5

            )


            server=r.headers.get(
                "Server",
                "Unknown"
            )


            return {


            "server":server,


            "technologies":[

            "HTTP",

            "Web Server"

            ]


            }


        except:


            return {


            "server":"Unknown",

            "technologies":[]

            }

PY





cat > backend/security_scanner/risk_engine.py <<'PY'


class RiskEngine:



    def calculate(self,data):


        score=0


        findings=[]



        headers=data.get(
            "headers",
            {}
        )


        if headers.get(
            "missing_headers"
        ):

            score+=30

            findings.append({

            "issue":
            "Missing Security Headers",

            "severity":
            "MEDIUM"

            })



        ssl=data.get(
            "ssl",
            {}
        )


        if ssl.get(
            "status"
        )!="secure":

            score+=40

            findings.append({

            "issue":
            "SSL/TLS Problem",

            "severity":
            "HIGH"

            })



        if score>=70:

            level="HIGH"

        elif score>=40:

            level="MEDIUM"

        else:

            level="LOW"



        return {


        "risk_score":score,

        "risk_level":level,

        "findings":findings


        }

PY





cat > backend/security_scanner/report_engine.py <<'PY'


from datetime import datetime



class ReportEngine:



    def create(self,target,result):


        return {


        "platform":
        "MUTEB SOC",

        "target":
        target,

        "generated":
        str(datetime.now()),

        "report":
        result


        }

PY




echo "% 70 SECURITY INTELLIGENCE READY"




echo "% 80 CONNECT BACKEND API"



cat >> backend/app.py <<'PY'


# =========================================
# MUTEB SOC WEB SECURITY ASSESSMENT API
# =========================================


from security_scanner.asset_engine import AssetEngine
from security_scanner.header_engine import HeaderEngine
from security_scanner.ssl_engine import SSLEngine
from security_scanner.technology_engine import TechnologyEngine
from security_scanner.risk_engine import RiskEngine
from security_scanner.report_engine import ReportEngine



scanner_asset = AssetEngine()

scanner_header = HeaderEngine()

scanner_ssl = SSLEngine()

scanner_tech = TechnologyEngine()

scanner_risk = RiskEngine()

scanner_report = ReportEngine()



@app.route(
"/api/scanner/start",
methods=["POST"]
)
def web_scanner_start():


    data=request.json or {}

    domain=data.get(
        "domain",
        ""
    )


    url="https://"+domain



    asset=scanner_asset.scan(
        domain
    )


    headers=scanner_header.analyze(
        url
    )


    ssl=scanner_ssl.check(
        domain
    )


    tech=scanner_tech.detect(
        url
    )


    risk=scanner_risk.calculate({

        "headers":headers,

        "ssl":ssl

    })



    result={


    "asset":asset,

    "headers":headers,

    "ssl":ssl,

    "technology":tech,

    "risk":risk


    }



    return jsonify(

        scanner_report.create(

        domain,

        result

        )

    )





@app.route(
"/api/scanner/status"
)
def scanner_status():


    return jsonify({

    "engine":
    "MUTEB WEB SECURITY ASSESSMENT",

    "status":
    "ONLINE",

    "modules":[

    "Asset Discovery",

    "Port Scanner",

    "SSL Analyzer",

    "Risk Engine",

    "Report Engine"

    ]

    })


PY




echo "% 85 CREATE SOC SCANNER PAGE"



mkdir -p frontend/src/scanner



cat > frontend/src/scanner/WebScanner.jsx <<'JS'


import React,{useState} from "react";

import axios from "axios";

import "../enterprise.css";



export default function WebScanner(){


const [domain,setDomain]=useState("");

const [result,setResult]=useState(null);



async function scan(){


const res=await axios.post(

"/api/scanner/start",

{

domain

}

);


setResult(res.data);


}



return (

<div style={{padding:"30px"}}>


<h1>
MUTEB Web Security Scanner
</h1>


<div className="enterprise-card">


<input

style={{

padding:"12px",

width:"70%"

}}

placeholder="example.com"

value={domain}

onChange={
e=>setDomain(e.target.value)
}

/>



<button

className="cyber-button"

onClick={scan}

>

START SCAN

</button>



</div>



{

result &&

<div className="enterprise-card">


<h2>
Target:
{result.target}

</h2>



<h3>

Risk:

{result.report.risk.risk_level}

</h3>



<h3>
Findings
</h3>


{

result.report.risk.findings.map(

(f,i)=>(

<p key={i}>

{f.issue}

 -

{f.severity}

</p>

)

)

}



</div>


}


</div>


)

}

JS




echo "% 92 INSTALL DEPENDENCIES"



cd backend


./venv/bin/pip install requests



cd ..



echo "% 95 BUILD FRONTEND"



cd frontend


npm run build


cd ..



echo "% 97 RESTART SERVICES"



sudo systemctl daemon-reload


sudo systemctl restart muteb-backend.service


sudo systemctl restart muteb-frontend.service


sudo systemctl restart nginx



echo "% 99 TEST"



curl -s http://127.0.0.1:8000/api/scanner/status



echo


echo "=========================================="
echo " MUTEB WEB SECURITY ENGINE COMPLETE "
echo "=========================================="

echo "

READY:

SOC Platform
+
Web Security Assessment

"

