

from datetime import datetime



class Organization:



    organizations=[]



    def create(self,name,industry):


        org={


        "id":

        len(self.organizations)+1,


        "name":

        name,


        "industry":

        industry,


        "status":

        "ACTIVE",


        "created":

        str(datetime.utcnow())


        }


        self.organizations.append(org)


        return org




    def list(self):


        return self.organizations



