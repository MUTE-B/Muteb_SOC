
from datetime import datetime


class CaseManager:


    def create(self,event,technique):

        return {

            "case_id":
            "CASE-"+datetime.now().strftime("%Y%m%d%H%M%S"),


            "event":
            event,


            "technique":
            technique,


            "status":
            "OPEN"

        }



case_manager=CaseManager()

