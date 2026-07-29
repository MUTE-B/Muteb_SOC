

from flask import Blueprint,jsonify


from app.security_analytics.datalake.storage import SecurityDataLake

from app.security_analytics.analytics.engine import SecurityAnalytics

from app.security_analytics.intelligence.engine import SecurityIntelligence



analytics_api=Blueprint(

"security_analytics",

__name__,

url_prefix="/api/security-analytics"

)



lake=SecurityDataLake()

analytics=SecurityAnalytics()

intel=SecurityIntelligence()



@analytics_api.route("/datalake")
def datalake_view():

    return jsonify(

    lake.collect()

    )



@analytics_api.route("/analytics")
def analytics_view():

    return jsonify(

    analytics.analyze()

    )



@analytics_api.route("/intelligence")
def intelligence_view():

    return jsonify(

    intel.generate()

    )



