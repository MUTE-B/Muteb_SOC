

def register_risk_intelligence(app):


    from app.risk_intelligence.api.routes import risk_api


    app.register_blueprint(risk_api)


    print(

    "✓ RISK INTELLIGENCE CENTER ENABLED"

    )


