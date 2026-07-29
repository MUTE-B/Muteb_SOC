

def register_disaster_recovery(app):


    from app.disaster_recovery.api.routes import dr_api


    app.register_blueprint(dr_api)


    print(

    "✓ DISASTER RECOVERY ENABLED"

    )

