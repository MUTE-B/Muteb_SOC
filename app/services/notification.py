
import smtplib
from email.message import EmailMessage

class NotificationService:

    def email(self,to,subject,message):

        return {
            "status":"queued",
            "type":"email",
            "to":to,
            "subject":subject
        }

    def telegram(self,message):

        return {
            "status":"queued",
            "type":"telegram",
            "message":message
        }
