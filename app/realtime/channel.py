

from datetime import datetime



LIVE_EVENTS=[]



def publish(event):


    message={


        "id":

        len(LIVE_EVENTS)+1,


        "event":

        event,


        "priority":

        event.get("severity","LOW"),


        "timestamp":

        str(datetime.utcnow())

    }


    LIVE_EVENTS.append(message)


    return message




def stream():


    return LIVE_EVENTS[-50:]

