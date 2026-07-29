from flask import Flask, jsonify
from flask_cors import CORS

app = Flask(__name__)

CORS(app)


@app.route("/api/status")
def status():

    return jsonify({

        "soc":"ONLINE",
        "ai":"ACTIVE",
        "threat":"READY",
        "automation":"ENABLED",
        "cloud":"CONNECTED",
        "risk":"LOW"

    })


@app.route("/")
def home():

    return "MUTEB SOC ENTERPRISE API RUNNING"


if __name__ == "__main__":

    app.run(
        host="0.0.0.0",
        port=8000
    )



@app.route("/api/dashboard", methods=["GET"])
def dashboard():
    return {
        "critical_alerts": 0,
        "open_incidents": 1,
        "threat_score": 80
    }
