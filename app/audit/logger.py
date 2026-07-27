

from datetime import datetime



AUDIT_LOG=[]



def create_audit(

    user,

    action,

    resource

):


    event={


        "user":user,


        "action":action,


        "resource":resource,


        "time":str(datetime.utcnow()),


        "status":"SUCCESS"


    }


    AUDIT_LOG.append(event)


    return event



def get_audit():


    return AUDIT_LOG


