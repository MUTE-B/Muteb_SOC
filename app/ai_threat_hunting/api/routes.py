

from flask import Blueprint,jsonify


from app.ai_threat_hunting.hunting.engine import ThreatHuntingEngine

from app.ai_threat_hunting.behavior.analyzer import BehaviorAnalyzer

from app.ai_threat_hunting.investigator.assistant import AIInvestigator



hunting_api=Blueprint(

"ai_threat_hunting",

__name__,

url_prefix="/api/threat-hunting"

)



hunt=ThreatHuntingEngine()

behavior=BehaviorAnalyzer()

assistant=AIInvestigator()



@hunting_api.route("/search")
def search():

    return jsonify(

    hunt.search(

    "Suspicious Activity"

    )

    )



@hunting_api.route("/behavior")
def behavior_analysis():

    return jsonify(

    behavior.analyze()

    )



@hunting_api.route("/assistant")
def investigator():

    return jsonify(

    assistant.assist(

    "Security Incident"

    )

    )



