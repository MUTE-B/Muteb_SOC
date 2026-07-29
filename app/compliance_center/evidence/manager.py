

class EvidenceManager:



    evidence=[]



    def add(self,item):


        self.evidence.append(item)


        return {


        "evidence":

        item,


        "status":

        "REGISTERED"



        }



    def list(self):


        return self.evidence



