

from datetime import datetime



REQUEST_LOG=[]



def receive_event(data):


    event={


        "source":

        data.get("source","external"),


        "type":

        data.get("type","EVENT"),


        "payload":

        data.get("payload"),


        "received":

        str(datetime.utcnow())

    }



    REQUEST_LOG.append(event)


    return event




def history():


    return REQUEST_LOG

