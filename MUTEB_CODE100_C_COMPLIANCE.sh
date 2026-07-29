#!/bin/bash


echo "======================================"
echo " MUTEB COMPLIANCE GOVERNANCE LAYER"
echo "======================================"


mkdir -p app/compliance/frameworks
mkdir -p app/compliance/evidence
mkdir -p app/compliance/api



####################################
# FRAMEWORK ENGINE
####################################


cat > app/compliance/frameworks/framework_engine.py <<'PY'


class ComplianceFramework:



    frameworks={


    "ISO27001":[

        "Access Control",

        "Risk Management",

        "Asset Management",

        "Incident Management"

    ],


    "NIST":[

        "Identify",

        "Protect",

        "Detect",

        "Respond",

        "Recover"

    ],


    "CIS":[

        "Inventory",

        "Secure Configuration",

        "Monitoring"

    ]


    }



    def list(self):


        return self.frameworks




    def mapping(self,framework):


        return self.frameworks.get(

        framework,

        []

        )



PY





####################################
# EVIDENCE STORE
####################################


cat > app/compliance/evidence/evidence_store.py <<'PY'


from datetime import datetime



class EvidenceStore:



    evidence=[]



    def add(self,title,category):


        item={


        "id":

        len(self.evidence)+1,


        "title":

        title,


        "category":

        category,


        "status":

        "AVAILABLE",


        "created":

        str(datetime.utcnow())


        }



        self.evidence.append(item)


        return item




    def list(self):


        return self.evidence



PY





####################################
# COMPLIANCE SCORE
####################################


cat > app/compliance/frameworks/score.py <<'PY'


class ComplianceScore:



    def calculate(self,total,completed):


        if total==0:

            return 0



        return round(

        (completed/total)*100

        )



PY





####################################
# COMPLIANCE API
####################################


cat > app/compliance/api/routes.py <<'PY'


from flask import Blueprint,jsonify,request


from app.compliance.frameworks.framework_engine import ComplianceFramework

from app.compliance.evidence.evidence_store import EvidenceStore



compliance_api=Blueprint(

"compliance",

__name__,

url_prefix="/api/compliance"

)



evidence=EvidenceStore()



@compliance_api.route("/frameworks")
def frameworks():


    return jsonify(

    ComplianceFramework().list()

    )





@compliance_api.route("/mapping/<name>")
def mapping(name):


    return jsonify(

    ComplianceFramework().mapping(name)

    )





@compliance_api.route("/evidence",methods=["POST"])
def add_evidence():


    data=request.json or {}


    return jsonify(

    evidence.add(

    data.get("title"),

    data.get("category")

    )

    )





@compliance_api.route("/evidence")
def evidence_list():


    return jsonify(

    evidence.list()

    )



PY





####################################
# REGISTER
####################################


cat > app/compliance/register.py <<'PY'


def register_compliance(app):


    from app.compliance.api.routes import compliance_api


    app.register_blueprint(

    compliance_api

    )


    print(

    "✓ COMPLIANCE GOVERNANCE ENABLED"

    )



PY




echo ""

echo "======================================"

echo " CODE 100-C COMPLETE"

echo "======================================"


