

from app.models.incident import Incident
from app.models.alert import Alert



class DashboardMetrics:


    def summary(self):


        incidents = Incident.query.count()

        alerts = Alert.query.count()



        critical = Alert.query.filter_by(
            severity="CRITICAL"
        ).count()



        high = Alert.query.filter_by(
            severity="HIGH"
        ).count()



        return {


            "total_incidents":
            incidents,


            "total_alerts":
            alerts,


            "critical_alerts":
            critical,


            "high_alerts":
            high,


            "platform":
            "MUTEB SOC Enterprise"


        }



metrics = DashboardMetrics()

