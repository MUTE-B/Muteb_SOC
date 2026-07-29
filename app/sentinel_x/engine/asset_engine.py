

from datetime import datetime



class AssetEngine:



    def register_asset(self,target):


        return {


        "asset":target,


        "type":
        self.detect_type(target),


        "status":
        "MONITORED",


        "created":
        str(datetime.utcnow())


        }




    def detect_type(self,target):


        if "api" in target.lower():

            return "API"


        if "cloud" in target.lower():

            return "CLOUD"


        return "WEB APPLICATION"




