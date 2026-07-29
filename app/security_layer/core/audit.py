

from datetime import datetime



class SecurityAudit:



    logs=[]



    def record(self,user,action):


        self.logs.append({


        "user":

        user,


        "action":

        action,


        "time":

        str(datetime.utcnow()),


        "status":

        "RECORDED"



        })



        return self.logs[-1]



