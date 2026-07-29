

def register_intelligence(app):


    from app.intelligence_center.api.routes import intel_api


    app.register_blueprint(
    intel_api
    )


    print(
    "✓ INTELLIGENCE CENTER ENABLED"
    )



