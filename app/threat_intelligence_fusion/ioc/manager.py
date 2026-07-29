

class IOCManager:



    indicators=[]



    def add(self,value,type):


        ioc={


        "value":

        value,


        "type":

        type,


        "status":

        "ACTIVE"



        }


        self.indicators.append(ioc)


        return ioc




    def list(self):


        return self.indicators



