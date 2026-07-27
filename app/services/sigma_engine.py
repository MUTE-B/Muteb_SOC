
class SigmaEngine:


    def detect(self,event):

        rules=[]


        if "failed login" in event.lower():

            rules.append(
                "SSH_BRUTE_FORCE"
            )


        if "powershell" in event.lower():

            rules.append(
                "SUSPICIOUS_POWERSHELL"
            )


        return rules



sigma_engine = SigmaEngine()

