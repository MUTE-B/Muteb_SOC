

def register_workspace(app):


    from app.intelligence_center.api.workspace_routes import workspace_api


    app.register_blueprint(

    workspace_api

    )


    print(
    "✓ SOC ANALYST WORKSPACE ENABLED"
    )



