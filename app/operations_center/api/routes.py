

from flask import Blueprint,jsonify


from app.operations_center.health.check import HealthCheck

from app.operations_center.deployment.manager import DeploymentManager

from app.operations_center.backup.system import BackupSystem



ops_api=Blueprint(

"operations_center",

__name__,

url_prefix="/api/operations"

)



health=HealthCheck()

deploy=DeploymentManager()

backup=BackupSystem()



@ops_api.route("/health")
def health():

    return jsonify(

    health.check()

    )



@ops_api.route("/deployment")
def deployment():

    return jsonify(

    deploy.status()

    )



@ops_api.route("/backup")
def backup_status():

    return jsonify(

    backup.execute()

    )



