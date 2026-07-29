

def register_security_analytics(app):


    from app.security_analytics.api.routes import analytics_api


    app.register_blueprint(analytics_api)


    print(

    "✓ SECURITY ANALYTICS CENTER ENABLED"

    )


