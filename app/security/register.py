

def register_security(app):


    from app.security.api.routes import security_api


    app.register_blueprint(security_api)


    print(

    "✓ SECURITY OPERATIONS ENABLED"

    )


