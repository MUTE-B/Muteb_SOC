
from pathlib import Path
from datetime import datetime


AUTH_LOG = "/var/log/auth.log"


def collect_auth_logs():

    events = []

    path = Path(AUTH_LOG)

    if not path.exists():

        return events


    lines = path.read_text(
        errors="ignore"
    ).splitlines()


    for line in lines[-100:]:

        if "Failed password" in line:

            events.append({

                "event_type":
                "SSH_FAILED_LOGIN",

                "severity":
                "HIGH",

                "message":
                line,

                "time":
                str(datetime.now())

            })


        elif "Accepted password" in line:

            events.append({

                "event_type":
                "SSH_SUCCESS_LOGIN",

                "severity":
                "LOW",

                "message":
                line,

                "time":
                str(datetime.now())

            })


    return events
