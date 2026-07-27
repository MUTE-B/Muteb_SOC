

from datetime import datetime



class EnterpriseDashboard:



    def summary(self):


        return {


            "platform":
            "MUTEB SOC Enterprise",


            "status":
            "ONLINE",


            "time":
            str(datetime.utcnow()),



            "metrics":

            {


            "alerts":
            0,


            "incidents":
            0,


            "detections":
            0,


            "threats":
            0


            }



        }





    def health(self):


        return {


            "engine":
            "ACTIVE",


            "database":
            "CONNECTED",


            "api":
            "ONLINE",


            "status":
            "HEALTHY"


        }





enterprise_dashboard=EnterpriseDashboard()

