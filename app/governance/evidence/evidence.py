

from datetime import datetime



class EvidenceManager:



    records=[]



    def add(self,item):


        record={


        "evidence":

        item,


        "date":

        str(datetime.utcnow()),


        "status":

        "VALIDATED"



        }


        self.records.append(record)


        return record



    def all(self):


        return self.records



