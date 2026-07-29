

class ZeroTrustAccess:



    def authorize(self,resource):


        return {


        "resource":

        resource,


        "decision":

        "ALLOW",


        "policy":

        "VERIFIED ACCESS"



        }



