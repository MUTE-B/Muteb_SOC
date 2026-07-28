#!/usr/bin/env python3

from flask import Flask, jsonify, render_template, request
from flask_cors import CORS
from auth import require_auth
import os
import json
import datetime


app = Flask(__name__)
CORS(app)
CORS(app, resources={r"/*": {"origins": "*"}})



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



@app.route("/api/login", methods=["POST"])
def login():

    from auth import check_auth

    data = request.get_json()

    username = data.get("username")
    password = data.get("password")


    if check_auth(username, password):

        return jsonify({

            "status":"success",
            "username":username,
            "role":"SOC Analyst",
            "token":"MUTEB-SOC-TOKEN"

        })


    return jsonify({

        "status":"failed",
        "message":"Invalid username or password"

    }),401



if __name__ == "__main__":

    app.run(
        host="0.0.0.0",
        port=5000
    )



