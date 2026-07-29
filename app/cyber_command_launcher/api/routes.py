

from flask import Blueprint,jsonify


from app.cyber_command_launcher.core.registry import EnterpriseRegistry

from app.cyber_command_launcher.health.check import FinalHealthCheck

from app.cyber_command_launcher.dashboard.view import CommandDashboard



command_api=Blueprint(

"cyber_command",

__name__,

url_prefix="/api/command"

)



registry=EnterpriseRegistry()

health=FinalHealthCheck()

dashboard=CommandDashboard()



@command_api.route("/status")
def status():


    return jsonify(

    registry.status()

    )





@command_api.route("/health")
def health_status():


    return jsonify(

    health.run()

    )





@command_api.route("/dashboard")
def command_dashboard():


    return jsonify(

    dashboard.display()

    )



