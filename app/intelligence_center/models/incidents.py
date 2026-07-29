

from datetime import datetime



class Incident:


    def __init__(self,name):


        self.name=name

        self.status="NEW"

        self.time=datetime.utcnow()



    def data(self):


        return {


        "incident":self.name,


        "status":self.status,


        "time":str(self.time)


        }



