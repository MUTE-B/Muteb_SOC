

def register_threat_intelligence(app):


    from app.threat_intelligence.api.routes import intel_api


    app.register_blueprint(intel_api)


    print(

    "✓ THREAT INTELLIGENCE FUSION ENABLED"

    )


