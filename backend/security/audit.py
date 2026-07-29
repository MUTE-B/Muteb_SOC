
import json
import datetime
import os


def write_audit(event,user="system"):

    os.makedirs(
        "logs",
        exist_ok=True
    )

    record={

    "time":
    str(datetime.datetime.now()),

    "user":
    user,

    "event":
    event

    }


    with open(
    "logs/audit.log",
    "a"
    ) as f:

        f.write(
        json.dumps(record)
        +"\n"
        )


