from flask import Flask, request, jsonify
from flask_cors import CORS

app = Flask(__name__)
CORS(app)


USERS = {
    "admin": {
        "password": "admin123",
        "role": "Admin"
    },
    "analyst": {
        "password": "analyst123",
        "role": "Analyst"
    }
}


@app.route("/api/login", methods=["POST"])
def login():

    data = request.get_json()

    username = data.get("username")
    password = data.get("password")

    if username in USERS and USERS[username]["password"] == password:

        return jsonify({
            "success": True,
            "user": {
                "username": username,
                "role": USERS[username]["role"]
            }
        })

    return jsonify({
        "success": False
    }), 401



@app.route("/api/dashboard")
def dashboard():

    return jsonify({
        "critical_alerts": 1,
        "open_incidents": 1,
        "threat_score": 85
    })


@app.route("/")
def home():
    return "MUTEB SOC BACKEND ONLINE"



if __name__ == "__main__":
    app.run(
        host="0.0.0.0",
        port=8000
    )
