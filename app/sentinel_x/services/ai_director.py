

class AISecurityDirector:


    def advise(self,risk):


        if risk>=80:

            return {

            "priority":"HIGH",

            "decision":
            "Immediate security action recommended"

            }


        return {

        "priority":"NORMAL",

        "decision":
        "Continue monitoring"

        }



