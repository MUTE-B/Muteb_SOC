

def register_all_sentinel(app):


    modules=[]



    try:


        from app.sentinel_x.api.routes import sentinel_api

        app.register_blueprint(
        sentinel_api
        )

        modules.append(
        "Core API"
        )

    except Exception as e:

        print(e)



    try:


        from app.sentinel_x.api.workflow_routes import workflow_api

        app.register_blueprint(
        workflow_api
        )

        modules.append(
        "Workflow"
        )


    except Exception as e:

        print(e)



    try:


        from app.sentinel_x.api.report_routes import report_api

        app.register_blueprint(
        report_api
        )


        modules.append(
        "Reports"
        )


    except Exception as e:

        print(e)



    try:


        from app.sentinel_x.api.final_routes import final_api

        app.register_blueprint(
        final_api
        )


        modules.append(
        "Enterprise API"
        )


    except Exception as e:

        print(e)



    print(
    "✓ SENTINEL X MODULES:"
    ,
    modules
    )



