

def register_executive(app):


    from app.executive_portal.api.routes import executive_api


    app.register_blueprint(

    executive_api

    )


    print(

    "✓ EXECUTIVE CYBER RISK PORTAL ENABLED"

    )



