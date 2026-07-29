

from datetime import datetime



class AuditLogger:



    logs=[]



    def record(self,action,user):


        entry={


        "action":

        action,


        "user":

        user,


        "time":

        str(datetime.utcnow())



        }


        self.logs.append(entry)


        return entry



