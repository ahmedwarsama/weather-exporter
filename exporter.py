import requests
import os
from flask import Flask, Response
from prometheus_client import Gauge, generate_latest, CONTENT_TYPE_LATEST


app = Flask(__name__)
current_temp_metric = Gauge("current_temp", "Current Temperature", ["scale"])

def get_current_temp():
    city = os.getenv("CITY")
    api_key = os.getenv("KEY")
    r =  requests.get(f"http://api.weatherapi.com/v1/current.json?key={api_key}&q={city}")
    data = r.json()
    current_temp = data["current"]["temp_c"]
    return current_temp

def update_metric():
    current_temp = get_current_temp()
    current_temp_metric.labels(scale="celsius").set(current_temp)
    return current_temp_metric

@app.route('/metrics')
def metrics():
    update_metric()
    data = generate_latest()
    return Response(data, mimetype=CONTENT_TYPE_LATEST)

if __name__ == '__main__':
    app.run(host="0.0.0.0", port="9500", debug=True)
