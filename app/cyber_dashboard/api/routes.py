

from flask import Blueprint,jsonify


from app.cyber_dashboard.data.dashboard import CyberDashboard

from app.cyber_dashboard.components.cards import DashboardCards



dashboard_api=Blueprint(

"cyber_dashboard",

__name__,

url_prefix="/api/dashboard"

)



dashboard=CyberDashboard()

cards=DashboardCards()



@dashboard_api.route("/overview")
def overview():


    return jsonify(

    dashboard.overview()

    )




@dashboard_api.route("/cards")
def cards_view():


    return jsonify(

    cards.generate()

    )



