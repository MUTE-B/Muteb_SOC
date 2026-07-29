
from datetime import datetime


def create_case(title,severity):

    return {

        "case_id":"CASE-001",

        "title":title,

        "severity":severity,

        "status":"OPEN",

        "created":str(datetime.utcnow())

    }



def execute_playbook(action):


    playbooks={


        "block_ip":
        {
        "action":"IP BLOCK",
        "status":"SIMULATED"
        },


        "disable_user":
        {
        "action":"USER DISABLE",
        "status":"SIMULATED"
        },


        "collect_logs":
        {
        "action":"LOG COLLECTION",
        "status":"ACTIVE"
        }


    }


    return playbooks.get(
        action,
        {
        "action":"UNKNOWN",
        "status":"FAILED"
        }
    )


