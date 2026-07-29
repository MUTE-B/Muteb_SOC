

def register_backup_recovery(app):


    from app.backup_recovery.api.routes import backup_api


    app.register_blueprint(backup_api)


    print(

    "✓ BACKUP RECOVERY ENABLED"

    )


