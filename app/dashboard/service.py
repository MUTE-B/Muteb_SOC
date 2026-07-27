
from app.models.incident import Incident

def dashboard_summary():

    try:
        total_incidents=Incident.query.count()
    except:
        total_incidents=0

    return {

        "platform":"MUTEB SOC Enterprise",

        "version":"3.0.0",

        "system_status":"ONLINE",

        "total_incidents":total_incidents,

        "modules":{

            "authentication":"ONLINE",

            "monitoring":"ONLINE",

            "detection":"ONLINE",

            "threat_hunting":"ONLINE",

            "incident_response":"ONLINE"

        }

    }
