

from flask import Blueprint,jsonify,request


from app.threat_intelligence_fusion.ioc.manager import IOCManager

from app.threat_intelligence_fusion.feeds.collector import ThreatFeedCollector

from app.threat_intelligence_fusion.scoring.engine import ThreatScoring

from app.threat_intelligence_fusion.intelligence.analyzer import IntelligenceAnalyzer



ti_api=Blueprint(

"threat_intelligence_fusion",

__name__,

url_prefix="/api/threat-intelligence"

)



ioc=IOCManager()

feeds=ThreatFeedCollector()

score=ThreatScoring()

intel=IntelligenceAnalyzer()



@ti_api.route("/ioc",methods=["POST"])
def add_ioc():


    data=request.json or {}


    return jsonify(

    ioc.add(

    data.get("value"),

    data.get("type")

    )

    )





@ti_api.route("/ioc")
def list_ioc():


    return jsonify(

    ioc.list()

    )





@ti_api.route("/feeds")
def threat_feeds():


    return jsonify(

    feeds.collect()

    )





@ti_api.route("/score/<indicator>")
def threat_score(indicator):


    return jsonify(

    score.calculate(

    indicator

    )

    )





@ti_api.route("/dashboard")
def intelligence_dashboard():


    return jsonify(

    intel.analyze()

    )



