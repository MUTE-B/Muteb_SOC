

def register_security_data_lake(app):


    from app.security_data_lake.api.routes import data_api


    app.register_blueprint(data_api)


    print(

    "✓ SECURITY DATA LAKE ENABLED"

    )


