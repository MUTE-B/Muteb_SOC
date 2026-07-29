

from flask import Blueprint,jsonify


from app.soc_command_center.core.dashboard import SOCCommandCenter



soc_dashboard=Blueprint(

"soc_dashboard",

__name__,

url_prefix="/api/soc-center"

)



center=SOCCommandCenter()



@soc_dashboard.route("/overview")
def overview():


    return jsonify(

    center.overview()

    )



