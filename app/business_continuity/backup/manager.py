

from datetime import datetime



class BackupManager:



    backups=[]



    def create(self,system):


        backup={


        "system":

        system,


        "type":

        "FULL BACKUP",


        "status":

        "COMPLETED",


        "time":

        str(datetime.utcnow())



        }


        self.backups.append(backup)


        return backup



    def list(self):


        return self.backups



