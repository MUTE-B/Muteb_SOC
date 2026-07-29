

from datetime import datetime



class AlertEngine:



    def create(self,title,severity):


        return {


        "alert":

        title,


        "severity":

        severity,


        "time":

        str(datetime.utcnow()),


        "status":

        "OPEN"


        }



