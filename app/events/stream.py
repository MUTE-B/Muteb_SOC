

from datetime import datetime



EVENT_STREAM=[]



def add_event(event):


    record={


        "id":

        len(EVENT_STREAM)+1,


        "event":

        event,


        "time":

        str(datetime.utcnow())

    }


    EVENT_STREAM.append(record)


    return record




def get_events():


    return EVENT_STREAM



