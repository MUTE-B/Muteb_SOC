

def register_release_engineering(app):


    from app.release_engineering.api.routes import release_api


    app.register_blueprint(

    release_api

    )


    print(

    "✓ RELEASE ENGINEERING ENABLED"

    )



