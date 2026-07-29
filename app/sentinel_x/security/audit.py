

from datetime import datetime


def audit(user,action):

    return {

    "user":user,

    "action":action,

    "time":str(datetime.utcnow())

    }



