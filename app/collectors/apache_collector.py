

from app.collectors.linux_collector import linux_collector



class ApacheCollector:



    def collect(self):


        return linux_collector.read_file(

            "/var/log/apache2/access.log"

        )




apache_collector=ApacheCollector()

