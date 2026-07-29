

from datetime import datetime



class ReportEngine:



    def create(self,target,result):


        return {


        "platform":
        "MUTEB SOC",

        "target":
        target,

        "generated":
        str(datetime.now()),

        "report":
        result


        }

