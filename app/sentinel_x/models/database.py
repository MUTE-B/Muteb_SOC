
from datetime import datetime

try:
    from app.extensions import db
except:
    db = None



class SentinelOrganization:

    __tablename__ = "sentinel_organizations"


    def __init__(self,name):

        self.name=name

        self.created_at=datetime.utcnow()



class SentinelAsset:

    __tablename__="sentinel_assets"


    def __init__(self,target):

        self.target=target

        self.status="active"

        self.score=0

        self.created_at=datetime.utcnow()



class SentinelRisk:


    __tablename__="sentinel_risks"


    def __init__(self,asset,level):

        self.asset=asset

        self.level=level

        self.status="OPEN"

        self.created_at=datetime.utcnow()



class SentinelAudit:


    __tablename__="sentinel_audit"


    def __init__(self,user,action):

        self.user=user

        self.action=action

        self.time=datetime.utcnow()


