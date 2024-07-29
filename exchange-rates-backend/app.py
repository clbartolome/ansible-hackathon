from flask import Flask, jsonify, request
import json
import os
from flask_cors import CORS

app = Flask(__name__)

# Enable CORS for all routes
CORS(app)

# Load app rates from file
def load_app_rates():
    with open('app_rates.json', 'r') as file:
        return json.load(file)

# Load bce rates from file
def load_bce_rates():
    with open('bce_rates.json', 'r') as file:
        return json.load(file)

# Save exchange rates to file
def save_app_rates(app_rates):
    with open('app_rates.json', 'w') as file:
        json.dump(app_rates, file, indent=4)

app_rates = load_app_rates()
bce_rates = load_bce_rates()

@app.route('/app_rates', methods=['GET'])
def get_app_rates():
    return jsonify(app_rates)

@app.route('/bce_rates/<currency>', methods=['GET'])
def get_bce_rate(currency):
    rate = next((item for item in bce_rates if item["currency"] == currency), None)
    if rate:
        return jsonify(rate)
    else:
        return jsonify({"error": "Currency not found"}), 404

@app.route('/app_rates', methods=['PUT'])
def update_exchange_rate():
    data = request.json
    currency = data.get('currency')
    new_value = data.get('value')
    new_limit = data.get('limit')
    new_title = data.get('title')

    for rate in app_rates:
        if rate['currency'] == currency:
            if new_value is not None:
                rate['value'] = new_value
            if new_limit is not None:
                rate['limit'] = new_limit
            if new_title is not None:
                rate['title'] = new_title
            save_app_rates(app_rates)
            return jsonify({"message": "Exchange rate updated successfully"}), 200

    return jsonify({"error": "Currency not found"}), 404

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)