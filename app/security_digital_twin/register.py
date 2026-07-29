

def register_security_digital_twin(app):


    from app.security_digital_twin.api.routes import twin_api


    app.register_blueprint(twin_api)


    print(

    "✓ SECURITY DIGITAL TWIN ENABLED"

    )


