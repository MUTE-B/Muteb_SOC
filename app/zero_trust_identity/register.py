

def register_zero_trust(app):


    from app.zero_trust_identity.api.routes import zt_api


    app.register_blueprint(

    zt_api

    )


    print(

    "✓ ZERO TRUST IDENTITY CENTER ENABLED"

    )



