

def register_threat_fusion(app):


    from app.threat_fusion.api.routes import intel_api


    app.register_blueprint(

    intel_api

    )


    print(

    "✓ THREAT INTELLIGENCE FUSION ENABLED"

    )



