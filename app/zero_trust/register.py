

def register_zero_trust(app):


    from app.zero_trust.api.routes import zero_api


    app.register_blueprint(zero_api)


    print(

    "✓ ZERO TRUST ARCHITECTURE ENABLED"

    )


