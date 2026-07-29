

from datetime import datetime



class AuditLogger:



    logs=[]



    def record(self,user,action,target):


        event={


        "user":
        user,


        "action":
        action,


        "target":
        target,


        "time":
        str(datetime.utcnow())



        }


        self.logs.append(event)


        return event



    def all(self):


        return self.logs



