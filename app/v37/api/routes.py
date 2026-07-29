

from flask import Blueprint,jsonify


from app.v37.analytics.engine import SecurityAnalytics

from app.v37.kpi.engine import KPIEngine

from app.v37.executive.report import ExecutiveReport

from app.v37.predictive.model import PredictiveRisk



analytics_api=Blueprint(

"analytics",

__name__,

url_prefix="/api/v37"

)



analytics=SecurityAnalytics()

kpi=KPIEngine()

executive=ExecutiveReport()

predictive=PredictiveRisk()



@analytics_api.route("/analytics")
def analytics_view():

    return jsonify(analytics.analyze())


@analytics_api.route("/kpi")
def kpi_view():

    return jsonify(kpi.metrics())


@analytics_api.route("/executive")
def executive_view():

    return jsonify(executive.generate())


@analytics_api.route("/prediction")
def prediction_view():

    return jsonify(predictive.predict())


