

from datetime import datetime



class AttackSurfaceEngine:



    def analyze(self,asset):


        return {


        "asset":

        asset,


        "exposure":

        "MONITORED",


        "internet_visibility":

        "CONTROLLED",


        "external_risk":

        "LOW",


        "checked":

        str(datetime.utcnow())



        }





    def inventory(self):


        return {


        "total_assets":

        0,


        "web_assets":

        0,


        "api_assets":

        0,


        "cloud_assets":

        0



        }



