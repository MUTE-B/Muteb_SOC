

from flask import Blueprint,jsonify


from app.health_monitoring.checks.system import SystemHealth

from app.health_monitoring.checks.modules import ModuleHealth



health_api=Blueprint(

"health_monitoring",

__name__,

url_prefix="/api/health"

)



system=SystemHealth()

modules=ModuleHealth()



@health_api.route("/system")
def system_check():

    return jsonify(

    system.check()

    )



@health_api.route("/modules")
def module_check():

    return jsonify(

    modules.scan()

    )


