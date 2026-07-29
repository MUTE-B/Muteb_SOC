

class EvidenceManager:



    evidence=[]



    def upload(self,item):


        record={


        "evidence":

        item,


        "status":

        "COLLECTED"



        }


        self.evidence.append(record)


        return record



