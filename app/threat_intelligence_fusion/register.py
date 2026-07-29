

def register_threat_intelligence(app):


    from app.threat_intelligence_fusion.api.routes import ti_api


    app.register_blueprint(

    ti_api

    )


    print(

    "✓ THREAT INTELLIGENCE FUSION ENABLED"

    )



