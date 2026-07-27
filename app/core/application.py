
from flask import Flask,jsonify
from flask_cors import CORS

from app.core.logger import logger

from app.database.database import db

from app.auth.auth import auth

from app.api.security import security
from app.api.detection import detection
from app.api.dashboard import dashboard
from app.api.dashboard_statistics import dashboard_statistics
from app.api.alerts import alerts
from app.api.incidents import incident


def create_app():

    app=Flask(__name__)

    app.config["SQLALCHEMY_DATABASE_URI"]="sqlite:///muteb_soc.db"

    app.config["SQLALCHEMY_TRACK_MODIFICATIONS"]=False

    CORS(app)

    db.init_app(app)

    app.register_blueprint(auth,url_prefix="/api/auth")

    app.register_blueprint(security,url_prefix="/api/security")

    app.register_blueprint(detection,url_prefix="/api/detection")

    app.register_blueprint(dashboard,url_prefix="/api/dashboard")

    app.register_blueprint(
        dashboard_statistics,
        url_prefix="/api/dashboard"
    )

    app.register_blueprint(
        alerts,
        url_prefix="/api/alerts"
    )

    app.register_blueprint(
        incident,
        url_prefix="/api/incidents"
    )

    with app.app_context():
        db.create_all()

    @app.route("/")
    def home():

        return jsonify({

            "platform":"MUTEB SOC Enterprise",

            "version":"3.0.0",

            "status":"ONLINE"

        })

    return app
