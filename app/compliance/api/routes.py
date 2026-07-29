

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



