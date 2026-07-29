

from flask import Blueprint,jsonify


from app.cyber_command_center.dashboard.engine import CommandCenter

from app.cyber_command_center.widgets.widgets import SecurityWidgets



command_api=Blueprint(

"command_center",

__name__,

url_prefix="/api/command-center"

)



center=CommandCenter()

widgets=SecurityWidgets()



@command_api.route("/overview")
def overview():


    return jsonify(

    center.overview()

    )





@command_api.route("/widgets")
def widget_data():


    return jsonify(

    widgets.cards()

    )



