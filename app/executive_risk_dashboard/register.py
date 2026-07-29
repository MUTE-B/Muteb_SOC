

def register_executive_dashboard(app):


    from app.executive_risk_dashboard.api.routes import executive_api


    app.register_blueprint(

    executive_api

    )


    print(

    "✓ EXECUTIVE CYBER RISK DASHBOARD ENABLED"

    )



