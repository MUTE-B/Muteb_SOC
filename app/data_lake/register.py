

def register_data_lake(app):


    from app.data_lake.api.routes import lake_api


    app.register_blueprint(

    lake_api

    )


    print(

    "✓ SECURITY DATA LAKE ENABLED"

    )



