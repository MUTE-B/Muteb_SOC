

from datetime import datetime



class ExecutiveReport:



    def generate(self,data):


        return {


        "title":

        "MUTEB SOC Executive Security Report",


        "summary":

        data,


        "generated":

        str(datetime.utcnow())



        }



