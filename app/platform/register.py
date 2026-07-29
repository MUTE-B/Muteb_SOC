

def register_platform(app):


    from app.platform.api.routes import platform_api


    app.register_blueprint(platform_api)


    print(

    "✓ PLATFORM LAYER ENABLED"

    )


