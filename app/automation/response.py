

from datetime import datetime



def create_response(alert):


    score=alert.get(

        "score",

        0

    )


    action="MONITOR"



    if score >= 80:

        action="CREATE_INCIDENT"



    return {


        "engine":

        "MUTEB Automated Response",


        "action":

        action,


        "alert":

        alert,


        "time":

        str(datetime.utcnow())

    }

