
import re


def scan_ioc(text):

    findings = []


    ips = re.findall(
        r"(?:\d{1,3}\.){3}\d{1,3}",
        text
    )


    domains = re.findall(
        r"[a-zA-Z0-9.-]+\.(?:com|net|org|io)",
        text
    )


    for ip in ips:

        findings.append({

            "type":
            "IP_ADDRESS",

            "value":
            ip,

            "severity":
            "MEDIUM"

        })


    for domain in domains:

        findings.append({

            "type":
            "DOMAIN",

            "value":
            domain,

            "severity":
            "MEDIUM"

        })


    return findings
