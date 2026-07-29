

def register_unified_fabric(app):


    from app.unified_fabric.api.routes import fabric_api


    app.register_blueprint(fabric_api)


    print(

    "✓ UNIFIED INTELLIGENCE FABRIC ENABLED"

    )


