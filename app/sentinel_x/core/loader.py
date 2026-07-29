

def load_sentinel(app):

    try:

        from app.sentinel_x.api.routes import sentinel_api


        app.register_blueprint(
            sentinel_api
        )


        print(
            "✓ MUTEB SENTINEL X ENABLED"
        )


    except Exception as error:


        print(
            "Sentinel Load Error:",
            error
        )



