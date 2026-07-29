

def register_master_control(app):


    from app.master_control.api.routes import master_api


    app.register_blueprint(master_api)


    print(

    "✓ MASTER CONTROL CENTER ENABLED"

    )


