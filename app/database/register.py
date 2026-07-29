

def register_database(app):


    from app.database.routes import database_api


    app.register_blueprint(

    database_api

    )


    print(

    "✓ DATABASE LAYER ENABLED"

    )


