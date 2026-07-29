

from .domain_engine import DomainEngine

from .dns_engine import DNSEngine

from .port_engine import PortEngine




class AssetEngine:



    def scan(self,domain):


        asset=DomainEngine().analyze(domain)


        dns=DNSEngine().scan(domain)


        ports=[]


        if asset.get("ip"):

            ports=PortEngine().scan(
                asset["ip"]
            )



        return {

        "target":domain,

        "asset":asset,

        "dns":dns,

        "ports":ports

        }

