

from datetime import datetime



class EnterpriseAudit:



    logs=[]



    def record(self,user,action,organization):


        self.logs.append({


        "user":

        user,


        "action":

        action,


        "organization":

        organization,


        "time":

        str(datetime.utcnow())


        })



        return True




    def history(self):


        return self.logs



