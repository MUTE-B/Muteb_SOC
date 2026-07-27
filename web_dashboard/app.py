#!/usr/bin/env python3

#
# ==========================================================
# MUTEB SOC
# Web Dashboard API
# ==========================================================
#

from flask import Flask, jsonify
import os
import json
import datetime


app = Flask(__name__)


@app.route("/")
def home():

    return jsonify({

        "project":
        "MUTEB SOC",

        "version":
        "v1.3",

        "status":
        "running"

    })



@app.route("/api/status")
def status():

    return jsonify({

        "hostname":
        os.uname().nodename,

        "time":
        str(datetime.datetime.now()),

        "service":
        "MUTEB SOC API"

    })



@app.route("/api/reports")
def reports():

    report_file="reports/detection_results.json"


    if os.path.exists(report_file):

        with open(report_file) as file:

            return jsonify(
                json.load(file)
            )


    return jsonify({

        "message":
        "No reports available"

    })



if __name__ == "__main__":

    app.run(

        host="0.0.0.0",

        port=5000

    )

