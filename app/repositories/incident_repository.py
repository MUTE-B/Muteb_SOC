

from app.storage.database import (

save_incident,

get_data

)



class IncidentRepository:



    def create(self,data):


        return save_incident(data)



    def all(self):


        return get_data(

            "incidents"

        )



incident_repository=IncidentRepository()

