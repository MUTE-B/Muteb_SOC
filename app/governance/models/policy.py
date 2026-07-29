

from datetime import datetime



class PolicyManager:



    policies=[]



    def add(self,name,framework):


        policy={


        "id":

        len(self.policies)+1,


        "name":

        name,


        "framework":

        framework,


        "status":

        "ACTIVE",


        "created":

        str(datetime.utcnow())


        }


        self.policies.append(policy)


        return policy



    def list(self):


        return self.policies



