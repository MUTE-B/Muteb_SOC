

from datetime import datetime


class IncidentResponse:


    def create_incident(self, threat, severity, event):


        return {


            "title":
            threat.get("name"),


            "category":
            threat.get("category"),


            "mitre":
            threat.get("mitre"),


            "severity":
            severity.get("severity"),


            "score":
            severity.get("score"),


            "status":
            "OPEN",


            "event":
            event,


            "created":
            str(datetime.utcnow())

        }



incident_response = IncidentResponse()

