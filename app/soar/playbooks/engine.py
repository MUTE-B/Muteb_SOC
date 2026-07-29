

class PlaybookEngine:



    def execute(self,event):


        severity=event.get(

        "severity",

        "LOW"

        )



        if severity=="CRITICAL":


            action="Start incident response"



        elif severity=="HIGH":


            action="Create investigation case"



        else:


            action="Monitor event"



        return {


        "playbook":

        "Security Response Playbook",


        "trigger":

        severity,


        "action":

        action,


        "status":

        "COMPLETED"



        }



