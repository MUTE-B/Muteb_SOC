
#!/bin/bash


echo "===================================="
echo " MUTEB SOC PACKAGE 6 DEPLOYMENT"
echo " Threat Intelligence Engine"
echo "===================================="


mkdir -p app/threat_intel
mkdir -p app/services
mkdir -p app/api
mkdir -p threat_data



# ===============================
# IOC Database
# ===============================

cat > threat_data/ioc_database.json <<'JSON'
{
    "malicious_ips":[
        "10.10.10.10",
        "192.168.100.50"
    ],

    "malicious_domains":[
        "evil-domain.com",
        "malware-test.local"
    ],

    "malware_hashes":[
        "44d88612fea8a8f36de82e1278abb02f"
    ]
}
JSON



# ===============================
# IOC Intelligence Engine
# ===============================


cat > app/threat_intel/ioc_engine.py <<'PY'

import json



class IOCIntel:


    def __init__(self):

        with open(
            "threat_data/ioc_database.json"
        ) as f:

            self.database=json.load(f)



    def check_ip(
        self,
        ip
    ):


        if ip in self.database["malicious_ips"]:

            return {

                "malicious":True,

                "type":"IP",

                "score":90

            }


        return {

            "malicious":False,

            "score":0

        }




    def check_domain(
        self,
        domain
    ):


        if domain in self.database["malicious_domains"]:

            return {

                "malicious":True,

                "type":"DOMAIN",

                "score":85

            }


        return {

            "malicious":False,

            "score":0

        }



ioc_intel=IOCIntel()

PY



# ===============================
# MITRE Mapping Engine
# ===============================


cat > app/services/mitre_engine.py <<'PY'


MITRE_MAP={


"powershell":

{

"technique":"T1059.001",

"name":"PowerShell"

},


"failed login":

{

"technique":"T1110",

"name":"Brute Force"

},


"reverse_shell":

{

"technique":"T1059",

"name":"Command Shell"

}



}



class MITREEngine:



    def map_event(
        self,
        event
    ):


        results=[]


        for key,value in MITRE_MAP.items():


            if key.lower() in event.lower():

                results.append(value)



        return results




mitre_engine=MITREEngine()

PY




# ===============================
# Threat Scoring
# ===============================


cat > app/services/threat_score.py <<'PY'


class ThreatScore:



    def calculate(

        self,

        ioc_score,

        mitre_count

    ):


        score=ioc_score


        score += mitre_count * 20


        if score > 100:

            score=100



        return score




threat_score=ThreatScore()

PY




# ===============================
# Threat API
# ===============================


cat > app/api/threat.py <<'PY'


from flask import Blueprint,request,jsonify


from app.auth.decorators import permission_required


from app.threat_intel.ioc_engine import ioc_intel


from app.services.mitre_engine import mitre_engine


from app.services.threat_score import threat_score



threat=Blueprint(

    "threat",

    __name__

)



@threat.route(
"/analyze",
methods=["POST"]
)

@permission_required("detection")

def analyze():


    data=request.json


    event=data.get(
        "event",
        ""
    )


    ip=data.get(
        "ip"
    )


    intel={}



    if ip:

        intel=ioc_intel.check_ip(
            ip
        )



    mitre=mitre_engine.map_event(
        event
    )



    score=threat_score.calculate(

        intel.get(
            "score",
            0
        ),

        len(mitre)

    )



    return jsonify({

        "threat_score":score,

        "ioc":intel,

        "mitre":mitre

    })

PY




# ===============================
# Register API
# ===============================


python3 - <<'PY'


path="app/core/application.py"


with open(path) as f:
    data=f.read()



if "from app.api.threat import threat" not in data:


    data=data.replace(

        "from app.api.incidents import incident",

        "from app.api.incidents import incident\nfrom app.api.threat import threat"

    )



if 'url_prefix="/api/threat"' not in data:


    data=data.replace(

        "app.register_blueprint(\n        incident,",

        "app.register_blueprint(\n        threat,\n        url_prefix=\"/api/threat\"\n    )\n\n\n    app.register_blueprint(\n        incident,"

    )



with open(path,"w") as f:
    f.write(data)


PY



echo "Checking package..."

python3 -m compileall app



echo "===================================="
echo " PACKAGE 6 READY"
echo " Threat Intelligence Enabled"
echo "===================================="

