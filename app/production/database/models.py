

from datetime import datetime



class EnterpriseRecord:



    def __init__(self,record_type,data):


        self.type=record_type

        self.data=data

        self.created=datetime.utcnow()



    def export(self):


        return {


        "type":self.type,


        "data":self.data,


        "created":

        str(self.created)



        }



