

def register_monitoring(app):


    from app.continuous_monitoring.api.routes import monitor_api


    app.register_blueprint(

    monitor_api

    )


    print(

    "✓ CONTINUOUS MONITORING ENABLED"

    )



