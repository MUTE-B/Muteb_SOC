

class ZeroTrustPolicy:



    def evaluate(self,risk):


        if risk > 70:


            decision="DENY"



        else:


            decision="ALLOW"



        return {


        "decision":

        decision,


        "policy":

        "Zero Trust Enforcement",


        "continuous_check":

        True



        }



