

from flask import Blueprint,jsonify


from app.risk_intelligence.scoring.engine import RiskScoringEngine

from app.risk_intelligence.business.impact import BusinessImpact

from app.risk_intelligence.dashboard.manager import RiskDashboard



risk_api=Blueprint(

"risk_intelligence",

__name__,

url_prefix="/api/risk-intelligence"

)



score=RiskScoringEngine()

business=BusinessImpact()

dashboard=RiskDashboard()



@risk_api.route("/score")
def score_view():

    return jsonify(

    score.calculate()

    )



@risk_api.route("/business")
def business_view():

    return jsonify(

    business.analyze()

    )



@risk_api.route("/dashboard")
def dashboard_view():

    return jsonify(

    dashboard.status()

    )



