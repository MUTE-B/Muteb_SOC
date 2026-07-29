

def register_surface(app):


    from app.intelligence_center.api.surface_routes import surface_api


    app.register_blueprint(

    surface_api

    )


    print(
    "✓ ATTACK SURFACE ENABLED"
    )



