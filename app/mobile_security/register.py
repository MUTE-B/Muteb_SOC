

def register_mobile_security(app):


    from app.mobile_security.api.routes import mobile_api


    app.register_blueprint(mobile_api)


    print(

    "✓ MOBILE SECURITY COMMAND CENTER ENABLED"

    )


