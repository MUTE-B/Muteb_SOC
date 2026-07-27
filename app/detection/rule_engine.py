
from app.detection.ioc_scanner import scan_ioc


def run_detection(event):

    results = []


    message = event.get(
        "message",
        ""
    )


    iocs = scan_ioc(
        message
    )


    for item in iocs:

        results.append({

            "detection":
            "IOC_MATCH",

            "indicator":
            item["value"],

            "severity":
            item["severity"],

            "mitre":
            "T1071 - Application Layer Protocol"

        })


    return results
