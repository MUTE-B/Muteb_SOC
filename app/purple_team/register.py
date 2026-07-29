

def register_purple_team(app):


    from app.purple_team.api.routes import purple_api


    app.register_blueprint(

    purple_api

    )


    print(

    "✓ PURPLE TEAM CENTER ENABLED"

    )



