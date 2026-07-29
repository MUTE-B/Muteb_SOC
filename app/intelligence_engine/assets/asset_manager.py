

from datetime import datetime



class AssetManager:



    assets=[]



    def register(self,target,organization):


        asset={


        "id":

        len(self.assets)+1,


        "target":

        target,


        "organization":

        organization,


        "status":

        "AUTHORIZED",


        "created":

        str(datetime.utcnow())


        }


        self.assets.append(asset)


        return asset




    def list(self):


        return self.assets



