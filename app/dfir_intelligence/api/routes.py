

from flask import Blueprint,jsonify


from app.dfir_intelligence.cases.manager import CaseManager

from app.dfir_intelligence.evidence.manager import EvidenceManager

from app.dfir_intelligence.investigation.engine import InvestigationEngine



dfir_api=Blueprint(

"dfir_intelligence",

__name__,

url_prefix="/api/dfir"

)



cases=CaseManager()

evidence=EvidenceManager()

investigation=InvestigationEngine()



@dfir_api.route("/case")
def create_case():

    return jsonify(

    cases.create_case(

    "Security Incident Investigation"

    )

    )



@dfir_api.route("/evidence")
def evidence_item():

    return jsonify(

    evidence.register(

    "Digital Artifact"

    )

    )



@dfir_api.route("/analyze")
def investigation_report():

    return jsonify(

    investigation.analyze()

    )



