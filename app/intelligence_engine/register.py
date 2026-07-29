

def register_intelligence(app):


    from app.intelligence_engine.api.routes import intel_api


    app.register_blueprint(

    intel_api

    )


    print(

    "✓ SECURITY INTELLIGENCE ENGINE ENABLED"

    )



