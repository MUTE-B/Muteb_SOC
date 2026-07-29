

from flask import Blueprint,jsonify


from app.notification_intelligence.alerts.engine import AlertEngine

from app.notification_intelligence.escalation.engine import EscalationEngine

from app.notification_intelligence.channels.manager import ChannelManager



notification_api=Blueprint(

"notification_intelligence",

__name__,

url_prefix="/api/notifications"

)



alerts=AlertEngine()

escalation=EscalationEngine()

channels=ChannelManager()



@notification_api.route("/create")
def create_alert():


    return jsonify(

    alerts.create(

    "Suspicious Activity",

    "HIGH"

    )

    )



@notification_api.route("/escalate")
def escalate_alert():


    return jsonify(

    escalation.escalate(

    "SOC LEVEL 1"

    )

    )



@notification_api.route("/channels")
def notification_channels():


    return jsonify(

    channels.channels()

    )



