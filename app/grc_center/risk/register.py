

from datetime import datetime



class RiskRegister:



    risks=[]



    def add(self,name,level):


        risk={


        "risk":

        name,


        "level":

        level,


        "status":

        "OPEN",


        "date":

        str(datetime.utcnow())



        }


        self.risks.append(risk)


        return risk





    def list(self):


        return self.risks



