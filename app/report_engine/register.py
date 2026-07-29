

def register_reports(app):


    from app.report_engine.api.routes import report_api


    app.register_blueprint(

    report_api

    )


    print(

    "✓ REPORT ENGINE ENABLED"

    )



