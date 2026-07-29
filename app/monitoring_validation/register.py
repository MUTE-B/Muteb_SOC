

def register_monitoring_validation(app):


    from app.monitoring_validation.api.routes import monitor_api


    app.register_blueprint(monitor_api)


    print(

    "✓ MONITORING VALIDATION ENABLED"

    )

