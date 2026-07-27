FROM python:3.12-slim

WORKDIR /opt/muteb-soc

COPY . .

RUN pip install --no-cache-dir -r requirements.txt

RUN chmod +x muteb_soc.sh

CMD ["./muteb_soc.sh"]
