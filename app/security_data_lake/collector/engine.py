

from datetime import datetime



class LogCollector:



    def collect(self,source,message):


        return {


        "source":

        source,


        "message":

        message,


        "timestamp":

        str(datetime.utcnow()),


        "status":

        "COLLECTED"



        }



