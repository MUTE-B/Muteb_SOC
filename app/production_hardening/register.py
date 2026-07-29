

def register_production_hardening(app):


    from app.production_hardening.api.routes import hardening_api


    app.register_blueprint(

    hardening_api

    )


    print(

    "✓ PRODUCTION HARDENING ENABLED"

    )



