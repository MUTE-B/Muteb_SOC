

def register_ndr_center(app):


    from app.ndr_center.api.routes import ndr_api


    app.register_blueprint(ndr_api)


    print(

    "✓ NDR CENTER ENABLED"

    )


