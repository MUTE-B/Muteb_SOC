

from datetime import datetime



class AuditLogger:


    def record(self,action,user):


        return {


        "action":

        action,


        "user":

        user,


        "time":

        str(datetime.utcnow()),


        "status":

        "RECORDED"


        }



