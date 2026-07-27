#!/usr/bin/env python3

from flask import Flask, jsonify, request
from access_logger import log_access
from security_headers import apply_security_headers
import os
import json


app = Flask(__name__)

@app.before_request
def monitor_access():
    log_access(
        request.remote_addr,
        request.path
    )


app.after_request(apply_security_headers)


@app.route("/api/alerts")
def alerts():

    file = "reports/security_alerts.json"

    if os.path.exists(file):

        with open(file) as f:

            return jsonify(
                json.load(f)
            )

    return jsonify([])



@app.route("/api/metrics")
def metrics():

    file = "reports/system_metrics.json"

    if os.path.exists(file):

        with open(file) as f:

            return jsonify(
                json.load(f)
            )

    return jsonify({

        "message":
        "No metrics available"

    })



@app.route("/api/health")
def health():

    return jsonify({

        "service":
        "MUTEB SOC",

        "status":
        "healthy"

    })



if __name__ == "__main__":

    app.run(

        host="0.0.0.0",

        port=5000

    )

