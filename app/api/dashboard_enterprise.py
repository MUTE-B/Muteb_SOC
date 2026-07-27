

from flask import Blueprint,jsonify


from app.auth.decorators import permission_required


from app.dashboard.metrics import metrics



dashboard_enterprise=Blueprint(

    "dashboard_enterprise",

    __name__

)



@dashboard_enterprise.route(
"/summary",
methods=["GET"]
)

@permission_required("dashboard")

def summary():


    return jsonify(

        metrics.summary()

    )




@dashboard_enterprise.route(
"/health",
methods=["GET"]
)

def health():


    return jsonify(

        metrics.health()

    )

