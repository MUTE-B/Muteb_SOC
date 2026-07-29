

def register_cloud_security(app):


    from app.cloud_security.api.routes import cloud_api


    app.register_blueprint(cloud_api)


    print(

    "✓ CLOUD SECURITY COMMAND CENTER ENABLED"

    )


