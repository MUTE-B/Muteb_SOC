

def register_security_reporting(app):


    from app.security_reporting.api.routes import reporting_api


    app.register_blueprint(reporting_api)


    print(

    "✓ SECURITY REPORTING ENABLED"

    )


