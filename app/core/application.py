from flask import Flask, jsonify
from flask_cors import CORS
from flask_jwt_extended import JWTManager

from app.auth.auth import auth
from app.api.soc import soc



def create_app():

    app = Flask(__name__)


    CORS(app)


    app.config["JWT_SECRET_KEY"] = "MUTEB_SOC_SECRET_2026"


    JWTManager(app)



    app.register_blueprint(auth)

    app.register_blueprint(soc)



    @app.route("/")
    def home():

        return jsonify({

            "platform": "MUTEB SOC Enterprise",

            "status": "ONLINE",

            "version": "3.1.0"

        })



    @app.route("/api/status")
    def status():

        return jsonify({

            "backend": "ONLINE",

            "database": "READY",

            "security_engine": "RUNNING"

        })



    

    with app.app_context():

        from app.database.database import db

        db.create_all()


    return app

    

