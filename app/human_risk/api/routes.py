

from flask import Blueprint,jsonify


from app.human_risk.users.analyzer import UserRiskAnalyzer

from app.human_risk.training.manager import AwarenessTraining

from app.human_risk.phishing.simulator import PhishingSimulator



human_api=Blueprint(

"human_risk",

__name__,

url_prefix="/api/human-risk"

)



users=UserRiskAnalyzer()

training=AwarenessTraining()

phishing=PhishingSimulator()



@human_api.route("/users")
def users_view():

    return jsonify(

    users.analyze()

    )



@human_api.route("/training")
def training_view():

    return jsonify(

    training.status()

    )



@human_api.route("/phishing")
def phishing_view():

    return jsonify(

    phishing.run()

    )



