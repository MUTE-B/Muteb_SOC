

from app.storage.database import (

save_alert,

get_data

)



class AlertRepository:



    def create(self,data):


        return save_alert(data)



    def all(self):


        return get_data(

            "alerts"

        )



alert_repository=AlertRepository()

