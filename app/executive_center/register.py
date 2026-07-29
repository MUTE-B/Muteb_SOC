

def register_executive(app):


    from app.executive_center.api.routes import executive_api


    app.register_blueprint(

    executive_api

    )


    print(

    "✓ EXECUTIVE CENTER ENABLED"

    )



