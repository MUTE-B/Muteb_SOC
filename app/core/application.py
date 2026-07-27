from flask import Flask, jsonify
from flask_cors import CORS

from app.core.logger import logger
from app.core.config import Config

from app.database.database import db

from app.auth.jwt import jwt

from app.auth.auth import auth

from app.api.security import security
from app.api.detection import detection

from app.api.dashboard import dashboard
from app.api.dashboard_statistics import dashboard_statistics

from app.api.alerts import alerts
from app.api.incidents import incident

from app.api.collector import collector_api

from app.api.investigation import investigation
from app.api.integrations import integrations
from app.api.system import system
from app.api.siem import siem
from app.api.product import product
from app.config.settings import settings
from app.docs.swagger import swagger

from app.api.threat import threat

from app.api.threat_intel import threat_intel

from app.api.pipeline import detection_pipeline
from app.api.intelligence import intelligence
from app.api.response import response_api
from app.api.soc_dashboard import soc_dashboard
from app.api.audit import audit
from app.api.storage import storage
from app.api.risk import risk
from app.api.hunting import hunting
from app.api.malware import malware
from app.api.intel import intel
from app.api.detection_rules import detection_rules
from app.api.soar import soar
from app.api.cases import cases
from app.api.release import release
from app.api.demo import demo
from app.api.executive import executive
from app.api.compliance import compliance
from app.api.ai_security import ai_security
from app.api.reports import reports
from app.api.notification import notification
from app.api.assets import assets
from app.api.integration import integration
from app.api.showcase import showcase
from app.api.security_review import security_review
from app.api.workspace import workspace
from app.api.version import version_api
from app.api.enterprise import enterprise
from app.api.rbac import rbac
from app.api.realtime import realtime
from app.api.correlation import correlation
from app.api.mitre import mitre
from app.security.headers import security_headers
from app.security.production import production_headers



def create_app():


    app = Flask(__name__)

    app.register_blueprint(swagger, url_prefix='/docs')


    app.config.from_object(Config)


    CORS(app)

    app.after_request(security_headers)


    db.init_app(app)


    jwt.init_app(app)



    # Authentication

    app.register_blueprint(
        auth,
        url_prefix="/api/auth"
    )



    # Security Events

    app.register_blueprint(
        security,
        url_prefix="/api/security"
    )



    # Detection Engine

    app.register_blueprint(
        detection,
        url_prefix="/api/detection"
    )



    # Dashboard

    app.register_blueprint(
        dashboard,
        url_prefix="/api/dashboard"
    )


    app.register_blueprint(
        dashboard_statistics,
        url_prefix="/api/dashboard"
    )



    # Alerts

    app.register_blueprint(
        alerts,
        url_prefix="/api/alerts"
    )



    # Incidents

    app.register_blueprint(
        incident,
        url_prefix="/api/incidents"
    )

    app.register_blueprint(
    collector_api,
    url_prefix="/api/collector"


    )



    # Investigation

    app.register_blueprint(
        siem,
        url_prefix="/api/siem"
    )


    app.register_blueprint(
        product,
        url_prefix="/api/product"
    )


    app.register_blueprint(
        workspace,
        url_prefix="/api/workspace"
    )


    app.register_blueprint(
        security_review,
        url_prefix="/api/security-review"
    )


    app.register_blueprint(
        showcase,
        url_prefix="/api/showcase"
    )


    app.register_blueprint(
        system,
        url_prefix="/api/system"
    )


    app.register_blueprint(
        integrations,
        url_prefix="/api/integrations"
    )


    app.register_blueprint(
        investigation,
        url_prefix="/api/investigation"
    )



    # Threat Analysis

    app.register_blueprint(
        threat,
        url_prefix="/api/threat"
    )



    # Threat Intelligence

    app.register_blueprint(
        threat_intel,
        url_prefix="/api/threat-intel"
    )



    # Detection Pipeline

    app.register_blueprint(
        detection_pipeline,
        url_prefix="/api/pipeline"
    )

    app.register_blueprint(
        assets,
        url_prefix="/api/assets"
    )


    app.register_blueprint(
        notification,
        url_prefix="/api/notification"
    )


    app.register_blueprint(
        reports,
        url_prefix="/api/reports"
    )


    app.register_blueprint(
        ai_security,
        url_prefix="/api/ai"
    )


    app.register_blueprint(
        compliance,
        url_prefix="/api/compliance"
    )


    app.register_blueprint(
        executive,
        url_prefix="/api/executive"
    )


    app.register_blueprint(
        demo,
        url_prefix="/api/demo"
    )


    app.register_blueprint(
        release,
        url_prefix="/api/release"
    )


    app.register_blueprint(
        cases,
        url_prefix="/api/cases"
    )


    app.register_blueprint(
        soar,
        url_prefix="/api/soar"
    )


    app.register_blueprint(
        detection_rules,
        url_prefix="/api/detection-rules"
    )


    app.register_blueprint(
        intelligence,
        url_prefix="/api/intelligence"
    )


    app.register_blueprint(
        response_api,
        url_prefix="/api/response"
    )


    app.register_blueprint(
        soc_dashboard,
        url_prefix="/api/soc"
    )


    app.register_blueprint(
        malware,
        url_prefix="/api/malware"
    )


    app.register_blueprint(
        hunting,
        url_prefix="/api/hunting"
    )


    app.register_blueprint(
        risk,
        url_prefix="/api/risk"
    )


    app.register_blueprint(
        storage,
        url_prefix="/api/storage"
    )


    app.register_blueprint(
        audit,
        url_prefix="/api/audit"
    )


    

    app.register_blueprint(
        enterprise,
        url_prefix="/api/enterprise"
    )


    app.register_blueprint(
        version_api,
        url_prefix="/api/version"
    )









    @app.after_request

    def secure_response(response):

        return production_headers(response)



    with app.app_context():

        db.create_all()



    @app.route("/")
    def home():

        return jsonify({

            "platform":
            "MUTEB SOC Enterprise",

            "version":
            "3.1.0",

            "status":
            "ONLINE"

        })



    return app


    app.register_blueprint(
        rbac,
        url_prefix="/api/rbac"
    )


    app.register_blueprint(
        realtime,
        url_prefix="/api/realtime"
    )


    app.register_blueprint(
        correlation,
        url_prefix="/api/correlation"
    )



    app.register_blueprint(
        mitre,
        url_prefix="/api/mitre"
    )

