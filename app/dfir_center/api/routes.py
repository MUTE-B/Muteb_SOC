

from flask import Blueprint,jsonify


from app.dfir_center.evidence.manager import EvidenceManager

from app.dfir_center.timeline.analyzer import TimelineAnalyzer

from app.dfir_center.investigation.engine import InvestigationEngine



dfir_api=Blueprint(

"dfir_center",

__name__,

url_prefix="/api/dfir"

)



evidence=EvidenceManager()

timeline=TimelineAnalyzer()

investigation=InvestigationEngine()



@dfir_api.route("/evidence")
def evidence_view():

    return jsonify(

    evidence.collect()

    )



@dfir_api.route("/timeline")
def timeline_view():

    return jsonify(

    timeline.build()

    )



@dfir_api.route("/investigation")
def investigation_view():

    return jsonify(

    investigation.investigate()

    )



