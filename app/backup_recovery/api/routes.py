

from flask import Blueprint,jsonify


from app.backup_recovery.backup.engine import BackupEngine

from app.backup_recovery.recovery.engine import RecoveryEngine

from app.backup_recovery.dr.manager import DisasterRecovery



backup_api=Blueprint(

"backup_recovery",

__name__,

url_prefix="/api/backup"

)



backup=BackupEngine()

restore=RecoveryEngine()

dr=DisasterRecovery()



@backup_api.route("/create")
def create():

    return jsonify(

    backup.create_backup()

    )



@backup_api.route("/restore")
def recovery():

    return jsonify(

    restore.restore()

    )



@backup_api.route("/dr")
def disaster():

    return jsonify(

    dr.status()

    )



