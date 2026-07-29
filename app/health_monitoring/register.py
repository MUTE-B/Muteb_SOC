

def register_health_monitoring(app):


    from app.health_monitoring.api.routes import health_api


    app.register_blueprint(health_api)


    print(

    "✓ HEALTH MONITORING ENABLED"

    )


