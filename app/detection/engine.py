

from app.detection.rules.database import get_rules



def detect(event):


    matches=[]



    for rule in get_rules():


        if rule["status"]!="ACTIVE":

            continue



        if rule["condition"] in str(event):


            matches.append({


                "rule":

                rule["name"],


                "severity":

                rule["severity"],


                "type":

                rule["type"]

            })



    return matches

