
from app.models.incident import Incident

def statistics():

    try:

        incidents=Incident.query.all()

    except:

        incidents=[]

    total=len(incidents)

    critical=sum(1 for i in incidents if i.severity=="CRITICAL")
    high=sum(1 for i in incidents if i.severity=="HIGH")
    medium=sum(1 for i in incidents if i.severity=="MEDIUM")
    low=sum(1 for i in incidents if i.severity=="LOW")

    open_cases=sum(1 for i in incidents if i.status=="OPEN")
    closed_cases=sum(1 for i in incidents if i.status=="CLOSED")

    return{

        "total":total,

        "critical":critical,

        "high":high,

        "medium":medium,

        "low":low,

        "open":open_cases,

        "closed":closed_cases

    }
