
import yaml
import os


RULE_PATH="cyber/sigma"


def load_rules():

    rules=[]

    if os.path.exists(RULE_PATH):

        for f in os.listdir(RULE_PATH):

            if f.endswith(".yml"):

                rules.append(f)

    return rules



def analyze(event):

    findings=[]


    if event.get(
    "severity"
    )=="HIGH":

        findings.append({

        "rule":
        "HIGH_SEVERITY_EVENT",

        "status":
        "DETECTED"

        })


    return findings

