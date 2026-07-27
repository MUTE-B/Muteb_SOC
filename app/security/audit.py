

from datetime import datetime


class AuditLogger:


    def log(
        self,
        user,
        action,
        resource
    ):


        return {


            "user":
            user,


            "action":
            action,


            "resource":
            resource,


            "time":
            str(datetime.utcnow()),


            "status":
            "SUCCESS"

        }



audit_logger = AuditLogger()

