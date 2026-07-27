
#!/bin/bash


echo "====================================="
echo " MUTEB SOC PACKAGE 10"
echo " THREAT INTELLIGENCE ENGINE"
echo "====================================="



mkdir -p app/threat_intel



# ===================================
# IOC Database
# ===================================


cat > app/threat_intel/ioc_database.json <<'JSON'

{

"malicious_ips":[

"185.220.101.1",
"45.155.205.233"

],


"malicious_domains":[

"evil-example.com",
"malware-test.local"

],


"malware_hashes":[

"d41d8cd98f00b204e9800998ecf8427e"

]

}

JSON





# ===================================
# IOC Engine
# ===================================


cat > app/threat_intel/ioc_engine.py <<'PY'


import json
import os



class IOCEngine:



    def __init__(self):


        path=os.path.join(

            os.path.dirname(__file__),

            "ioc_database.json"

        )


        with open(path) as f:

            self.database=json.load(f)





    def search(self,text):


        result={

            "matched":False,

            "type":None,

            "indicator":None,

            "score":0

        }



        for ip in self.database["malicious_ips"]:


            if ip in text:


                result.update({

                    "matched":True,

                    "type":"IP",

                    "indicator":ip,

                    "score":80

                })

                return result





        for domain in self.database["malicious_domains"]:


            if domain in text:


                result.update({

                    "matched":True,

                    "type":"DOMAIN",

                    "indicator":domain,

                    "score":70

                })

                return result






        for h in self.database["malware_hashes"]:


            if h in text:


                result.update({

                    "matched":True,

                    "type":"HASH",

                    "indicator":h,

                    "score":90

                })

                return result



        return result




ioc_engine=IOCEngine()

PY






# ===================================
# Threat Intelligence API
# ===================================


cat > app/api/threat_intel.py <<'PY'


from flask import Blueprint,request,jsonify


from app.auth.decorators import permission_required


from app.threat_intel.ioc_engine import ioc_engine




threat_intel=Blueprint(

    "threat_intel",

    __name__

)




@threat_intel.route(

"/lookup",

methods=["POST"]

)


@permission_required("detection")

def lookup():


    data=request.json


    result=ioc_engine.search(

        data["value"]

    )


    return jsonify(result)



PY





# ===================================
# Register Blueprint
# ===================================


python3 - <<'PY'


path="app/core/application.py"


with open(path) as f:

    data=f.read()



if "from app.api.threat_intel import threat_intel" not in data:


    data=data.replace(

        "from app.api.detection_pipeline import detection_pipeline",

        "from app.api.detection_pipeline import detection_pipeline\nfrom app.api.threat_intel import threat_intel"

    )




if 'url_prefix="/api/threat-intel"' not in data:


    data=data.replace(

        "app.register_blueprint(\n        detection_pipeline,",

        "app.register_blueprint(\n        threat_intel,\n        url_prefix=\"/api/threat-intel\"\n    )\n\n\n    app.register_blueprint(\n        detection_pipeline,"

    )



with open(path,"w") as f:

    f.write(data)



PY




python3 -m compileall app



echo "====================================="
echo " PACKAGE 10 READY"
echo " IOC ENGINE ONLINE"
echo "====================================="


