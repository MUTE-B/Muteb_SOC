

def register_dashboard(app):


    from app.cyber_dashboard.api.routes import dashboard_api


    app.register_blueprint(

    dashboard_api

    )


    print(

    "✓ CYBER VISUALIZATION DASHBOARD ENABLED"

    )



