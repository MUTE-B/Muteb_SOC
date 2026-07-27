

from flask import Blueprint,jsonify


from app.dashboard.enterprise import enterprise_dashboard



enterprise_dashboard_api=Blueprint(

    "enterprise_dashboard",

    __name__

)



@enterprise_dashboard_api.route(

"/enterprise/summary",

methods=["GET"]

)

def summary():


    return jsonify(

        enterprise_dashboard.summary()

    )




@enterprise_dashboard_api.route(

"/enterprise/health",

methods=["GET"]

)

def health():


    return jsonify(

        enterprise_dashboard.health()

    )



