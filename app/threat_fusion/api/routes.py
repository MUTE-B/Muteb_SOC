

from flask import Blueprint,jsonify,request


from app.threat_fusion.ioc.manager import IOCManager

from app.threat_fusion.scoring.engine import ThreatScore

from app.threat_fusion.analysis.engine import IntelligenceAnalyzer

from app.threat_fusion.reports.report import IntelligenceReport



intel_api=Blueprint(

"threat_fusion",

__name__,

url_prefix="/api/threat-fusion"

)



ioc=IOCManager()

score=ThreatScore()

analysis=IntelligenceAnalyzer()

report=IntelligenceReport()



@intel_api.route("/ioc",methods=["POST"])
def add_ioc():


    data=request.json or {}


    return jsonify(

    ioc.add(

    data.get("type"),

    data.get("value")

    )

    )





@intel_api.route("/ioc")
def list_ioc():


    return jsonify(

    ioc.list()

    )





@intel_api.route("/score/<indicator>")
def score_indicator(indicator):


    return jsonify(

    score.calculate(

    indicator

    )

    )





@intel_api.route("/analysis")
def intel_analysis():


    return jsonify(

    analysis.analyze()

    )





@intel_api.route("/report")
def intel_report():


    return jsonify(

    report.generate()

    )



