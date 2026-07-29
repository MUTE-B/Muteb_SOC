

from flask import Blueprint,jsonify


from app.disaster_recovery.backup.manager import BackupManager

from app.disaster_recovery.recovery.engine import RecoveryEngine

from app.disaster_recovery.business_continuity.plan import BusinessContinuity



dr_api=Blueprint(

"disaster_recovery",

__name__,

url_prefix="/api/disaster-recovery"

)



backup=BackupManager()

recovery=RecoveryEngine()

continuity=BusinessContinuity()



@dr_api.route("/backup")
def backup_status():

    return jsonify(

    backup.status()

    )



@dr_api.route("/recovery")
def recovery_status():

    return jsonify(

    recovery.plan()

    )



@dr_api.route("/continuity")
def continuity_status():

    return jsonify(

    continuity.check()

    )


