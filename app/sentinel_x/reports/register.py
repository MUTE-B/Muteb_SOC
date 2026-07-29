

def register_reports(app):


    from app.sentinel_x.api.report_routes import report_api


    app.register_blueprint(

        report_api

    )


    print(

    "✓ SENTINEL REPORTING ENABLED"

    )


