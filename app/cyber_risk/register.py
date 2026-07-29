

def register_cyber_risk(app):


    from app.cyber_risk.api.routes import risk_api


    app.register_blueprint(risk_api)


    print(

    "✓ CYBER RISK INTELLIGENCE ENABLED"

    )


