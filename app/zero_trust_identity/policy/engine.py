

class ZeroTrustPolicy:



    def evaluate(self,user,device):


        trusted=False



        if user and device:


            trusted=True



        return {


        "user":

        user,


        "device":

        device,


        "access":

        "ALLOW" if trusted else "DENY",


        "model":

        "ZERO TRUST"



        }



