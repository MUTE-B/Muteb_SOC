

def register_sentinel(app):


    try:

        from app.sentinel_x.api.routes import sentinel_api

        app.register_blueprint(
            sentinel_api
        )


        print(
        "SENTINEL X API REGISTERED"
        )


    except Exception as e:

        print(
        "Sentinel registration error:",
        e
        )


