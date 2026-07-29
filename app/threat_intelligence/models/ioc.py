

from datetime import datetime



class IOCManager:



    indicators=[]



    def add(

        self,

        indicator,

        indicator_type,

        severity

    ):


        item={


        "id":

        len(self.indicators)+1,


        "indicator":

        indicator,


        "type":

        indicator_type,


        "severity":

        severity,


        "status":

        "MONITORING",


        "created":

        str(datetime.utcnow())


        }



        self.indicators.append(item)


        return item




    def list(self):


        return self.indicators



