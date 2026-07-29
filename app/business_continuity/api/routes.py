

from flask import Blueprint,jsonify,request


from app.business_continuity.backup.manager import BackupManager

from app.business_continuity.recovery.engine import RecoveryEngine

from app.business_continuity.disaster_recovery.plan import DisasterRecoveryPlan

from app.business_continuity.testing.test import RecoveryTesting



bc_api=Blueprint(

"business_continuity",

__name__,

url_prefix="/api/continuity"

)



backup=BackupManager()

recovery=RecoveryEngine()

dr=DisasterRecoveryPlan()

testing=RecoveryTesting()



@bc_api.route("/backup",methods=["POST"])
def create_backup():


    data=request.json or {}


    return jsonify(

    backup.create(

    data.get("system")

    )

    )





@bc_api.route("/backups")
def backups():


    return jsonify(

    backup.list()

    )





@bc_api.route("/restore/<system>")
def restore(system):


    return jsonify(

    recovery.restore(system)

    )





@bc_api.route("/dr")
def disaster_recovery():


    return jsonify(

    dr.status()

    )





@bc_api.route("/test")
def recovery_test():


    return jsonify(

    testing.execute()

    )



