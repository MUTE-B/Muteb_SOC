
from flask import Flask, jsonify

from flask_cors import CORS


app = Flask(__name__)

CORS(app)



# ==========================
# SECURITY HEADERS
# ==========================

@app.after_request
def security_headers(response):

    response.headers["X-Frame-Options"]="DENY"
    response.headers["X-Content-Type-Options"]="nosniff"
    response.headers["Referrer-Policy"]="strict-origin-when-cross-origin"
    response.headers["Content-Security-Policy"]="default-src 'self'"
    response.headers["Strict-Transport-Security"]="max-age=31536000; includeSubDomains"

    return response



# ==========================
# AUTH BLUEPRINT
# ==========================

try:

    from api.auth_api import auth_api

    app.register_blueprint(
        auth_api
    )

    print("AUTH LOADED")

except Exception as e:

    print("AUTH ERROR:",e)



# ==========================
# SCANNER V2 BLUEPRINT
# ==========================

try:

    from api.scanner_v2_api import scanner_v2_bp

    app.register_blueprint(
        scanner_v2_bp,
        url_prefix="/api/scanner/v2"
    )

    print("SCANNER V2 LOADED")


except Exception as e:

    print("SCANNER ERROR:",e)



# ==========================
# HEALTH
# ==========================

@app.route("/health")
def health():

    return jsonify({

        "status":"ONLINE",
        "system":"MUTEB SOC Enterprise"

    })



# ==========================
# DASHBOARD
# ==========================

@app.route("/api/dashboard")
def dashboard():

    return jsonify({

        "active_users":1,
        "critical_alerts":1,
        "open_incidents":1,
        "threat_score":85

    })



# ==========================

@app.route("/")
def index():

    return jsonify({

        "system":"MUTEB SOC Enterprise",
        "status":"running"

    })



if __name__=="__main__":

    app.run(
        host="0.0.0.0",
        port=8000,
        debug=False
    )

