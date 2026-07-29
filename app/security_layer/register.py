

def register_security_layer(app):


    from app.security_layer.api.routes import security_api


    app.register_blueprint(

    security_api

    )


    print(

    "✓ ENTERPRISE SECURITY LAYER ENABLED"

    )



