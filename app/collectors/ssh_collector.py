

from app.collectors.linux_collector import linux_collector



class SSHCollector:



    def collect(self):


        return linux_collector.read_file(

            "/var/log/auth.log"

        )




ssh_collector=SSHCollector()

