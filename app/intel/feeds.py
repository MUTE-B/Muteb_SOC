

from datetime import datetime



THREAT_FEEDS=[]



def add_feed(feed):


    feed["updated"]=str(datetime.utcnow())


    THREAT_FEEDS.append(feed)


    return feed




def get_feeds():


    return THREAT_FEEDS

