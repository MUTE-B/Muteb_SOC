

def register_final_dashboard(app):


    from app.final_dashboard.api.routes import dashboard_api


    app.register_blueprint(dashboard_api)


    print(

    "✓ FINAL COMMAND DASHBOARD ENABLED"

    )


