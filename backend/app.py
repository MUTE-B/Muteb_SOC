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

