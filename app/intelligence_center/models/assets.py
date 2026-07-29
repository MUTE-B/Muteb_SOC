

from datetime import datetime



class SecurityAsset:


    def __init__(self,name,asset_type):


        self.name=name

        self.type=asset_type

        self.status="MONITORED"

        self.created=datetime.utcnow()



    def info(self):


        return {


        "asset":self.name,


        "type":self.type,


        "status":self.status,


        "created":str(self.created)


        }



