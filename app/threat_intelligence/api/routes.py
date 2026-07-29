

from flask import Blueprint,jsonify


from app.threat_intelligence.ioc.manager import IOCManager

from app.threat_intelligence.feeds.collector import ThreatFeeds

from app.threat_intelligence.scoring.engine import IntelligenceScoring



intel_api=Blueprint(

"threat_intelligence",

__name__,

url_prefix="/api/threat-intelligence"

)



ioc=IOCManager()

feeds=ThreatFeeds()

score=IntelligenceScoring()



@intel_api.route("/ioc")
def ioc_view():

    return jsonify(

    ioc.list()

    )



@intel_api.route("/feeds")
def feeds_view():

    return jsonify(

    feeds.collect()

    )



@intel_api.route("/score")
def score_view():

    return jsonify(

    score.calculate()

    )



