

def enable_sentinel(app):


    from app.sentinel_x.register import register_sentinel


    register_sentinel(app)


    try:


        from app.sentinel_x.api.health_route import health_api


        app.register_blueprint(
            health_api
        )


    except Exception as e:

        print(e)



