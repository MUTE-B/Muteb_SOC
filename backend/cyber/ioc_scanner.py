

import re


def scan(text):


    indicators=[]


    ips=re.findall(

    r"\b\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}\b",

    text

    )


    hashes=re.findall(

    r"\b[a-fA-F0-9]{32,64}\b",

    text

    )


    indicators.extend(ips)

    indicators.extend(hashes)


    return indicators


