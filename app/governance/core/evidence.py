

class EvidenceManager:



    evidence=[]



    def add(self,item,owner):


        record={


        "evidence":

        item,


        "owner":

        owner,


        "verification":

        "PENDING"



        }


        self.evidence.append(record)


        return record



    def all(self):


        return self.evidence



