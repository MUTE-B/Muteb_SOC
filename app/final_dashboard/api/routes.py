

from flask import Blueprint,jsonify


from app.final_dashboard.core.dashboard import CommandDashboard

from app.final_dashboard.widgets.security import SecurityWidgets

from app.final_dashboard.widgets.executive import ExecutiveView



dashboard_api=Blueprint(

"final_dashboard",

__name__,

url_prefix="/api/dashboard"

)



dashboard=CommandDashboard()

security=SecurityWidgets()

executive=ExecutiveView()



@dashboard_api.route("/overview")
def overview():

    return jsonify(

    dashboard.overview()

    )



@dashboard_api.route("/security")
def security_view():

    return jsonify(

    security.metrics()

    )



@dashboard_api.route("/executive")
def executive_view():

    return jsonify(

    executive.report()

    )



