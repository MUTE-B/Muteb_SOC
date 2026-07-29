

def register_attack_surface(app):


    from app.attack_surface.api.routes import surface_api


    app.register_blueprint(

    surface_api

    )


    print(

    "✓ ATTACK SURFACE INTELLIGENCE ENABLED"

    )



