

class UserManager:



    users=[]



    def create(self,name,role):


        user={


        "username":

        name,


        "role":

        role,


        "status":

        "ACTIVE"



        }


        self.users.append(user)


        return user




    def list(self):


        return self.users



