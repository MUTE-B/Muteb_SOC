

from datetime import datetime



class ReportGenerator:



    def security_report(self,data):


        return {


        "report_type":

        "Security Assessment Report",


        "platform":

        "MUTEB SOC Enterprise",


        "asset":

        data.get("asset"),


        "risk":

        data.get("risk","LOW"),


        "score":

        data.get("score",92),


        "recommendation":

        data.get(

        "recommendation",

        "Maintain security controls"

        ),


        "created":

        str(datetime.utcnow())



        }





    def executive_report(self,data):


        return {


        "report_type":

        "Executive Cyber Risk Report",


        "summary":

        data.get(

        "summary",

        "Security posture analyzed"

        ),


        "priority":

        data.get(

        "priority",

        "NORMAL"

        ),


        "created":

        str(datetime.utcnow())



        }



