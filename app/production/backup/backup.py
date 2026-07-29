

from datetime import datetime



class BackupManager:



    def create(self,name):


        return {


        "backup":

        name,


        "status":

        "CREATED",


        "time":

        str(datetime.utcnow())


        }



