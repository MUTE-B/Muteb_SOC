

def register_deployment(app):


    from deployment.api.routes import deployment_api


    app.register_blueprint(

    deployment_api

    )


    print(

    "✓ DEPLOYMENT PLATFORM ENABLED"

    )



