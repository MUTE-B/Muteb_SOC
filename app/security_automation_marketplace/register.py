

def register_security_automation(app):


    from app.security_automation_marketplace.api.routes import automation_api


    app.register_blueprint(

    automation_api

    )


    print(

    "✓ SECURITY AUTOMATION MARKETPLACE ENABLED"

    )



