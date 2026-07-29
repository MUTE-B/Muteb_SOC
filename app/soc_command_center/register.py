

def register_soc_center(app):


    from app.soc_command_center.api.routes import soc_dashboard


    app.register_blueprint(

    soc_dashboard

    )


    print(

    "✓ SOC COMMAND CENTER ENABLED"

    )



