
def analyze_event(event):

    alerts = []


    if event["severity"] == "HIGH":

        alerts.append({

            "alert":
            "Suspicious Authentication Activity",

            "level":
            "HIGH",

            "event":
            event

        })


    return alerts
