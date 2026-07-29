

from datetime import datetime



class BaseEntity:



    def __init__(self):


        self.created_at=datetime.utcnow()

        self.updated_at=datetime.utcnow()



    def update(self):


        self.updated_at=datetime.utcnow()



