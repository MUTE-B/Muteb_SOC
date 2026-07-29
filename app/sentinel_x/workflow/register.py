

def register_workflow(app):


    from app.sentinel_x.api.workflow_routes import workflow_api


    app.register_blueprint(

        workflow_api

    )


    print(
    "✓ SENTINEL WORKFLOW ENABLED"
    )



