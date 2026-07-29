

from datetime import datetime



class IncidentManager:



    stages=[


    "Detected",

    "Investigating",

    "Contained",

    "Resolved",


    "Closed"


    ]



    def create(self,title):


        return {


        "incident":

        title,


        "stage":

        "Detected",


        "created":

        str(datetime.utcnow())



        }



