

from datetime import datetime


DATABASE = {


    "alerts":[],

    "incidents":[],

    "events":[]


}



def save_alert(alert):

    alert["created_at"]=str(datetime.utcnow())

    DATABASE["alerts"].append(alert)

    return alert




def save_incident(incident):

    incident["created_at"]=str(datetime.utcnow())

    DATABASE["incidents"].append(incident)

    return incident




def save_event(event):

    event["created_at"]=str(datetime.utcnow())

    DATABASE["events"].append(event)

    return event



def get_data(name):

    return DATABASE.get(

        name,

        []

    )

