

from datetime import datetime



class IOCManager:



    indicators=[]



    def add(self,ioc_type,value):


        item={


        "type":

        ioc_type,


        "value":

        value,


        "status":

        "ACTIVE",


        "created":

        str(datetime.utcnow())



        }


        self.indicators.append(item)


        return item




    def list(self):


        return self.indicators



