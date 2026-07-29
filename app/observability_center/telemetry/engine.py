

from datetime import datetime



class TelemetryEngine:



    def event(self,name):


        return {


        "event":

        name,


        "time":

        str(datetime.utcnow()),


        "source":

        "MUTEB PLATFORM"



        }



