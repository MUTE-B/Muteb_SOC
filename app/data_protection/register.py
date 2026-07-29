

def register_data_protection(app):


    from app.data_protection.api.routes import data_protection_api


    app.register_blueprint(data_protection_api)


    print(

    "✓ DATA PROTECTION CENTER ENABLED"

    )


