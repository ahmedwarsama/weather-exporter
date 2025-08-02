FROM python:3.12
WORKDIR /opt/weather-exporter

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY exporter.py ./exporter.py
EXPOSE 9500

CMD ["python3", "exporter.py"]

