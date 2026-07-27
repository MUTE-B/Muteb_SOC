

from flask import Blueprint,jsonify

from flask_jwt_extended import jwt_required


from app.dashboard.metrics import metrics



soc_dashboard = Blueprint(

    "soc_dashboard",

    __name__

)



@soc_dashboard.route(
    "/overview",
    methods=["GET"]
)

@jwt_required()

def overview():


    return jsonify({

        "dashboard":
        "SOC Analyst Dashboard",

        "metrics":
        metrics.summary()

    })

