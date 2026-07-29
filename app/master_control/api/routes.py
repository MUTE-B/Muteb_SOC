

from flask import Blueprint,jsonify


from app.master_control.status.system import MasterStatus

from app.master_control.control.engine import ControlEngine



master_api=Blueprint(

"master_control",

__name__,

url_prefix="/api/master"

)



status=MasterStatus()

control=ControlEngine()



@master_api.route("/status")
def system_status():


    return jsonify(

    status.overview()

    )



@master_api.route("/execute/<command>")
def execute(command):


    return jsonify(

    control.execute(command)

    )


