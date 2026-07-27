

from datetime import datetime



NOTIFICATIONS=[]



def send_notification(channel,message):


    event={


        "channel":

        channel,


        "message":

        message,


        "status":

        "SENT",


        "time":

        str(datetime.utcnow())

    }


    NOTIFICATIONS.append(event)


    return event




def history():


    return NOTIFICATIONS

