

from flask import Flask

from app.api.master_routes import master_api


app=Flask(__name__)


app.register_blueprint(master_api)



@app.route("/")

def home():

    return {


    "system":

    "MUTEB SOC ENTERPRISE",

    "status":

    "ONLINE"


    }



if __name__=="__main__":

    app.run(

    host="0.0.0.0",

    port=5000

    )

