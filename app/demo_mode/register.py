

def register_demo(app):


    from app.demo_mode.api.routes import demo_api


    app.register_blueprint(

    demo_api

    )


    print(

    "✓ DEMO SHOWCASE MODE ENABLED"

    )



