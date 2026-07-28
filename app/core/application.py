from flask import Flask
from flask_cors import CORS


def create_app():

    app = Flask(__name__)


    app.config.from_mapping(
        SQLALCHEMY_DATABASE_URI="sqlite:///muteb_soc.db",
        SQLALCHEMY_TRACK_MODIFICATIONS=False
    )


    CORS(app)


    # Database
    try:
        from app.database.database import db

        db.init_app(app)

    except Exception as e:
        print("Database init warning:", e)



    # APIs
    try:

        from app.api.frontend_api import frontend_api
        app.register_blueprint(frontend_api)

    except Exception as e:
        print("Frontend API warning:", e)



    try:

        from app.api.soc import soc
        app.register_blueprint(soc)

    except Exception as e:
        print("SOC API warning:", e)



    # Create tables

    try:

        from app.database.database import db

        with app.app_context():
            db.create_all()

    except Exception as e:
        print("Database tables warning:", e)



    return app
