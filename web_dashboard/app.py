#!/usr/bin/env python3

from flask import Flask, jsonify, render_template
import os
import json
import datetime


app = Flask(__name__)



@app.route("/")
def home():

    return render_template("index.html")



@app.route("/api/status")
def status():

    return jsonify({

        "project":
        "MUTEB SOC",

        "version":
        "v1.3",

        "hostname":
        os.uname().nodename,

        "time":
        str(datetime.datetime.now()),

        "status":
        "Running"

    })



@app.route("/api/reports")
def reports():

    file="reports/detection_results.json"


    if os.path.exists(file):

        with open(file) as f:

            return jsonify(json.load(f))


    return jsonify({

        "message":
        "No detection reports"

    })



if __name__ == "__main__":

    app.run(
        host="0.0.0.0",
        port=5000
    )

