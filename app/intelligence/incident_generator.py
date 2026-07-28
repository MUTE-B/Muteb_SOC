
from datetime import datetime



class IncidentGenerator:



    def create(self,event,result):


        return {


        "incident_id":
        "INC-"+datetime.now().strftime("%H%M%S"),


        "event":
        event,


        "severity":
        result["analysis"],


        "status":
        "Investigation Active"



        }

