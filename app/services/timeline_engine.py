

from datetime import datetime


class TimelineEngine:


    def create_event(
        self,
        action,
        details
    ):


        return {

            "time":
            str(datetime.utcnow()),

            "action":
            action,

            "details":
            details

        }




timeline_engine=TimelineEngine()

